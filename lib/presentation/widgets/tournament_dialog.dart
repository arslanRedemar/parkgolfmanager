import 'package:flutter/material.dart';
import '../../data/models/tournament_model.dart';
import '../controllers/tournament_controller.dart';

void showTournamentDialog(BuildContext context, TournamentController controller) {
  final nameController = TextEditingController();
  final dateController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('대회 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: '대회명')),
          TextField(controller: dateController, decoration: const InputDecoration(labelText: '날짜')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await controller.addTournament(
              TournamentModel(name: nameController.text, date: dateController.text),
            );
            Navigator.of(context).pop();
          },
          child: const Text('추가'),
        ),
      ],
    ),
  );
}