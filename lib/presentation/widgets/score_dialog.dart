import 'package:flutter/material.dart';
import '../../data/models/score_model.dart';
import '../controllers/score_controller.dart';

void showScoreDialog(BuildContext context, ScoreController controller) {
  final memberIdController = TextEditingController();
  final tournamentIdController = TextEditingController();
  final strokesController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('점수 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: memberIdController, decoration: const InputDecoration(labelText: '회원ID')),
          TextField(controller: tournamentIdController, decoration: const InputDecoration(labelText: '대회ID')),
          TextField(controller: strokesController, decoration: const InputDecoration(labelText: '타수')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await controller.addScore(
              ScoreModel(
                memberId: int.tryParse(memberIdController.text) ?? 0,
                tournamentId: int.tryParse(tournamentIdController.text) ?? 0,
                strokes: int.tryParse(strokesController.text) ?? 0,
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('추가'),
        ),
      ],
    ),
  );
}