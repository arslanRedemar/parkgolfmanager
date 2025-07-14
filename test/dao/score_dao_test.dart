import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:parkgolf/data/dao/score_dao.dart';
import 'package:parkgolf/data/models/score_model.dart';

import 'package:parkgolf/di.dart';

void main() {
  late Database db;
  late ScoreDao dao;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        member_id INTEGER NOT NULL,
        tournament_id INTEGER NOT NULL,
        strokes INTEGER NOT NULL,
        memo TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    dao = sl<ScoreDao>();
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and getByMember', () async {
    final score = ScoreModel(memberId: 1, tournamentId: 1, strokes: 70);
    await dao.insert(score);
    final result = await dao.getByMember(1);
    expect(result.getOrElse(() => []).length, 1);
  });

  test('delete score', () async {
    final id = await dao
        .insert(ScoreModel(memberId: 2, tournamentId: 2, strokes: 80))
        .then((e) => e.getOrElse(() => -1));
    final result = await dao.delete(id);
    expect(result.getOrElse(() => 0), 1);
  });
}
