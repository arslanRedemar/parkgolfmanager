import 'package:flutter/material.dart';
import '../../data/models/member_model.dart';
import '../controllers/member_controller.dart';

void showMemberDialog(BuildContext context, MemberController controller) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final clubIdController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('회원 추가'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: '전화번호'),
            ),
            TextField(
              controller: birthController,
              decoration: const InputDecoration(labelText: '생년월일'),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: '성별'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: '주소'),
            ),
            TextField(
              controller: clubIdController,
              decoration: const InputDecoration(labelText: '클럽ID'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await controller.addMember(
              MemberModel(
                name: nameController.text,
                phone: phoneController.text,
                birthdate: birthController.text,
                gender: genderController.text,
                address: addressController.text,
                clubId: int.tryParse(clubIdController.text) ?? 0,
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
