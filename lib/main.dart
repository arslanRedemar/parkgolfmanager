import 'package:flutter/material.dart';
import 'package:parkgolf/di.dart';
import 'package:get/get.dart';

import 'package:parkgolf/presentation/controllers/club_controller.dart';
import 'package:parkgolf/presentation/controllers/member_controller.dart';
import 'package:parkgolf/presentation/controllers/score_controller.dart';
import 'package:parkgolf/presentation/controllers/tournament_controller.dart';

import 'presentation/screens/club_list_screen.dart';
import 'presentation/screens/member_list_screen.dart';
import 'presentation/screens/score_list_screen.dart';
import 'presentation/screens/tournament_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // sqflite에서 필수!

  await setupDependencies(); // ✅ await 붙이기

  print("setup succeed!");

  // ✅ 모든 Get.put은 이 아래에서
  Get.put(
    ClubController(
      deleteClubUseCase: sl(),
      getAllClubsUseCase: sl(),
      insertClubUseCase: sl(),
    ),
  );

  Get.put(
    MemberController(
      insertMemberUseCase: sl(),
      getAllMembersUseCase: sl(),
      getMembersByClubUseCase: sl(),
      deleteMemberUseCase: sl(),
    ),
  );

  Get.put(
    TournamentController(
      insertTournamentUseCase: sl(),
      getAllTournamentsUseCase: sl(),
      deleteTournamentUseCase: sl(),
    ),
  );

  Get.put(
    ScoreController(
      insertScoreUseCase: sl(),
      getScoresByMemberUseCase: sl(),
      getScoresByTournamentUseCase: sl(),
      deleteScoreUseCase: sl(),
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Park Golf Association',
      initialRoute: '/clubs',
      getPages: [
        GetPage(name: '/clubs', page: () => ClubListScreen()),
        GetPage(name: '/members', page: () => MemberListScreen()),
        GetPage(name: '/tournaments', page: () => TournamentListScreen()),
        GetPage(name: '/scores', page: () => ScoreListScreen()),
      ],
    );
  }
}
