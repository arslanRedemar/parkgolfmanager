import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0) // 고유한 typeId 지정 (다른 모델과 중복 안되게)
class ClubModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? region;

  @HiveField(3)
  final String? createdAt;

  ClubModel({this.id, required this.name, this.region, this.createdAt});

  factory ClubModel.fromMap(Map<String, dynamic> map) => ClubModel(
    id: map['id'],
    name: map['name'],
    region: map['region'],
    createdAt: map['created_at'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'region': region,
    'created_at': createdAt,
  };

  @override
  List<Object?> get props => [id, name, region, createdAt];
}
