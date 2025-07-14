import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../core/failures/failure.dart';
import '../../domain/models/club_model.dart';
import '../../domain/repositories/club_repository.dart';

class ClubRepositoryImpl implements ClubRepository {
  final Box<ClubModel> box;

  ClubRepositoryImpl(this.box);

  @override
  Future<Either<Failure, List<ClubModel>>> getAll() async {
    try {
      final items = box.values.toList();
      return Right(items);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insert(ClubModel item) async {
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
