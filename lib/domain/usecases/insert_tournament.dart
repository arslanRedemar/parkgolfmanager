import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/tournament_model.dart';
import '../../domain/repositories/tournament_repository.dart';

abstract class InsertTournamentUseCase {
  Future<Either<Failure, int>> call(TournamentModel tournament);
}

class InsertTournament implements InsertTournamentUseCase {
  final TournamentRepository repository;
  InsertTournament(this.repository);
  @override
  Future<Either<Failure, int>> call(TournamentModel tournament) {
    return repository.insertTournament(tournament);
  }
}