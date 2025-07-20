// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

import 'ppp.dart';

void main() {
  runApp(const MaterialApp(home: FriendshipStory()));
}

class FriendshipStory extends StatefulWidget {
  const FriendshipStory({super.key});

  @override
  _FriendshipStoryState createState() => _FriendshipStoryState();
}

class _FriendshipStoryState extends State<FriendshipStory> {
  int _storyIndex = 0;
  final List<int> _previousScenes = []; // Track previous scenes

final List<String> _storyTexts = [
  "C'est un jour d'été ensoleillé. Tu te réveilles plein d'enthousiasme car tu as prévu de passer la journée avec ton meilleur ami. Que décides-tu de faire ?",
  "Ton ami arrive avec une vieille carte au trésor qu'il a trouvée. Il propose de partir à l'aventure ensemble pour la trouver. Que réponds-tu ?",
  "Vous vous rendez à l'endroit indiqué sur la carte et commencez à explorer. Soudain, vous arrivez à un carrefour. Quel chemin choisissez-vous ?",
  "Vous optez pour le chemin de gauche, attirés par le bruit d'une cascade au loin. En vous approchant, vous découvrez une belle cascade cachée dans la forêt. Que faites-vous ?",
  "Vous décidez de vous approcher de la cascade pour explorer les environs. Pendant que vous êtes là, vous trouvez un chemin menant à une grotte mystérieuse derrière la cascade. Que décidez-vous de faire ?",
  "Vous décidez d'entrer dans la grotte pour voir ce qu'il y a à l'intérieur. À mesure que vous avancez, vous découvrez des peintures rupestres anciennes sur les parois de la grotte. Que ressentez-vous en voyant cela ?",
  "Vous êtes fascinés par les peintures rupestres et décidez d'explorer plus en profondeur. Au fond de la grotte, vous trouvez un coffre au trésor rempli de bijoux étincelants et de pièces anciennes. Que faites-vous avec le trésor ?",
  "Vous décidez de laisser le trésor là où vous l'avez trouvé, convaincus que ce qui compte le plus, ce sont les aventures que vous avez partagées ensemble. Vous quittez la grotte, heureux de l'expérience que vous avez vécue.",
];

final List<List<String>> _choices = [
  ["Aller à la plage", "Faire une randonnée en montagne"],
  ["Accepter avec enthousiasme", "Décliner poliment"],
  ["Prendre le chemin de gauche", "Prendre le chemin de droite"],
  ["Approcher de la cascade", "Continuer à explorer la forêt"],
  ["Entrer dans la grotte", "Rester à admirer la cascade"],
  ["Continuer à explorer", "Retourner à l'entrée de la grotte"],
  ["Prendre le trésor", "Laisser le trésor et partir"],
  ["Continuer"],
];

final Map<int, Map<int, int>> _nextSceneMap = {
  1: {0: 2, 1: 2},
  2: {0: 3, 1: 7},
  3: {0: 4, 1: 4},
  4: {0: 5, 1: 5},
  5: {0: 6, 1: 6},
  6: {0: 7, 1: 7},
  7: {0: 8, 1: 8},
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
        title: const Text('Friendship Story'),
        leading: _storyIndex > 0
            ? IconButton(
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back),
              )
            : null,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/Dream_clouds.jpeg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
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
                          offset: Offset(0, 3),
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
                        padding: EdgeInsets.only(bottom: index == 0 ? 10.0 : 0.0),
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
