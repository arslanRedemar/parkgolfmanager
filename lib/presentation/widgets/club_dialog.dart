import 'package:flutter/material.dart';
import '../../data/models/club_model.dart';
import '../controllers/club_controller.dart';

void showClubDialog(BuildContext context, ClubController controller) {
  final nameController = TextEditingController();
  final regionController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('클럽 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: '클럽명'),
          ),
          TextField(
            controller: regionController,
            decoration: const InputDecoration(labelText: '주소'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await controller.addClub(
              ClubModel(
                name: nameController.text,
                region: regionController.text,
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
