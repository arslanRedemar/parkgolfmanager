import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/member_model.dart';
import '../../domain/repositories/member_repository.dart';

abstract class GetAllMembersUseCase {
  Future<Either<Failure, List<MemberModel>>> call();
}

class GetAllMembers implements GetAllMembersUseCase {
  final MemberRepository repository;
  GetAllMembers(this.repository);
  @override
  Future<Either<Failure, List<MemberModel>>> call() {
    return repository.getAllMembers();
  }
}