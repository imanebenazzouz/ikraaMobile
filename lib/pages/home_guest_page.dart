import 'package:flutter/material.dart';
import '../widgets/nav_bottom_bar.dart';

class HomeGuestPage extends StatelessWidget {
  const HomeGuestPage({super.key});

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/accueil');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/formules');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/contact');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/login');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Bienvenue sur Ikraa !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/acceuil.png',
                width: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: const [
                    _InfoCard(
                      emoji: '📚',
                      title: 'Accédez à des ressources variées',
                      description:
                      'Explorez des cours, fiches, vidéos et quiz pour renforcer vos connaissances.',
                    ),
                    SizedBox(height: 12),
                    _InfoCard(
                      emoji: '🔍',
                      title: 'Apprenez à votre rythme',
                      description:
                      'Avancez selon vos besoins, où vous voulez et quand vous voulez.',
                    ),
                    SizedBox(height: 12),
                    _InfoCard(
                      emoji: '🎓',
                      title: 'Progressez et réussissez',
                      description:
                      'Suivez vos progrès et atteignez vos objectifs académiques avec Ikraa.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBottomBar(
        currentIndex: 0,
        onTap: (index) => _navigateToPage(context, index),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;

  const _InfoCard({
    required this.emoji,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$emoji $title',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
