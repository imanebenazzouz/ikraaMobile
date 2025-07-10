import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ikraa/pages/accueil_login_student.dart';
import 'package:ikraa/pages/accueil_login_teacher.dart';
import 'package:ikraa/pages/forgot_password_page.dart';
import 'firebase_options.dart';
import 'pages/home_guest_page.dart';
import 'pages/formules_page.dart';
import 'pages/contact_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const IkraaApp());
}

class IkraaApp extends StatelessWidget {
  const IkraaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ikraa',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/accueil',
      routes: {
        '/accueil': (context) => const HomeGuestPage(),
        '/formules': (context) => const FormulesPage(),
        '/contact': (context) => const ContactPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/accueilStudent': (context) => const AccueilLoginStudentPage(),
        '/accueilTeacher': (context) => const AccueilLoginTeacherPage(),
        '/forgotPassword': (context)=> const ForgotPasswordPage()
      },

    );
  }
}
