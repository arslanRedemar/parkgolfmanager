import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/score_model.dart';
import '../../domain/repositories/score_repository.dart';

abstract class GetScoresByMemberUseCase {
  Future<Either<Failure, List<ScoreModel>>> call(int memberId);
}

class GetScoresByMember implements GetScoresByMemberUseCase {
  final ScoreRepository repository;
  GetScoresByMember(this.repository);
  @override
  Future<Either<Failure, List<ScoreModel>>> call(int memberId) {
    return repository.getScoresByMember(memberId);
  }
}