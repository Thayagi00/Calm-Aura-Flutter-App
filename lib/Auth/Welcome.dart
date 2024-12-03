import 'package:calm_aura/Auth/LoginPage.dart';
import 'package:calm_aura/Auth/RegisterPage.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Animated Image with Opacity
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/welcome.jpg',
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              // Title Text
              const Text(
                'Calm Aura',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Coloors.purple),
              ),
              const SizedBox(height: 10),
              // Subtitle Text
              const Text(
                'Discover serenity within. Embrace calmness, manage anxiety, and reclaim your peace of mind daily',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 40),
              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loginpage()),
                  );
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Coloors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              // Create Account Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  'Create account',
                  style: TextStyle(color: Coloors.purple),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
