import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/club_model.dart';
import '../../domain/repositories/club_repository.dart';

abstract class InsertClubUseCase {
  Future<Either<Failure, int>> call(ClubModel club);
}

class InsertClub implements InsertClubUseCase {
  final ClubRepository repository;
  InsertClub(this.repository);
  @override
  Future<Either<Failure, int>> call(ClubModel club) {
    return repository.insertClub(club);
  }
}