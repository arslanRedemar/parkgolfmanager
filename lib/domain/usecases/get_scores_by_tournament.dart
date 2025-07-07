import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/score_model.dart';
import '../../domain/repositories/score_repository.dart';

abstract class GetScoresByTournamentUseCase {
  Future<Either<Failure, List<ScoreModel>>> call(int tournamentId);
}

class GetScoresByTournament implements GetScoresByTournamentUseCase {
  final ScoreRepository repository;
  GetScoresByTournament(this.repository);
  @override
  Future<Either<Failure, List<ScoreModel>>> call(int tournamentId) {
    return repository.getScoresByTournament(tournamentId);
  }
}