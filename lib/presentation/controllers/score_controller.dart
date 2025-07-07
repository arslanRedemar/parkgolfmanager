import 'package:get/get.dart';
import '../../../core/failure.dart';
import '../../../data/models/score_model.dart';
import '../../../domain/usecases/insert_score.dart';
import '../../../domain/usecases/get_scores_by_member.dart';
import '../../../domain/usecases/get_scores_by_tournament.dart';
import '../../../domain/usecases/delete_score.dart';

class ScoreController extends GetxController {
  final InsertScoreUseCase insertScoreUseCase;
  final GetScoresByMemberUseCase getScoresByMemberUseCase;
  final GetScoresByTournamentUseCase getScoresByTournamentUseCase;
  final DeleteScoreUseCase deleteScoreUseCase;

  ScoreController({
    required this.insertScoreUseCase,
    required this.getScoresByMemberUseCase,
    required this.getScoresByTournamentUseCase,
    required this.deleteScoreUseCase,
  });

  final RxList<ScoreModel> scores = <ScoreModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<Failure> failure = Rxn<Failure>();

  Future<void> loadScoresByMember(int memberId) async {
    isLoading.value = true;
    final result = await getScoresByMemberUseCase(memberId);
    result.fold(
      (l) => failure.value = l,
      (r) => scores.assignAll(r),
    );
    isLoading.value = false;
  }

  Future<void> loadScoresByTournament(int tournamentId) async {
    isLoading.value = true;
    final result = await getScoresByTournamentUseCase(tournamentId);
    result.fold(
      (l) => failure.value = l,
      (r) => scores.assignAll(r),
    );
    isLoading.value = false;
  }

  Future<void> addScore(ScoreModel score) async {
    final result = await insertScoreUseCase(score);
    result.fold(
      (l) => failure.value = l,
      (r) {
        // refresh if needed
      },
    );
  }

  Future<void> removeScore(int id) async {
    final result = await deleteScoreUseCase(id);
    result.fold(
      (l) => failure.value = l,
      (r) {
        // refresh if needed
      },
    );
  }
}