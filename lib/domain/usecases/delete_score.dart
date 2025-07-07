import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../domain/repositories/score_repository.dart';

abstract class DeleteScoreUseCase {
  Future<Either<Failure, int>> call(int id);
}

class DeleteScore implements DeleteScoreUseCase {
  final ScoreRepository repository;
  DeleteScore(this.repository);
  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteScore(id);
  }
}