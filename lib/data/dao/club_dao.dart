import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:dartz/dartz.dart';
import 'package:parkgolf/data/database/localDB/localDatabase.dart';

import '../../core/failure.dart';
import '../models/club_model.dart';

abstract class ClubDao {
  Future<Either<Failure, void>> insert(ClubModel club);
  Future<Either<Failure, List<ClubModel>>> getAll();
  Future<Either<Failure, int>> delete(int id);
}

class ClubDaoImpl implements ClubDao {
  final LocalDatabase db;

  ClubDaoImpl(this.db);

  Future<Either<Failure, void>> insert(ClubModel club) async {
    try {
      final id = await db.insertClub(club);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ClubModel>>> getAll() async {
    try {
      final result = await db.getAllClubs();
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
