import 'package:flutter/material.dart';
import 'features/login/presentation/pages/login_screen.dart';
import 'package:flutter/services.dart';
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
      home: LoginScreen(),
    );
  }
}
