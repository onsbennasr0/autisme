// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

import 'ppp.dart';

void main() {
  runApp(const MaterialApp(home: SchoolStory()));
}

class SchoolStory extends StatefulWidget {
  const SchoolStory({super.key});

  @override
  _SchoolStoryState createState() => _SchoolStoryState();
}

class _SchoolStoryState extends State<SchoolStory> {
  int _storyIndex = 0;
  final List<int> _previousScenes = []; // Track previous scenes

  final List<String> _storyTexts = [
    "C'est le premier jour d'école ! Vous êtes excité mais aussi un peu nerveux. Le bâtiment de l'école se dresse imposant alors que vous franchissez ses portes, accueilli par le son des rires et des bavardages.",
    "Vous voyez des enfants jouer pendant la récréation. Que voulez-vous faire ?",
    "Vous décidez de participer au jeu. Vous vous présentez aux autres enfants et commencez à jouer. Vous vous amusez tellement que vous en oubliez presque que vous étiez nerveux.",
    "Pendant le déjeuner, vous remarquez un camarade de classe assis seul. Que faites-vous ?",
    "Vous allez voir votre camarade de classe et lui demandez s'il veut s'asseoir avec vous. Il sourit et dit oui ! Le déjeuner passe rapidement alors que vous discutez et riez ensemble.",
    "Votre enseignant annonce un projet de groupe. Quel rôle voulez-vous prendre ?",
    "Vous vous imposez comme le leader de votre groupe. Bien que cela soit difficile de coordonner les idées et le travail de chacun, vous trouvez gratifiant de voir le projet se concrétiser.",
    "À la fin de la journée, vous réfléchissez à vos expériences. Que vous ayez fait un nouvel ami, dirigé une équipe ou aidé quelqu'un, vous êtes fier d'avoir fait des choix positifs et d'avoir été gentil envers les autres.",
  ];

  final List<List<String>> _choices = [
    ["Continuer"],
    ["Rejoindre le jeu", "Regarder de loin"],
    ["Continuer"],
    ["Invitez-le à rejoindre votre groupe", "Restez avec vos amis"],
    ["Continuer"],
    ["Leader", "Joueur d'équipe"],
    ["Continuer"],
    ["Fin"], // Réflexion finale
  ];

  final Map<int, Map<int, int>> _nextSceneMap = {
    1: {0: 2, 1: 3},
    3: {0: 4, 1: 4}, // Both choices lead to the same scene
    4: {0: 5, 1: 5}, // Both choices lead to the same scene
    5: {0: 6, 1: 6}, // Both choices lead to the same scene
    6: {0: 7, 1: 7}, // Both choices lead to the same scene
  };

  void _nextScene(int choiceIndex) {
    setState(() {
      if (_storyIndex < _storyTexts.length - 1) {
        // Store current scene index in the list of previous scenes
        _previousScenes.add(_storyIndex);

        if (_nextSceneMap.containsKey(_storyIndex)) {
          final nextSceneOptions = _nextSceneMap[_storyIndex];
          if (nextSceneOptions != null && nextSceneOptions.containsKey(choiceIndex)) {
            _storyIndex = nextSceneOptions[choiceIndex]!;
          }
        } else {
          _storyIndex++;
        }
      } else {
        // End of the story
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StorySelectionPage()),
        );
      }
    });
  }
  void _goBack() {
    setState(() {
      if (_previousScenes.isNotEmpty) {
        // Retrieve the last scene index from the list of previous scenes
        _storyIndex = _previousScenes.removeLast();
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Histoire d\'école'),
      // Add the back button to the top-left corner of the app bar
      leading: _storyIndex > 0
          ? IconButton(
              onPressed: _goBack,
              icon: const Icon(Icons.arrow_back),
            )
          : null,
    ),
    body: Stack(
      children: [
        // Image de fond
        Image.asset(
          'assets/Dream_clouds.jpeg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        // Texte de l'histoire et choix
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // change la position de l'ombre
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _storyTexts[_storyIndex],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              if (_storyIndex < _choices.length)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _choices[_storyIndex]
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final choice = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: index == 0 ? 10.0 : 0.0), // Ajoute de l'espace entre les boutons
                      child: ElevatedButton(
                        onPressed: () => _nextScene(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 218, 238, 247),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            choice,
                            style: const TextStyle(color: Colors.black87, fontSize: 18.0),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
}