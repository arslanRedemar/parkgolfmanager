import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/club_model.dart';
import '../../domain/repositories/club_repository.dart';

abstract class GetAllClubsUseCase {
  Future<Either<Failure, List<ClubModel>>> call();
}

class GetAllClubs implements GetAllClubsUseCase {
  final ClubRepository repository;
  GetAllClubs(this.repository);
  @override
  Future<Either<Failure, List<ClubModel>>> call() {
    return repository.getAllClubs();
  }
}