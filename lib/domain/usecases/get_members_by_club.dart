import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../data/models/member_model.dart';
import '../../domain/repositories/member_repository.dart';

abstract class GetMembersByClubUseCase {
  Future<Either<Failure, List<MemberModel>>> call(int clubId);
}

class GetMembersByClub implements GetMembersByClubUseCase {
  final MemberRepository repository;
  GetMembersByClub(this.repository);
  @override
  Future<Either<Failure, List<MemberModel>>> call(int clubId) {
    return repository.getMembersByClub(clubId);
  }
}