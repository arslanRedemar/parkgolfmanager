import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:parkgolf/data/dao/tournament_dao.dart';
import 'package:parkgolf/data/models/tournament_model.dart';
import 'package:parkgolf/di.dart';

void main() {
  late Database db;
  late TournamentDao dao;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE tournaments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        location TEXT,
        note TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');

    dao = sl<TournamentDao>();
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and getAll tournaments', () async {
    final tournament = TournamentModel(name: '테스트 대회', date: '2025-08-01');
    final result = await dao.insert(tournament);
    expect(result.isRight(), true);

    final all = await dao.getAll();
    expect(all.getOrElse(() => []).length, 1);
  });

  test('delete tournament', () async {
    final id = await dao
        .insert(TournamentModel(name: '삭제 대회', date: '2025-09-01'))
        .then((e) => e.getOrElse(() => -1));
    final result = await dao.delete(id);
    expect(result.getOrElse(() => 0), 1);
  });
}
