// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: QuizPage()));
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _correctAnswersCount = 0;
  bool _isQuizFinished = false;
  int? _selectedAnswer;

  final List<Map<String, dynamic>> _quizData = [
    {
      'question': 'Comment les parents peuvent-ils aider leur enfant autiste à développer des compétences sociales ?',
      'options': [
        'En évitant les interactions sociales',
        'En pratiquant le tour de rôle et le partage à la maison',
        'En interagissant seulement avec d’autres enfants autistes',
        'Aucune des réponses ci-dessus'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Quelle stratégie éducative est souvent efficace pour les enfants autistes ?',
      'options': [
        'Aides visuelles et emplois du temps',
        'Grandes tailles de classe',
        'Changements fréquents de routine',
        'Environnements d’apprentissage compétitifs'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Lequel des énoncés suivants est un mythe sur l’autisme ?',
      'options': [
        'L’autisme affecte les garçons et les filles',
        'Les personnes autistes peuvent ressentir des émotions',
        'Les personnes autistes peuvent vivre de manière indépendante',
        'Les vaccins causent l’autisme'
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Comment les parents peuvent-ils soutenir leur enfant autiste ?',
      'options': [
        'En cherchant des services d’intervention précoce',
        'En maintenant une routine constante',
        'En se renseignant sur l’autisme',
        'Toutes les réponses ci-dessus'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Lequel des éléments suivants peut être un signe précoce d’autisme chez les enfants ?',
      'options': [
        'Préférer jouer seul',
        'Retard dans le développement de la parole',
        'Éviter le contact visuel',
        'Toutes les réponses ci-dessus'
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Qu’est-ce que le Trouble du Spectre de l’Autisme (TSA) ?',
      'options': [
        'Un résultat de mauvaise parentalité',
        'Un trouble du développement qui affecte la communication et le comportement',
        'Un handicap d’apprentissage',
        'Une maladie qui doit être guérie'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Votre enfant montre des signes de détresse mais a du mal à exprimer ce qui ne va pas. Laquelle des stratégies suivantes pourrait vous aider à comprendre les besoins de votre enfant ?',
      'options': [
        'Offrir un choix de visuels pour exprimer les sentiments',
        'Poser des questions par oui ou par non',
        'Donner de l’espace et du temps',
        'Toutes les réponses ci-dessus'
      ],
      'correctAnswerIndex': 3,
    },
    {
      'question': 'Lequel des énoncés suivants est un mythe commun sur l’autisme et la communication ?',
      'options': [
        'Tous les individus autistes sont non-verbaux',
        'L’autisme empêche les individus de comprendre les émotions',
        'Non-verbal signifie non communicatif',
        'Aucune des réponses ci-dessus'
      ],
      'correctAnswerIndex': 3,
    },
    {
      'question': 'Quelle est une sensibilité sensorielle commune vécue par les individus avec autisme ?',
      'options': [
        'Hypersensibilité au son',
        'Aucune sensibilité au toucher',
        'Aucune sensibilité à la lumière',
        'Aucune sensibilité au goût'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Lors de l’introduction d’une nouvelle routine quotidienne à votre enfant, quelle stratégie pourrait aider à faciliter la transition ?',
      'options': [
        'Emplois du temps visuels',
        'Changements soudains',
        'Aucun avertissement préalable',
        'Punitions pour non-conformité'
      ],
      'correctAnswerIndex': 0,
    },
  ];

  void _nextQuestion(int selectedIndex) {
  final correctAnswerIndex = _quizData[_currentQuestionIndex]['correctAnswerIndex'];
  bool isCorrect = selectedIndex == correctAnswerIndex;

  // Update the UI immediately to reflect the selected answer
  setState(() {
    _selectedAnswer = selectedIndex;
  });

  // Wait for a short duration before moving to the next question
  Future.delayed(const Duration(milliseconds: 500), () {
    if (isCorrect) {
      _correctAnswersCount++;
    }

    if (_currentQuestionIndex < _quizData.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null; // Reset selected answer for the next question
      });
    } else {
      setState(() {
        _isQuizFinished = true;
      });
    }
  });
}



  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _correctAnswersCount = 0;
      _isQuizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parental Engagement Quiz'),
      ),
      body: !_isQuizFinished ? buildQuiz() : buildResults(),
    );
  }

  Widget buildQuiz() {
  final currentQuestion = _quizData[_currentQuestionIndex];
  final correctAnswerIndex = currentQuestion['correctAnswerIndex'];
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/Dream_clouds.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question text
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            
          ),
          child: Text(
            currentQuestion['question'],
            style: const TextStyle(fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(height: 20.0),
        // Options
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(), // Add a bouncing effect to the list
            itemBuilder: (context, index) {
              String option = currentQuestion['options'][index];
              bool isSelected = index == _selectedAnswer;
              Color backgroundColor = isSelected
                  ? (isSelected && index == correctAnswerIndex ? Colors.green : Colors.red)
                  : const Color.fromARGB(255, 218, 238, 247); // Neutral color for unselected options

              return ElevatedButton(
                onPressed: () => _nextQuestion(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor, // Use the backgroundColor variable here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                child: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87, // Custom color for text
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10), // Space between buttons
            itemCount: currentQuestion['options'].length,
          ),
        ),
      ],
    ),
  );
}


  Widget buildResults() {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
            Text(
              'Félicitations, vous avez terminé le quiz !\nVous avez obtenu $_correctAnswersCount sur ${_quizData.length} correctes !',              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _restartQuiz,
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 238, 247)),
              child: const Text(
                'Recommencer le Quiz',
                style: TextStyle(color: Colors.black54, fontSize: 18.0,), // Change the text color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
