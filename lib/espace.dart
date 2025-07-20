// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'login.dart';
import 'loginenfant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Autismo',
      home: EspacePage(),
    );
  }
}

class EspacePage extends StatelessWidget {
  const EspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.all(20), // Réduit la valeur de 100 à 20
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset(
                          'assets/logo.jpg',
                          width: 150,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                        print('Parent Space Button Pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 60),
                      ),
                      child: const Text('Espace  Parents'),
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginenfantPage()),
                        );
                        print('Child Space Button Pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 60),
                        // Correction ici
                      ),
                      child: const Text('Espace  Enfants'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
