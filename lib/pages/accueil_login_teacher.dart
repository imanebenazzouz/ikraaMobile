import 'package:flutter/material.dart';

class AccueilLoginTeacherPage extends StatelessWidget {
  const AccueilLoginTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenue Enseignant !',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
