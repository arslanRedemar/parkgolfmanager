import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/score_model.dart';
import '../../domain/repositories/score_repository.dart';

abstract class InsertScoreUseCase {
  Future<Either<Failure, int>> call(ScoreModel score);
}

class InsertScore implements InsertScoreUseCase {
  final ScoreRepository repository;
  InsertScore(this.repository);
  @override
  Future<Either<Failure, int>> call(ScoreModel score) {
    return repository.insertScore(score);
  }
}