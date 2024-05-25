import 'package:flutter_application_1/controllers/mainscreen_provider.dart';
import 'package:flutter_application_1/shared/BottomNav.dart';
import 'package:flutter_application_1/ui/cartpage.dart';
import 'package:flutter_application_1/ui/favorites.dart';
import 'package:flutter_application_1/ui/homepage.dart';
import 'package:flutter_application_1/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/searchpage.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList =  [
    const HomePage(),
     SearchPage(),
    const Favorites(),
    CartPage(),
     UserProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          extendBody: true,
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottonNavBar(),
        );
      },
    );
  }
}
