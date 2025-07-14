import 'package:dartz/dartz.dart';
import 'package:path/path.dart';

import '../../../core/failure.dart';
import '../../models/club_model.dart';
import '../../models/member_model.dart';
import '../../models/tournament_model.dart';
import '../../models/score_model.dart';

abstract class LocalDatabase {
  // CLUB
  Future<Either<Failure, void>> insertClub(ClubModel club);
  Future<Either<Failure, List<ClubModel>>> getAllClubs();
  Future<Either<Failure, void>> deleteClub(int id);

  // MEMBER
  Future<Either<Failure, void>> insertMember(MemberModel member);
  Future<Either<Failure, List<MemberModel>>> getAllMembers();
  Future<Either<Failure, List<MemberModel>>> getMembersByClub(int clubId);
  Future<Either<Failure, void>> deleteMember(int id);

  // TOURNAMENT
  Future<Either<Failure, void>> insertTournament(TournamentModel tournament);
  Future<Either<Failure, List<TournamentModel>>> getAllTournaments();
  Future<Either<Failure, void>> deleteTournament(int id);

  // SCORE
  Future<Either<Failure, void>> insertScore(ScoreModel score);
  Future<Either<Failure, List<ScoreModel>>> getScoresByMember(int memberId);
  Future<Either<Failure, List<ScoreModel>>> getScoresByTournament(
    int tournamentId,
  );
  Future<Either<Failure, void>> deleteScore(int id);

  // 종료
  Future<void> close();
}
