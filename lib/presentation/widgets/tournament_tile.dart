import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/tournament_model.dart';
import '../controllers/tournament_controller.dart';

class TournamentTile extends StatelessWidget {
  final TournamentModel tournament;
  const TournamentTile({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TournamentController>();
    return ListTile(
      title: Text(tournament.name),
      subtitle: Text(tournament.date),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => controller.removeTournament(tournament.id!),
      ),
    );
  }
}
