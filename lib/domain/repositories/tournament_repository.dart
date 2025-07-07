import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/tournament_model.dart';
import '../../data/dao/tournament_dao.dart';

abstract class TournamentRepository {
  Future<Either<Failure, int>> insertTournament(TournamentModel tournament);
  Future<Either<Failure, List<TournamentModel>>> getAllTournaments();
  Future<Either<Failure, int>> deleteTournament(int id);
}

class TournamentRepositoryImpl implements TournamentRepository {
  final TournamentDao dao;

  TournamentRepositoryImpl(this.dao);

  @override
  Future<Either<Failure, int>> insertTournament(TournamentModel tournament) => dao.insert(tournament);

  @override
  Future<Either<Failure, List<TournamentModel>>> getAllTournaments() => dao.getAll();

  @override
  Future<Either<Failure, int>> deleteTournament(int id) => dao.delete(id);
}