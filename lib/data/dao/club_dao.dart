import 'package:sqflite/sqflite.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../models/club_model.dart';

abstract class ClubDao {
  Future<Either<Failure, int>> insert(ClubModel club);
  Future<Either<Failure, List<ClubModel>>> getAll();
  Future<Either<Failure, int>> delete(int id);
}

class ClubDaoImpl implements ClubDao {
  final Database db;

  ClubDaoImpl(this.db);

  Future<Either<Failure, int>> insert(ClubModel club) async {
    try {
      final id = await db.insert('clubs', club.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ClubModel>>> getAll() async {
    try {
      final result = await db.query('clubs');
      return Right(result.map((e) => ClubModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> delete(int id) async {
    try {
      final result = await db.delete('clubs', where: 'id = ?', whereArgs: [id]);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
