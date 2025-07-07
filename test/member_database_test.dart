import 'package:flutter_test/flutter_test.dart';
import 'package:parkgolf/data/database/localDB/localDatabase.dart';
import 'package:parkgolf/data/models/club_model.dart';
import 'package:parkgolf/data/models/member_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SqfliteDatabase db;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = SqfliteDatabase();
    await db.database;
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and getAllMembers', () async {
    final club = ClubModel(name: '클럽M');
    final clubId = await db.insertClub(club).then((e) => e.getOrElse(() => -1));

    final member = MemberModel(name: '홍길동', clubId: clubId);
    final result = await db.insertMember(member);

    expect(result.isRight(), true);
  });

  test('getMembersByClub returns correct members', () async {
    final club = ClubModel(name: '클럽X');
    final clubId = await db.insertClub(club).then((e) => e.getOrElse(() => -1));
    final member = MemberModel(name: '이순신', clubId: clubId);
    await db.insertMember(member);

    final members = await db.getMembersByClub(clubId);
    expect(members.isRight(), true);
    expect(members.getOrElse(() => []).any((m) => m.name == '이순신'), true);
  });

  test('deleteMember deletes member', () async {
    final clubId = await db
        .insertClub(ClubModel(name: '클럽Z'))
        .then((e) => e.getOrElse(() => -1));
    final id = await db
        .insertMember(MemberModel(name: '삭제맨', clubId: clubId))
        .then((e) => e.getOrElse(() => -1));
    final deleted = await db.deleteMember(id);
    expect(deleted.getOrElse(() => 0), 1);
  });
}
