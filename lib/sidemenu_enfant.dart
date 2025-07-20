import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginenfant.dart';
import 'profileEnfant.dart';
import 'welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Autisme App',
      home: SideMenu2Page(),
    );
  }
}

class SideMenu2Page extends StatefulWidget {
  const SideMenu2Page({super.key});

  @override
  _SideMenu2PageState createState() => _SideMenu2PageState();
}

class _SideMenu2PageState extends State<SideMenu2Page> {
  String psuedo = '';
  String email = '';
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
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Generate a random profile picture URL
        String profilePictureUrl = getRandomProfilePicture();

        // Add user data to Firestore collection "enfant"
        await FirebaseFirestore.instance.collection('enfants').doc(user.uid).set(
            {
              'id': user.uid, // Using user's UID as ID
              'emailenfant': user.email, // Store user's email
              'pseudo': 'Nom de l\'enfant', // Placeholder for child's name
              'profilePictureUrl':
                  profilePictureUrl, // Store profile picture URL
            },
            SetOptions(
                merge:
                    true)); // Merge options to update if document already exists
      }
    } catch (e) {
      print('Error creating user account: $e');
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user data from Firestore collection "enfants"
        final QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('enfants')
                .where('emailenfant',
                    isEqualTo: user.email) // Change 'email' to 'emailenfant'
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          final userData = querySnapshot.docs.first.data();
          setState(() {
            // Update user name with child's pseudo
            psuedo = userData['pseudo'];

            // Update user email with child's email
            email = userData['emailenfant'];
          });
        } else {
          // Handle if user document doesn't exist
          print('User document does not exist for UID: ${user.uid}');
        }
      } else {
        // Handle if user is null
        print('Current user is null');
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching user info: $e');
    }
  }

  Future<String> fetchUserProfilePicture() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user profile picture URL from Firestore collection "enfant"
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('enfants')
                .doc(user.uid)
                .get();

        if (snapshot.exists) {
          // Check if the user has a profile picture URL set in the database
          final String? profilePicture = snapshot.data()?['profilePictureUrl'];
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
              psuedo.isNotEmpty ? psuedo : '',
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              email.isNotEmpty ? email : '',
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
                MaterialPageRoute(builder: (context) => const KidProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {},
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
                                builder: (context) => const LoginenfantPage()),
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