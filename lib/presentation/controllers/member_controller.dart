import 'package:get/get.dart';
import '../../../core/failure.dart';
import '../../../data/models/member_model.dart';
import '../../../domain/usecases/insert_member.dart';
import '../../../domain/usecases/get_all_members.dart';
import '../../../domain/usecases/get_members_by_club.dart';
import '../../../domain/usecases/delete_member.dart';

class MemberController extends GetxController {
  final InsertMemberUseCase insertMemberUseCase;
  final GetAllMembersUseCase getAllMembersUseCase;
  final GetMembersByClubUseCase getMembersByClubUseCase;
  final DeleteMemberUseCase deleteMemberUseCase;

  MemberController({
    required this.insertMemberUseCase,
    required this.getAllMembersUseCase,
    required this.getMembersByClubUseCase,
    required this.deleteMemberUseCase,
  });

  final RxList<MemberModel> members = <MemberModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<Failure> failure = Rxn<Failure>();

  Future<void> loadMembers() async {
    isLoading.value = true;
    final result = await getAllMembersUseCase();
    result.fold(
      (l) => failure.value = l,
      (r) => members.assignAll(r),
    );
    isLoading.value = false;
  }

  Future<void> loadMembersByClub(int clubId) async {
    isLoading.value = true;
    final result = await getMembersByClubUseCase(clubId);
    result.fold(
      (l) => failure.value = l,
      (r) => members.assignAll(r),
    );
    isLoading.value = false;
  }

  Future<void> addMember(MemberModel member) async {
    final result = await insertMemberUseCase(member);
    result.fold(
      (l) => failure.value = l,
      (r) => loadMembers(),
    );
  }

  Future<void> removeMember(int id) async {
    final result = await deleteMemberUseCase(id);
    result.fold(
      (l) => failure.value = l,
      (r) => loadMembers(),
    );
  }
}