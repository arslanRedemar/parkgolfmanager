import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/score_model.dart';
import '../controllers/score_controller.dart';

class ScoreTile extends StatelessWidget {
  final ScoreModel score;
  const ScoreTile({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScoreController>();
    return ListTile(
      title: Text('회원: \${score.memberId} / 대회: \${score.tournamentId}'),
      subtitle: Text('타수: \${score.strokes}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => controller.removeScore(score.id!),
      ),
    );
  }
}
