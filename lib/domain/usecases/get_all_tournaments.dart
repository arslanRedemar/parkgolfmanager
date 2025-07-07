import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/tournament_model.dart';
import '../../domain/repositories/tournament_repository.dart';

abstract class GetAllTournamentsUseCase {
  Future<Either<Failure, List<TournamentModel>>> call();
}

class GetAllTournaments implements GetAllTournamentsUseCase {
  final TournamentRepository repository;
  GetAllTournaments(this.repository);
  @override
  Future<Either<Failure, List<TournamentModel>>> call() {
    return repository.getAllTournaments();
  }
}