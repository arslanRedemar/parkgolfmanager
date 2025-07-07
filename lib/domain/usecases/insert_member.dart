import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/member_model.dart';
import '../../domain/repositories/member_repository.dart';

abstract class InsertMemberUseCase {
  Future<Either<Failure, int>> call(MemberModel member);
}

class InsertMember implements InsertMemberUseCase {
  final MemberRepository repository;
  InsertMember(this.repository);
  @override
  Future<Either<Failure, int>> call(MemberModel member) {
    return repository.insertMember(member);
  }
}