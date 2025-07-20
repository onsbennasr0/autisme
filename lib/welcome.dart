import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autisme App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        title: const Text('Welcome'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Dream_clouds.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15), // Adjust the height as needed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.waving_hand_rounded, color: Colors.blue[800], size: 40), // Waving icon on the left
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Bienvenue!',
                          style: TextStyle(
                            color: Colors.blue[800], // Adjust the color as needed
                            fontSize: 40, // Large font size for big title
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Icon(Icons.waving_hand_rounded, color: Colors.blue[800], size: 40), // Waving icon on the right
                    ],
                  ),
                  const SizedBox(height: 35), // Space between title and paragraph
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Bienvenue dans notre application conçue spécifiquement pour les enfants autistes et leurs parents. Notre application vise à soutenir les enfants autistes dans le maintien de leurs routines et à leur fournir un sentiment de structure. Les parents peuvent utiliser l’application pour vérifier facilement leurs enfants et se connecter avec d’autres parents faisant face à des défis similaires. Ensemble, nous pouvons créer une communauté de soutien et permettre aux familles de naviguer à travers les expériences uniques d’élever des enfants avec autisme.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 70, 136),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
