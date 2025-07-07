import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:parkgolf/data/dao/member_dao.dart';
import 'package:parkgolf/data/models/member_model.dart';

void main() {
  late Database db;
  late MemberDao dao;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT,
        birthdate TEXT,
        gender TEXT,
        address TEXT,
        club_id INTEGER,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    dao = MemberDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and getAll members', () async {
    final member = MemberModel(name: '홍길동');
    final insertResult = await dao.insert(member);
    expect(insertResult.isRight(), true);

    final members = await dao.getAll();
    expect(members.getOrElse(() => []).length, 1);
  });

  test('delete member', () async {
    final id = await dao
        .insert(MemberModel(name: '삭제인'))
        .then((e) => e.getOrElse(() => -1));
    final deleted = await dao.delete(id);
    expect(deleted.getOrElse(() => 0), 1);
  });
}
