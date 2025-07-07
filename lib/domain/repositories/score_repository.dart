import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/score_model.dart';
import '../../data/dao/score_dao.dart';

abstract class ScoreRepository {
  Future<Either<Failure, int>> insertScore(ScoreModel score);
  Future<Either<Failure, List<ScoreModel>>> getScoresByMember(int memberId);
  Future<Either<Failure, List<ScoreModel>>> getScoresByTournament(int tournamentId);
  Future<Either<Failure, int>> deleteScore(int id);
}

class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreDao dao;

  ScoreRepositoryImpl(this.dao);

  @override
  Future<Either<Failure, int>> insertScore(ScoreModel score) => dao.insert(score);

  @override
  Future<Either<Failure, List<ScoreModel>>> getScoresByMember(int memberId) => dao.getByMember(memberId);

  @override
  Future<Either<Failure, List<ScoreModel>>> getScoresByTournament(int tournamentId) => dao.getByTournament(tournamentId);

  @override
  Future<Either<Failure, int>> deleteScore(int id) => dao.delete(id);
}