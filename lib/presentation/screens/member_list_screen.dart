import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/member_model.dart';
import '../controllers/member_controller.dart';
import '../widgets/member_tile.dart';
import '../widgets/member_dialog.dart';

class MemberListScreen extends StatelessWidget {
  final controller = Get.find<MemberController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 목록')),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: controller.members.map((m) => MemberTile(member: m)).toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMemberDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}