import 'package:sqflite/sqflite.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../models/member_model.dart';

abstract class MemberDao {
  Future<Either<Failure, int>> insert(MemberModel member);
  Future<Either<Failure, List<MemberModel>>> getAll();
  Future<Either<Failure, List<MemberModel>>> getByClub(int clubId);
  Future<Either<Failure, int>> delete(int id);
}

class MemberDaoImpl implements MemberDao {
  final Database db;

  MemberDaoImpl(this.db);

  Future<Either<Failure, int>> insert(MemberModel member) async {
    try {
      final id = await db.insert('members', member.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<MemberModel>>> getAll() async {
    try {
      final result = await db.query('members');
      return Right(result.map((e) => MemberModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<MemberModel>>> getByClub(int clubId) async {
    try {
      final result = await db.query(
        'members',
        where: 'club_id = ?',
        whereArgs: [clubId],
      );
      return Right(result.map((e) => MemberModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> delete(int id) async {
    try {
      final result = await db.delete(
        'members',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
