import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../domain/repositories/tournament_repository.dart';

abstract class DeleteTournamentUseCase {
  Future<Either<Failure, int>> call(int id);
}

class DeleteTournament implements DeleteTournamentUseCase {
  final TournamentRepository repository;
  DeleteTournament(this.repository);
  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteTournament(id);
  }
}