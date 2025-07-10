import 'package:flutter/material.dart';

class AccueilLoginStudentPage extends StatelessWidget {
  const AccueilLoginStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenue Étudiant !',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
