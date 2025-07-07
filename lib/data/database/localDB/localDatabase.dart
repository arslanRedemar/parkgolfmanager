import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../core/failure.dart';
import '../../models/club_model.dart';
import '../../models/member_model.dart';
import '../../models/tournament_model.dart';
import '../../models/score_model.dart';

abstract class LocalDatabase {
  // ▶ CLUB
  Future<Either<Failure, int>> insertClub(ClubModel club);
  Future<Either<Failure, List<ClubModel>>> getAllClubs();
  Future<Either<Failure, int>> deleteClub(int id);

  // ▶ MEMBER
  Future<Either<Failure, int>> insertMember(MemberModel member);
  Future<Either<Failure, List<MemberModel>>> getAllMembers();
  Future<Either<Failure, List<MemberModel>>> getMembersByClub(int clubId);
  Future<Either<Failure, int>> deleteMember(int id);

  // ▶ TOURNAMENT
  Future<Either<Failure, int>> insertTournament(TournamentModel tournament);
  Future<Either<Failure, List<TournamentModel>>> getAllTournaments();
  Future<Either<Failure, int>> deleteTournament(int id);

  // ▶ SCORE
  Future<Either<Failure, int>> insertScore(ScoreModel score);
  Future<Either<Failure, List<ScoreModel>>> getScoresByMember(int memberId);
  Future<Either<Failure, List<ScoreModel>>> getScoresByTournament(
    int tournamentId,
  );
  Future<Either<Failure, int>> deleteScore(int id);

  // ▶ 종료
  Future<void> close();
}

class SqfliteDatabase implements LocalDatabase {
  static const _dbName = 'park_golf.db';
  static const _dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
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
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (club_id) REFERENCES clubs (id)
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
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (member_id) REFERENCES members (id),
      FOREIGN KEY (tournament_id) REFERENCES tournaments (id)
    );
  ''');
  }

  // CLUB
  @override
  Future<Either<Failure, int>> insertClub(ClubModel club) async {
    try {
      final db = await database;
      final id = await db.insert('clubs', club.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClubModel>>> getAllClubs() async {
    try {
      final db = await database;
      final result = await db.query('clubs');
      return Right(result.map((e) => ClubModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteClub(int id) async {
    try {
      final db = await database;
      final result = await db.delete('clubs', where: 'id = ?', whereArgs: [id]);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  // MEMBER
  @override
  Future<Either<Failure, int>> insertMember(MemberModel member) async {
    try {
      final db = await database;
      final id = await db.insert('members', member.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MemberModel>>> getAllMembers() async {
    try {
      final db = await database;
      final result = await db.query('members');
      return Right(result.map((e) => MemberModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MemberModel>>> getMembersByClub(
    int clubId,
  ) async {
    try {
      final db = await database;
      final result = await db.query(
        'members',
        where: 'club_id = ?',
        whereArgs: [clubId],
      );
      return Right(result.map((e) => MemberModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteMember(int id) async {
    try {
      final db = await database;
      final result = await db.delete(
        'members',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  // TOURNAMENT
  @override
  Future<Either<Failure, int>> insertTournament(
    TournamentModel tournament,
  ) async {
    try {
      final db = await database;
      final id = await db.insert('tournaments', tournament.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TournamentModel>>> getAllTournaments() async {
    try {
      final db = await database;
      final result = await db.query('tournaments');
      return Right(result.map((e) => TournamentModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteTournament(int id) async {
    try {
      final db = await database;
      final result = await db.delete(
        'tournaments',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  // SCORE
  @override
  Future<Either<Failure, int>> insertScore(ScoreModel score) async {
    try {
      final db = await database;
      final id = await db.insert('scores', score.toMap());
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScoreModel>>> getScoresByMember(
    int memberId,
  ) async {
    try {
      final db = await database;
      final result = await db.query(
        'scores',
        where: 'member_id = ?',
        whereArgs: [memberId],
      );
      return Right(result.map((e) => ScoreModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScoreModel>>> getScoresByTournament(
    int tournamentId,
  ) async {
    try {
      final db = await database;
      final result = await db.query(
        'scores',
        where: 'tournament_id = ?',
        whereArgs: [tournamentId],
      );
      return Right(result.map((e) => ScoreModel.fromMap(e)).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteScore(int id) async {
    try {
      final db = await database;
      final result = await db.delete(
        'scores',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
