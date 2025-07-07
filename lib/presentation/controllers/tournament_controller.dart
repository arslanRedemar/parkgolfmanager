import 'package:get/get.dart';
import '../../../core/failure.dart';
import '../../../data/models/tournament_model.dart';
import '../../../domain/usecases/insert_tournament.dart';
import '../../../domain/usecases/get_all_tournaments.dart';
import '../../../domain/usecases/delete_tournament.dart';

class TournamentController extends GetxController {
  final InsertTournamentUseCase insertTournamentUseCase;
  final GetAllTournamentsUseCase getAllTournamentsUseCase;
  final DeleteTournamentUseCase deleteTournamentUseCase;

  TournamentController({
    required this.insertTournamentUseCase,
    required this.getAllTournamentsUseCase,
    required this.deleteTournamentUseCase,
  });

  final RxList<TournamentModel> tournaments = <TournamentModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<Failure> failure = Rxn<Failure>();

  Future<void> loadTournaments() async {
    isLoading.value = true;
    final result = await getAllTournamentsUseCase();
    result.fold(
      (l) => failure.value = l,
      (r) => tournaments.assignAll(r),
    );
    isLoading.value = false;
  }

  Future<void> addTournament(TournamentModel tournament) async {
    final result = await insertTournamentUseCase(tournament);
    result.fold(
      (l) => failure.value = l,
      (r) => loadTournaments(),
    );
  }

  Future<void> removeTournament(int id) async {
    final result = await deleteTournamentUseCase(id);
    result.fold(
      (l) => failure.value = l,
      (r) => loadTournaments(),
    );
  }
}