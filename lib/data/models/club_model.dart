
import 'package:equatable/equatable.dart';

class ClubModel extends Equatable {
  final int? id;
  final String name;
  final String? region;
  final String? createdAt;

  const ClubModel({
    this.id,
    required this.name,
    this.region,
    this.createdAt,
  });

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
