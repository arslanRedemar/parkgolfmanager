import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../domain/repositories/member_repository.dart';

abstract class DeleteMemberUseCase {
  Future<Either<Failure, int>> call(int id);
}

class DeleteMember implements DeleteMemberUseCase {
  final MemberRepository repository;
  DeleteMember(this.repository);
  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteMember(id);
  }
}