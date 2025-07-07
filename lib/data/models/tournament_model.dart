
import 'package:equatable/equatable.dart';

class TournamentModel extends Equatable {
  final int? id;
  final String name;
  final String date;
  final String? location;
  final String? note;
  final String? createdAt;

  const TournamentModel({
    this.id,
    required this.name,
    required this.date,
    this.location,
    this.note,
    this.createdAt,
  });

  factory TournamentModel.fromMap(Map<String, dynamic> map) => TournamentModel(
        id: map['id'],
        name: map['name'],
        date: map['date'],
        location: map['location'],
        note: map['note'],
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'date': date,
        'location': location,
        'note': note,
        'created_at': createdAt,
      };

  @override
  List<Object?> get props => [id, name, date, location, note, createdAt];
}
