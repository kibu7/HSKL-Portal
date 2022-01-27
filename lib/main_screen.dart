
// ignore_for_file: unnecessary_string_escapes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/dashboard_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'Komponenten/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child:SideMenu(),
            ),
            Expanded(
              flex: 6,
              child: DashboardScreen(),
            ),
          ],
          ),
      ),
    );
  }
}

