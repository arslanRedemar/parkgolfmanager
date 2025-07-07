import 'package:flutter_test/flutter_test.dart';
import 'package:parkgolf/data/database/localDB/localDatabase.dart';
import 'package:parkgolf/data/models/club_model.dart';
import 'package:parkgolf/data/models/member_model.dart';
import 'package:parkgolf/data/models/score_model.dart';
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

  test('insert and getScoresByMember', () async {
    final clubId = await db
        .insertClub(ClubModel(name: '스코어클럽'))
        .then((e) => e.getOrElse(() => -1));
    final memberId = await db
        .insertMember(MemberModel(name: '스코어맨', clubId: clubId))
        .then((e) => e.getOrElse(() => -1));
    final tournamentId = await db
        .insertTournament(TournamentModel(name: '8월 대회', date: '2025-08-01'))
        .then((e) => e.getOrElse(() => -1));

    final score = ScoreModel(
      memberId: memberId,
      tournamentId: tournamentId,
      strokes: 72,
    );
    final result = await db.insertScore(score);
    expect(result.isRight(), true);

    final scores = await db.getScoresByMember(memberId);
    expect(scores.getOrElse(() => []).any((s) => s.strokes == 72), true);
  });

  test('getScoresByTournament returns correct data', () async {
    final clubId = await db
        .insertClub(ClubModel(name: '대회클럽'))
        .then((e) => e.getOrElse(() => -1));
    final memberId = await db
        .insertMember(MemberModel(name: '대회참가자', clubId: clubId))
        .then((e) => e.getOrElse(() => -1));
    final tournamentId = await db
        .insertTournament(TournamentModel(name: '9월 대회', date: '2025-09-01'))
        .then((e) => e.getOrElse(() => -1));

    await db.insertScore(
      ScoreModel(memberId: memberId, tournamentId: tournamentId, strokes: 66),
    );

    final scores = await db.getScoresByTournament(tournamentId);
    expect(scores.getOrElse(() => []).any((s) => s.strokes == 66), true);
  });

  test('deleteScore works', () async {
    final clubId = await db
        .insertClub(ClubModel(name: '삭제클럽'))
        .then((e) => e.getOrElse(() => -1));
    final memberId = await db
        .insertMember(MemberModel(name: '삭제인', clubId: clubId))
        .then((e) => e.getOrElse(() => -1));
    final tournamentId = await db
        .insertTournament(TournamentModel(name: '삭제대회', date: '2025-10-01'))
        .then((e) => e.getOrElse(() => -1));

    final scoreId = await db
        .insertScore(
          ScoreModel(
            memberId: memberId,
            tournamentId: tournamentId,
            strokes: 80,
          ),
        )
        .then((e) => e.getOrElse(() => -1));
    final deleted = await db.deleteScore(scoreId);
    expect(deleted.getOrElse(() => 0), 1);
  });
}
