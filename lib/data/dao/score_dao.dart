import 'package:sqflite/sqflite.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../models/score_model.dart';

abstract class ScoreDao {
  Future<Either<Failure, int>> insert(ScoreModel score);
  Future<Either<Failure, List<ScoreModel>>> getByMember(int memberId);
  Future<Either<Failure, List<ScoreModel>>> getByTournament(int tournamentId);
  Future<Either<Failure, int>> delete(int id);
}

class ScoreDaoImpl implements ScoreDao {
  final Database db;

  ScoreDaoImpl(this.db);

  Future<Either<Failure, int>> insert(ScoreModel score) async {
    try {
      final id = await db.insert('scores', score.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ScoreModel>>> getByMember(int memberId) async {
    try {
      final result = await db.query(
        'scores',
        where: 'member_id = ?',
        whereArgs: [memberId],
      );
      return Right(result.map((e) => ScoreModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ScoreModel>>> getByTournament(
    int tournamentId,
  ) async {
    try {
      final result = await db.query(
        'scores',
        where: 'tournament_id = ?',
        whereArgs: [tournamentId],
      );
      return Right(result.map((e) => ScoreModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> delete(int id) async {
    try {
      final result = await db.delete(
        'scores',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
