import 'package:get/get.dart';
import '../../../core/failure.dart';
import '../../../data/models/club_model.dart';
import '../../../domain/usecases/insert_club.dart';
import '../../../domain/usecases/get_all_clubs.dart';
import '../../../domain/usecases/delete_club.dart';

class ClubController extends GetxController {
  final InsertClubUseCase insertClubUseCase;
  final GetAllClubsUseCase getAllClubsUseCase;
  final DeleteClubUseCase deleteClubUseCase;

  ClubController({
    required this.insertClubUseCase,
    required this.getAllClubsUseCase,
    required this.deleteClubUseCase,
  });

  final RxList<ClubModel> clubs = <ClubModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<Failure> failure = Rxn<Failure>();

  Future<void> loadClubs() async {
    isLoading.value = true;
    final result = await getAllClubsUseCase();
    result.fold(
      (l) => failure.value = l,
      (r) => clubs.assignAll(r),
    );
    isLoading.value = false;
  }

  Future<void> addClub(ClubModel club) async {
    final result = await insertClubUseCase(club);
    result.fold(
      (l) => failure.value = l,
      (r) => loadClubs(),
    );
  }

  Future<void> removeClub(int id) async {
    final result = await deleteClubUseCase(id);
    result.fold(
      (l) => failure.value = l,
      (r) => loadClubs(),
    );
  }
}