import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:parkgolf/data/dao/club_dao.dart';
import 'package:parkgolf/data/models/club_model.dart';
import 'package:parkgolf/di.dart';

void main() {
  late Database db;
  late ClubDao dao;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE clubs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        region TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    dao = sl<ClubDao>();
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and getAll clubs', () async {
    final club = ClubModel(name: '테스트클럽');
    final insertResult = await dao.insert(club);
    expect(insertResult.isRight(), true);

    final allClubs = await dao.getAll();
    expect(allClubs.isRight(), true);
    expect(allClubs.getOrElse(() => []).length, 1);
  });

  test('delete club', () async {
    final club = ClubModel(name: '삭제클럽');
    final id = await dao.insert(club).then((e) => e.getOrElse(() => -1));
    final deleteResult = await dao.delete(id);
    expect(deleteResult.getOrElse(() => 0), 1);
  });
}
