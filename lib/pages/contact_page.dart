import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../widgets/nav_bottom_bar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; });

    final apiKey = dotenv.env['BREVO_API_KEY'];
    print('DEBUG: BREVO_API_KEY=$apiKey');

    if (apiKey == null || apiKey.isEmpty) {
      print('DEBUG: La clé API est null ou vide => dotenv non chargé ou .env introuvable');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur : clé API manquante ou non chargée")),
      );
      setState(() { _isLoading = false; });
      return;
    }

    const apiUrl = 'https://api.brevo.com/v3/smtp/email';

    final payload = {
      "sender": { "name": "App Ikraa", "email": "velibapp5@gmail.com" },
      "to": [{ "email": "imvnebnz@gmail.com", "name": "Imane" }],
      "subject": "Message reçu via la page Contact Ikraa",
      "htmlContent": """
        <p><strong>Nom:</strong> ${_nameController.text}</p>
        <p><strong>Email:</strong> ${_emailController.text}</p>
        <p><strong>Message:</strong><br>${_messageController.text}</p>
      """
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "api-key": apiKey,
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Message envoyé avec succès !")),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur API : ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur réseau : ${e.toString()}")),
      );
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _navigateToPage(int index) {
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
    const Color blueColor = Color(0xFF1976D2);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: NavBottomBar(
        currentIndex: 2,
        onTap: _navigateToPage,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Contactez-nous",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: blueColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputBlock(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nom',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInputBlock(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Champ requis';
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          return emailRegex.hasMatch(value) ? null : 'Email invalide';
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInputBlock(
                      child: TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        maxLines: 4,
                        validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _sendEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Envoyer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBlock({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1976D2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
