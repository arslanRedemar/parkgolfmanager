import 'package:flutter/material.dart';
import '../../data/models/club_model.dart';
import '../controllers/club_controller.dart';
import 'package:get/get.dart';

class ClubTile extends StatelessWidget {
  final ClubModel club;
  const ClubTile({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClubController>();
    return ListTile(
      title: Text(club.name),
      subtitle: Text(club.region ?? "없음"),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => controller.removeClub(club.id!),
      ),
    );
  }
}
