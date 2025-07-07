import 'package:sqflite/sqflite.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../models/tournament_model.dart';

abstract class TournamentDao {
  Future<Either<Failure, int>> insert(TournamentModel tournament);
  Future<Either<Failure, List<TournamentModel>>> getAll();
  Future<Either<Failure, int>> delete(int id);
}

class TournamentDaoImpl implements TournamentDao {
  final Database db;

  TournamentDaoImpl(this.db);

  Future<Either<Failure, int>> insert(TournamentModel tournament) async {
    try {
      final id = await db.insert('tournaments', tournament.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<TournamentModel>>> getAll() async {
    try {
      final result = await db.query('tournaments');
      return Right(result.map((e) => TournamentModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> delete(int id) async {
    try {
      final result = await db.delete(
        'tournaments',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
