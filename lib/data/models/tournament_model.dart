import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'tournament_model.g.dart';

@HiveType(typeId: 2)
class TournamentModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? regionOrEtc;

  @HiveField(3)
  final String? createdAt;

  const TournamentModel({
    this.id,
    required this.name,
    this.regionOrEtc,
    this.createdAt,
  });

  factory TournamentModel.fromMap(Map<String, dynamic> map) => TournamentModel(
        id: map['id'],
        name: map['name'],
        regionOrEtc: map['region'] ?? map['location'] ?? map['note'],
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'regionOrEtc': regionOrEtc,
        'created_at': createdAt,
      };

  @override
  List<Object?> get props => [id, name, regionOrEtc, createdAt];
}
