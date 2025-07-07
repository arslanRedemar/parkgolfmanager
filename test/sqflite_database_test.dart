import 'package:flutter_test/flutter_test.dart';
import 'package:parkgolf/core/failure.dart';
import 'package:parkgolf/data/database/localDB/localDatabase.dart';
import 'package:parkgolf/data/models/club_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SqfliteDatabase db;

  setUpAll(() {
    sqfliteFfiInit(); // for sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = SqfliteDatabase();
    await db.database; // ensure init
  });

  tearDown(() async {
    await db.close();
  });

  test('insertClub returns inserted id on success', () async {
    final club = ClubModel(name: '테스트클럽');
    final result = await db.insertClub(club);

    expect(result.isRight(), true);
    expect(result.getOrElse(() => -1), greaterThan(0));
  });

  test('getAllClubs returns list after insertion', () async {
    final club = ClubModel(name: '클럽A');
    await db.insertClub(club);

    final result = await db.getAllClubs();

    expect(result.isRight(), true);
    expect(result.getOrElse(() => []).length, greaterThan(0));
  });

  test('deleteClub deletes the correct club', () async {
    final club = ClubModel(name: '삭제클럽');
    final idResult = await db.insertClub(club);

    final deleteResult = await db.deleteClub(idResult.getOrElse(() => -1));

    expect(deleteResult.isRight(), true);
    expect(deleteResult.getOrElse(() => -1), equals(1));
  });

  test('insertClub returns DatabaseFailure on duplicate name', () async {
    final club = ClubModel(name: '중복클럽');
    await db.insertClub(club);

    final result = await db.insertClub(club); // 중복 시도

    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<DatabaseFailure>()),
      (_) => fail('Should not succeed'),
    );
  });
}
