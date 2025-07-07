
import 'package:equatable/equatable.dart';

class MemberModel extends Equatable {
  final int? id;
  final String name;
  final String? phone;
  final String? birthdate;
  final String? gender;
  final String? address;
  final int? clubId;
  final String? createdAt;

  const MemberModel({
    this.id,
    required this.name,
    this.phone,
    this.birthdate,
    this.gender,
    this.address,
    this.clubId,
    this.createdAt,
  });

  factory MemberModel.fromMap(Map<String, dynamic> map) => MemberModel(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        birthdate: map['birthdate'],
        gender: map['gender'],
        address: map['address'],
        clubId: map['club_id'],
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'birthdate': birthdate,
        'gender': gender,
        'address': address,
        'club_id': clubId,
        'created_at': createdAt,
      };

  @override
  List<Object?> get props => [id, name, phone, birthdate, gender, address, clubId, createdAt];
}
