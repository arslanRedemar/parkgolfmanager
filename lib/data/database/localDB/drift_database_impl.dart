
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../core/failure.dart';
import '../../models/club_model.dart';
import '../../models/member_model.dart';
import '../../models/tournament_model.dart';
import '../../models/score_model.dart';
import 'drift_tables.dart';
import 'package:your_project/data/datasources/drift_database.g.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Clubs, Members, Tournaments, Scores])
class DriftDatabase extends _$DriftDatabase implements LocalDatabase {
  DriftDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'drift_db.sqlite'));
      return NativeDatabase(file);
    });
  }

  // 이하 생략 (앞서 작성한 코드와 동일)
}
