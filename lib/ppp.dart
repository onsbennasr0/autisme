import 'package:flutter/material.dart';
import 'quizFriends.dart';
import 'quizSchool.dart'; // Import the QuizFriendsPage

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Montserrat',
    ),
    home: const StorySelectionPage(),
  ));
}

class StorySelectionPage extends StatelessWidget {
  const StorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Story'),
        
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Dream_clouds.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: 4, // Number of stories
            itemBuilder: (BuildContext context, int index) {
              List<Map<String, String>> stories = [
                {"title": "Friendship Story", "imagePath": "assets/gnome3.jpg"},
                {"title": "school Story", "imagePath": "assets/gnome6.jpg"},
                {"title": "Mystery Story", "imagePath": "assets/gnome4.jpg"},
                {"title": "Science Fiction Story", "imagePath": "assets/gnome7.jpg"}
              ];

              return StoryCard(
                title: stories[index]['title']!,
                imagePath: stories[index]['imagePath']!,
                onTap: () {
                  // Conditional navigation based on the story title
                  if (stories[index]['title'] == "Friendship Story") {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FriendshipStory()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SchoolStory()));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const StoryCard({required this.title, required this.imagePath, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
          gradient: const LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB3E5FC)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryDetailPage extends StatelessWidget {
  final String title;

  const StoryDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("Content for $title goes here.")),
    );
  }
}
