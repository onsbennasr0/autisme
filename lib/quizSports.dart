// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

import 'ppp.dart';

void main() {
  runApp(const MaterialApp(home: SoccerStory()));
}

class SoccerStory extends StatefulWidget {
  const SoccerStory({super.key});

  @override
  _SoccerStoryState createState() => _SoccerStoryState();
}

class _SoccerStoryState extends State<SoccerStory> {
  int _storyIndex = 0;
  final List<int> _previousScenes = []; // Track previous scenes

  final List<String> _storyTexts = [
    "It's your first big soccer match! You feel excited but also a bit nervous as you approach the field, hearing the cheers and chants from the crowd.",
    "The game starts, and you see your teammates passing the ball. What do you want to do?",
    "You decide to join in and pass the ball. You quickly get into the rhythm of the game, feeling less nervous and more excited.",
    "During halftime, you notice a teammate looking upset about missing a goal. What do you do?",
    "You approach your teammate and encourage them, saying everyone makes mistakes and there’s still half a game left to play. They smile and seem to feel better.",
    "Your coach discusses strategies for the second half. What role do you want to take on?",
    "You suggest focusing on defense to protect your lead. The team agrees, and you feel proud to contribute your ideas.",
    "You suggest focusing on offense to increase the team's scoring opportunities. The team agrees, and you feel motivated to lead the attack.",
    "At the end of the match, you reflect on your experiences. Whether you won, learned something new, or helped a teammate, you feel good about your contributions.",
    "You decide to watch the game from the sidelines. While watching, you notice a player on the opposing team making a move you've never seen before. It sparks your curiosity and inspires you to practice more.",
  ];

  final List<List<String>> _choices = [
  ["Start the game!"],
  ["Join in and play", "Watch from the sidelines"],
  ["Continue"],
  ["Encourage them", "Leave them alone"],
  ["Continue"],
  ["Focus on offense", "Focus on defense"],
  ["Continue"],
  ["Finish"], // Final reflection
  ["Finish"], // Scene: You decide to watch the game from the sidelines (spark curiosity)
  ["Finish"], // Scene: You decide to watch the game from the sidelines (learning experience)
  ["Finish"], // Scene: At the end of the match (reflection)
];


  final Map<int, Map<int, int>> _nextSceneMap = {
  1: {0: 2, 1: 9}, // Join in and play leads to passing the ball, Watch from the sidelines leads to choosing a role
  3: {0: 4, 1: 9}, // Encourage them leads to encouraging, Leave them alone leads to reflecting
  4: {0: 5, 1: 9}, // Both choices lead to the same scene of reflecting
  5: {0: 7, 1: 6}, // Both choices lead to the same scene of reflecting
  6: {0: 8, 1: 7}, // Focus on offense leads to offense scene, Focus on defense leads to defense scene
};


  void _nextScene(int choiceIndex) {
  setState(() {
    if (_storyIndex < _storyTexts.length - 1) {
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
        _storyIndex = _previousScenes.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Game Day'),
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
            'assets/Dream_clouds.jpeg', // Ensure you have a soccer field image in assets
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
                      color: Colors.white.withOpacity(0.8),
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
