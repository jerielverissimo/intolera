import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/login/presentation/pages/login_screen.dart';
import 'features/splash_screen/presentation/pages/splash.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';
import 'injection_container.dart' as di;

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async => {
            await di.init(),
            runApp(Intolera()),
          });
}

class Intolera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intolera',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SplashScreen();
          if (!snapshot.hasData || snapshot.data == null) return LoginScreen();
          return HomePage();
        });
  }
}
