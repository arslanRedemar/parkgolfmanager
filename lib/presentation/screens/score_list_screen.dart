import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/score_model.dart';
import '../controllers/score_controller.dart';
import '../widgets/score_tile.dart';
import '../widgets/score_dialog.dart';

class ScoreListScreen extends StatelessWidget {
  final controller = Get.find<ScoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('점수 목록')),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: controller.scores.map((s) => ScoreTile(score: s)).toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showScoreDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}