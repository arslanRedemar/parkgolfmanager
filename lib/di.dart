import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'data/dao/club_dao.dart';
import 'data/dao/member_dao.dart';
import 'data/dao/tournament_dao.dart';
import 'data/dao/score_dao.dart';

import 'domain/repositories/club_repository.dart';
import 'domain/repositories/member_repository.dart';
import 'domain/repositories/tournament_repository.dart';
import 'domain/repositories/score_repository.dart';

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
  getIt.registerSingleton<Database>(db);

  // DAO
  getIt.registerLazySingleton<ClubDao>(() => ClubDaoImpl(db));
  getIt.registerLazySingleton<MemberDao>(() => MemberDaoImpl(db));
  getIt.registerLazySingleton<TournamentDao>(() => TournamentDaoImpl(db));
  getIt.registerLazySingleton<ScoreDao>(() => ScoreDaoImpl(db));

  // Repository
  getIt.registerLazySingleton<ClubRepository>(
    () => ClubRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<TournamentRepository>(
    () => TournamentRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ScoreRepository>(
    () => ScoreRepositoryImpl(getIt()),
  );

  // Controller (예: GetX 사용할 경우)
  // getIt.registerFactory(() => ClubController(getIt()));
}
