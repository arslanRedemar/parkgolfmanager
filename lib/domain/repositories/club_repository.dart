import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/club_model.dart';
import '../../data/dao/club_dao.dart';

abstract class ClubRepository {
  Future<Either<Failure, int>> insertClub(ClubModel club);
  Future<Either<Failure, List<ClubModel>>> getAllClubs();
  Future<Either<Failure, int>> deleteClub(int id);
}

class ClubRepositoryImpl implements ClubRepository {
  final ClubDao dao;

  ClubRepositoryImpl(this.dao);

  @override
  Future<Either<Failure, int>> insertClub(ClubModel club) => dao.insert(club);

  @override
  Future<Either<Failure, List<ClubModel>>> getAllClubs() => dao.getAll();

  @override
  Future<Either<Failure, int>> deleteClub(int id) => dao.delete(id);
}