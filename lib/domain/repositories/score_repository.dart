import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../core/failures/failure.dart';
import '../../domain/models/score_model.dart';
import '../../domain/repositories/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final Box<ScoreModel> box;

  ScoreRepositoryImpl(this.box);

  @override
  Future<Either<Failure, List<ScoreModel>>> getAll() async {
    try {
      final items = box.values.toList();
      return Right(items);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insert(ScoreModel item) async {
    try {
      await box.put(item.id, item);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      await box.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
