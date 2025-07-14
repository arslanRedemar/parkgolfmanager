import 'package:flutter/material.dart';
import '../../data/models/member_model.dart';
import '../controllers/member_controller.dart';
import 'package:get/get.dart';

class MemberTile extends StatelessWidget {
  final MemberModel member;
  const MemberTile({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MemberController>();
    return ListTile(
      title: Text(member.name),
      subtitle: Text('${member.gender} | ${member.phone}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => controller.removeMember(member.id!),
      ),
    );
  }
}
