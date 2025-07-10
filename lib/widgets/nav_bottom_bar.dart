import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);  // <-- déclenche la fonction passée par la page
      },
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Accueil"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.book),
          title: const Text("Formules"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.mail),
          title: const Text("Contact"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.login),
          title: const Text("Connexion"),
          selectedColor: Colors.blue,
        ),
      ],
    );
  }
}
