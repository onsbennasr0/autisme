// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'activites.dart';
import 'calender.dart';
import 'login.dart';
import 'ressources.dart';
import 'welcome.dart';
import 'settings.dart';
import 'profile.dart';
import 'quizParents.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Autisme App',
      home: SideMenuPage(),
    );
  }
}

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  _SideMenuPageState createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  String userName = '';
  String userEmail = '';
  bool userInfoLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  // tsawer par défaut
  List<String> profilePictures = [
    'gnome1.jpg',
    'gnome2.jpg',
    'gnome3.jpg',
    'gnome4.jpg',
    'gnome5.jpg',
    'gnome6.jpg',
    'gnome7.jpg',
    'gnome8.jpg',
  ];
  // tsawer par défaut
  String getRandomProfilePicture() {
    Random random = Random();
    int index = random.nextInt(profilePictures.length);
    return profilePictures[index];
  }

  // Function to handle user account creation
  Future<void> createUserAccount() async {
    try {
      // Get the current user
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Check if the user already has a profile picture assigned
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (!snapshot.exists || snapshot.data()?['profilePictureUrl'] == null) {
          // Generate a random profile picture URL only if it's not already set
          String profilePictureUrl = getRandomProfilePicture();
          // Update the user's profile picture URL in the database
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'profilePictureUrl': profilePictureUrl,
          }, SetOptions(merge: true));
        }
      }
    } catch (e) {
      print('Error creating user account: $e');
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: user.email)
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          final userData = querySnapshot.docs.first.data();
          setState(() {
            // Mettre à jour le nom de l'utilisateur
            userName = userData['name'];

            // Mettre à jour l'e-mail de l'utilisateur
            userEmail = user.email!;
          });
        } else {
          // S'il n'y a pas de document correspondant à l'e-mail de l'utilisateur
          print('No user data found for email: ${user.email}');
        }
      } else {
        // Si l'utilisateur est null
        print('Current user is null');
      }
    } catch (e) {
      // En cas d'erreur lors de la récupération des informations de l'utilisateur
      print('Error fetching user info: $e');
    }
  }

  Future<String> fetchUserProfilePicture() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (snapshot.exists) {
          // Check if the user has a profile picture set in the database
          final String? profilePicture = snapshot.data()?['profilePicture'];
          if (profilePicture != null && profilePicture.isNotEmpty) {
            return profilePicture; // Return user profile picture URL
          }
        }
      }
    } catch (e) {
      print('Error fetching user profile picture: $e');
    }

    // If user profile picture is not found, return a random one from the list
    String randomPicture = getRandomProfilePicture();
    return 'assets/$randomPicture';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              userName.isNotEmpty ? userName : '',
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              userEmail.isNotEmpty ? userEmail : '',
              style: const TextStyle(color: Colors.black),
            ),
            currentAccountPicture: FutureBuilder<String>(
              future: fetchUserProfilePicture(), // Fetch user profile picture
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return CircleAvatar(
                    backgroundImage: AssetImage(
                        snapshot.data!), // Display user profile picture
                  );
                } else {
                  return const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/gnome7.jpg'), // Placeholder image
                  );
                }
              },
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/b1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.handshake_rounded),
            title: const Text('Bienvenue'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_activity),
            title: const Text('activites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActivityPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Resources'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RessourcesPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Quiz'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('calendrier'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Se déconnecter'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Déconnexion',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text('Voulez-vous vraiment vous déconnecter ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Fermer la boîte de dialogue
                        },
                        child: const Text('Non'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut(); // Se déconnecter
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          ); // Naviguer vers la page de connexion
                        },
                        child: const Text('Oui'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}