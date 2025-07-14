import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/club_model.dart';
import '../controllers/club_controller.dart';
import '../widgets/club_dialog.dart';
import '../widgets/club_tile.dart';

class ClubListScreen extends StatelessWidget {
  final controller = Get.find<ClubController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('클럽 목록')),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: controller.clubs.map((club) => ClubTile(club: club)).toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showClubDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}