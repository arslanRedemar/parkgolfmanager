import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../domain/repositories/club_repository.dart';

abstract class DeleteClubUseCase {
  Future<Either<Failure, int>> call(int id);
}

class DeleteClub implements DeleteClubUseCase {
  final ClubRepository repository;
  DeleteClub(this.repository);
  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteClub(id);
  }
}