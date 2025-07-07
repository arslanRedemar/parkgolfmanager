
import 'package:equatable/equatable.dart';

class ScoreModel extends Equatable {
  final int? id;
  final int memberId;
  final int tournamentId;
  final int strokes;
  final String? memo;
  final String? createdAt;

  const ScoreModel({
    this.id,
    required this.memberId,
    required this.tournamentId,
    required this.strokes,
    this.memo,
    this.createdAt,
  });

  factory ScoreModel.fromMap(Map<String, dynamic> map) => ScoreModel(
        id: map['id'],
        memberId: map['member_id'],
        tournamentId: map['tournament_id'],
        strokes: map['strokes'],
        memo: map['memo'],
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'tournament_id': tournamentId,
        'strokes': strokes,
        'memo': memo,
        'created_at': createdAt,
      };

  @override
  List<Object?> get props => [id, memberId, tournamentId, strokes, memo, createdAt];
}
