import 'package:flutter/material.dart';
import '../widgets/nav_bottom_bar.dart';

class FormulesPage extends StatelessWidget {
  const FormulesPage({super.key});

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
    final Color highlight = Colors.blue.shade600;
    final TextStyle cardTextStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    final TextStyle priceTextStyle = cardTextStyle.copyWith(fontSize: 24);
    final TextStyle periodTextStyle = const TextStyle(
      color: Colors.white70,
      fontSize: 16,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            children: [
              // Texte d'introduction agrandi
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Choisissez votre formule',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: highlight,
                    fontWeight: FontWeight.w600,
                  ) ?? const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _PlanCard(
                title: 'Mensuelle',
                price: '9,99€ / mois',
                period: 'Résiliable à tout moment',
                background: highlight,
                titleStyle: cardTextStyle,
                priceStyle: priceTextStyle,
                periodStyle: periodTextStyle,
              ),
              const SizedBox(height: 20),
              _PlanCard(
                title: 'Année scolaire',
                price: '99,99€ / an',
                period: 'Valable sept. – juin',
                background: highlight,
                titleStyle: cardTextStyle,
                priceStyle: priceTextStyle,
                periodStyle: periodTextStyle,
                bestSeller: true,
              ),
              const SizedBox(height: 20),
              _PlanCard(
                title: '2 années scolaires',
                price: '179,99€ pour 2 ans',
                period: 'Deux années consécutives',
                background: highlight,
                titleStyle: cardTextStyle,
                priceStyle: priceTextStyle,
                periodStyle: periodTextStyle,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBottomBar(
        currentIndex: 1,
        onTap: (i) => _navigateToPage(context, i),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final bool bestSeller;
  final Color background;
  final TextStyle titleStyle;
  final TextStyle priceStyle;
  final TextStyle periodStyle;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    this.bestSeller = false,
    required this.background,
    required this.titleStyle,
    required this.priceStyle,
    required this.periodStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 10),
              Text(price, style: priceStyle),
              const SizedBox(height: 8),
              Text(period, style: periodStyle),
            ],
          ),
        ),
        if (bestSeller)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                'Best-seller',
                style: TextStyle(
                  color: background,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
