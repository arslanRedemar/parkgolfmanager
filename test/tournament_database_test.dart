import 'package:flutter_test/flutter_test.dart';
import 'package:parkgolf/data/database/localDB/localDatabase.dart';
import 'package:parkgolf/data/models/tournament_model.dart';
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

  test('insert and getAllTournaments', () async {
    final tournament = TournamentModel(name: '7월 대회', date: '2025-07-01');
    final result = await db.insertTournament(tournament);

    expect(result.isRight(), true);

    final all = await db.getAllTournaments();
    expect(all.getOrElse(() => []).any((t) => t.name == '7월 대회'), true);
  });

  test('deleteTournament', () async {
    final tournament = TournamentModel(name: '삭제 대회', date: '2025-07-02');
    final id = await db
        .insertTournament(tournament)
        .then((e) => e.getOrElse(() => -1));
    final result = await db.deleteTournament(id);
    expect(result.getOrElse(() => 0), 1);
  });
}
