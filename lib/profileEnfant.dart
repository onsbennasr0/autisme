import 'package:flutter/material.dart';

class KidProfilePage extends StatelessWidget {
  const KidProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/page.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage('https://via.placeholder.com/140'),
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Charlie Brown',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                '7 years old',
                style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
              ),
              const SizedBox(height: 10),
              const ProfileInfoCard(
                icon: Icons.cake,
                title: 'Birthday',
                subtitle: 'August 18th',
                iconColor: Colors.purple,
              ),
              const ProfileInfoCard(
                icon: Icons.school,
                title: 'Grade',
                subtitle: '2nd Grade',
                iconColor: Colors.red,
              ),
              const ProfileInfoCard(
                icon: Icons.favorite,
                title: 'Favorite Color',
                subtitle: 'Blue',
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Add action here if necessary, such as navigation or dialog
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
