import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/tournament_model.dart';
import '../controllers/tournament_controller.dart';
import '../widgets/tournament_tile.dart';
import '../widgets/tournament_dialog.dart';

class TournamentListScreen extends StatelessWidget {
  final controller = Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('대회 목록')),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: controller.tournaments.map((t) => TournamentTile(tournament: t)).toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTournamentDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}