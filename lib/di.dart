import 'package:get_it/get_it.dart';
import 'package:parkgolf/domain/repositories/club_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'data/dao/club_dao.dart';
import 'data/dao/member_dao.dart';
import 'data/dao/tournament_dao.dart';
import 'data/dao/score_dao.dart';

import 'domain/repositories/member_repository.dart';
import 'domain/repositories/tournament_repository.dart';
import 'domain/repositories/score_repository.dart';

// 📦 Club UseCases
import 'package:parkgolf/domain/usecases/insert_club.dart';
import 'package:parkgolf/domain/usecases/get_all_clubs.dart';
import 'package:parkgolf/domain/usecases/delete_club.dart';

// 📦 Member UseCases
import 'package:parkgolf/domain/usecases/insert_member.dart';
import 'package:parkgolf/domain/usecases/get_all_members.dart';
import 'package:parkgolf/domain/usecases/get_members_by_club.dart';
import 'package:parkgolf/domain/usecases/delete_member.dart';

// 📦 Tournament UseCases
import 'package:parkgolf/domain/usecases/insert_tournament.dart';
import 'package:parkgolf/domain/usecases/get_all_tournaments.dart';
import 'package:parkgolf/domain/usecases/delete_tournament.dart';

// 📦 Score UseCases
import 'package:parkgolf/domain/usecases/insert_score.dart';
import 'package:parkgolf/domain/usecases/get_scores_by_member.dart';
import 'package:parkgolf/domain/usecases/get_scores_by_tournament.dart';
import 'package:parkgolf/domain/usecases/delete_score.dart';

import 'package:parkgolf/presentation/controllers/club_controller.dart';
import 'package:parkgolf/presentation/controllers/member_controller.dart';
import 'package:parkgolf/presentation/controllers/tournament_controller.dart';
import 'package:parkgolf/presentation/controllers/score_controller.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Initialize DB
  final db = await openDatabase(
    join(await getDatabasesPath(), 'pg_association.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE clubs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          region TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );
      ''');

      await db.execute('''
        CREATE TABLE members (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          phone TEXT,
          birthdate TEXT,
          gender TEXT,
          address TEXT,
          club_id INTEGER,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );
      ''');

      await db.execute('''
        CREATE TABLE tournaments (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          date TEXT NOT NULL,
          location TEXT,
          note TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );
      ''');

      await db.execute('''
        CREATE TABLE scores (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          member_id INTEGER NOT NULL,
          tournament_id INTEGER NOT NULL,
          strokes INTEGER NOT NULL,
          memo TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );
      ''');
    },
  );

  // Register database
  sl.registerSingleton<Database>(db);

  // DAO
  sl.registerLazySingleton<ClubDao>(() => ClubDaoImpl(db));
  sl.registerLazySingleton<MemberDao>(() => MemberDaoImpl(db));
  sl.registerLazySingleton<TournamentDao>(() => TournamentDaoImpl(db));
  sl.registerLazySingleton<ScoreDao>(() => ScoreDaoImpl(db));

  // Repository
  sl.registerLazySingleton<ClubRepository>(() => ClubRepositoryImpl(sl()));
  sl.registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl(sl()));
  sl.registerLazySingleton<TournamentRepository>(
    () => TournamentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ScoreRepository>(() => ScoreRepositoryImpl(sl()));

  // 📦 Club UseCases
  sl.registerLazySingleton<InsertClubUseCase>(() => InsertClub(sl()));
  sl.registerLazySingleton<GetAllClubsUseCase>(() => GetAllClubs(sl()));
  sl.registerLazySingleton<DeleteClubUseCase>(() => DeleteClub(sl()));

  // 📦 Member UseCases
  sl.registerLazySingleton<InsertMemberUseCase>(() => InsertMember(sl()));
  sl.registerLazySingleton<GetAllMembersUseCase>(() => GetAllMembers(sl()));
  sl.registerLazySingleton<GetMembersByClubUseCase>(
    () => GetMembersByClub(sl()),
  );
  sl.registerLazySingleton<DeleteMemberUseCase>(() => DeleteMember(sl()));

  // 📦 Tournament UseCases
  sl.registerLazySingleton<InsertTournamentUseCase>(
    () => InsertTournament(sl()),
  );
  sl.registerLazySingleton<GetAllTournamentsUseCase>(
    () => GetAllTournaments(sl()),
  );
  sl.registerLazySingleton<DeleteTournamentUseCase>(
    () => DeleteTournament(sl()),
  );

  // 📦 Score UseCases
  sl.registerLazySingleton<InsertScoreUseCase>(() => InsertScore(sl()));
  sl.registerLazySingleton<GetScoresByMemberUseCase>(
    () => GetScoresByMember(sl()),
  );
  sl.registerLazySingleton<GetScoresByTournamentUseCase>(
    () => GetScoresByTournament(sl()),
  );
  sl.registerLazySingleton<DeleteScoreUseCase>(() => DeleteScore(sl()));

  // Controller (예: GetX 사용할 경우)
  // getIt.registerFactory(() => ClubController(getIt()));
}
