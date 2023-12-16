import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navtoHome(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: 50,
          width: 200,
          color: redcolor,
          child: const Text(
            'TODO APP',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void navtoHome(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        final route = MaterialPageRoute(builder: (_) => const ScreenHome());
        Navigator.of(context).pushReplacement(route);
      },
    );
  }
}
