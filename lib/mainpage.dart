import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:matterport/login.dart';
import 'package:matterport/routes.dart';
import 'package:matterport/screens/home/home_screen.dart';
import 'package:matterport/screens/splash/splash_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //routes: routes;
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
