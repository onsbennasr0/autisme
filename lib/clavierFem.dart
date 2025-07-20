// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CommunicationAid(),
    );
  }
}

class CommunicationAid extends StatefulWidget {
  const CommunicationAid({super.key});

  @override
  _CommunicationAidState createState() => _CommunicationAidState();
}

class _CommunicationAidState extends State<CommunicationAid> {
  String sentence = '';
  String currentCategory = '';
  List<String> pronomPersonnel = ['Je','Tu','Il','Elle','Nous','Vous','Ils','Elles','On','Me','Te','Se','Le','La','Les','Lui','Leur','En','Y','suis','es','est','sommes','êtes','sont'];
  List<String> nombre = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  List<String> couleur = ['bleu', 'blanc', 'rouge', 'jaune', 'vert', 'orange', 'marron', 'rose', 'noir', 'gris', 'violet'];
  List<String> nourriture = ['Pomme', 'Banane', 'Orange', 'Fraise', 'Raisin', 'Pastèque', 'Ananas', 'Pêche', 'Poire', 'Cerise'];
  List<String> Sentiments = ['Heureuse', 'Triste', 'En colère', 'Excitée', 'Fatiguée', 'Confuse', 'Surprise', 'Inquiète', 'Nerveuse', 'Contente', 'Calme', 'Solitaire', 'Aimée', 'Fière', 'Ennuyée', 'Timide', 'Amusée', 'Déçue'];
  List<String> medicale = ['Médecin', 'Infirmier', 'Hôpital', 'Médicament', 'Ordonnance', 'Rendez-vous', 'Chirurgie', 'Examen', 'Diagnostic', 'Traitement', 'Rétablissement', 'Vaccin', 'Urgence', 'Symptôme', 'Maladie', 'Blessure', 'Douleur', 'Thérapie', 'Rééducation'];
  List<String> activites = ['Jouer', 'Sports', 'Exercice', 'Danse', 'Musique', 'Art', 'Lecture', 'Écriture', 'Cuisine', 'Pâtisserie', 'Jardinage', 'Randonnée', 'Camping', 'Natation', 'Cyclisme', 'Pêche', 'Peinture', 'Dessin', 'Bricolage', 'Yoga'];
  List<String> verbe = ['Courir', 'Marcher', 'Sauter', 'Manger', 'Boire', 'Dormir', 'Se réveiller', 'S asseoir', 'Se lever', 'Parler', 'Écouter', 'Lire', 'Écrire', 'Danser', 'Chanter', 'Jouer', 'Travailler', 'Étudier', 'Cuisiner', 'Nettoyer'];
  List<String> Phrases = ['Bonjour', 'Au revoir', 'S il vous plaît', 'Merci', 'Oui', 'Non', 'Excusez-moi', 'Désolé', 'Aidez-moi', 'Comment ça va ?', 'Ça va bien, merci', 'Comment vous appelez-vous ?', 'Je m appelle...', 'Où est...?', 'Ici', 'Là-bas', 'Aujourd hui', 'Demain', 'Hier', 'Maintenant', 'Plus tard', 'Avant', 'Après'];
  List<String> Vehicules = ['Voiture', 'Bus', 'Camion', 'Moto', 'Vélo', 'Train', 'Avion', 'Bateau', 'Navire', 'Taxi', 'Hélicoptère', 'Sous-marin', 'Jet', 'Tramway', 'Ambulance', 'Camion de pompiers', 'Voiture de police'];
  List<String> vetements = ['Chemise', 'T-shirt', 'Pantalon', 'Jeans', 'Robe', 'Jupe', 'Veste', 'Manteau', 'Pull', 'Chemisier', 'Short', 'Chaussettes', 'Chaussures', 'Bottes', 'Chapeau', 'Gants', 'Écharpe', 'Cravate', 'Ceinture', 'Sous-vêtements'];
  List<String> Questions = ['qui', 'quoi', 'où', 'pourquoi', 'comment', 'est-ce que je peux', 'est-ce que tu', 'Quand', 'Combien'];
  

  

  void addToSentence(String word) {
    setState(() {
      sentence += ' $word';
    });
  }

  void deleteLastWord() {
    setState(() {
      if (sentence.isNotEmpty) {
        sentence = sentence.substring(0, sentence.lastIndexOf(' '));
      }
    });
  }

  void openCategory(String category) {
    setState(() {
      currentCategory = category;
    });
  }

  Widget buildWordsList(List<String> words) {
  return Expanded(
    child: GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      children: List.generate(
        words.length,
        (index) => ElevatedButton(
          onPressed: () {
            addToSentence(words[index]);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16), backgroundColor: const Color.fromARGB(255, 229, 238, 247), // Adjust button color as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
            ),
          ),
          child: Text(
            words[index],
            style: const TextStyle(fontSize: 15), // Adjust font size as needed
          ),
        ),
      ),
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Image.asset(
                'assets/settings.png', 
                width: 24, 
                height: 24, 
              ),
              onChanged: (String? value) {
                // Add functionality here based on the selected value
              },
              items: const <String>[
                'Settings 1',
                'Settings 2',
                'Settings 3',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryButton(
                    category: 'Pronom Personnel',
                    onPressed: () {
                      openCategory('pronomPersonnel');
                    },
                    image: 'assets/pronouns.png',
                  ),
                  CategoryButton(
                    category: 'Nombre',
                    onPressed: () {
                      openCategory('nombre');
                    },
                    image: 'assets/numbers.png',
                  ),
                  CategoryButton(
                    category: 'Couleur',
                    onPressed: () {
                      openCategory('couleur');
                    },
                    image: 'assets/colors.png',
                  ),
                  CategoryButton(
                    category: 'Nourriture',
                    onPressed: () {
                      openCategory('nourriture');
                    },
                    image: 'assets/food.png',
                  ),
                  CategoryButton(
                    category: 'Sentiments',
                    onPressed: () {
                      openCategory('Sentiments');
                    },
                    image: 'assets/feelings.png',
                  ),
                  CategoryButton(
                    category: 'Medicale',
                    onPressed: () {
                      openCategory('medicale');
                    },
                    image: 'assets/medicin.png',
                  ),
                  CategoryButton(
                    category: 'Phrases',
                    onPressed: () {
                      openCategory('Phrases');
                    },
                    image: 'assets/phrases.png',
                  ),
                  CategoryButton(
                    category: 'Verbe',
                    onPressed: () {
                      openCategory('verbe');
                    },
                    image: 'assets/verbs.png',
                  ),
                  CategoryButton(
                    category: 'Questions',
                    onPressed: () {
                      openCategory('Questions');
                    },
                    image: 'assets/question.png',
                  ),
                  CategoryButton(
                    category: 'Vehicules',
                    onPressed: () {
                      openCategory('Vehicules');
                    },
                    image: 'assets/vehiculs.png',
                  ),
                  CategoryButton(
                    category: 'Vetements',
                    onPressed: () {
                      openCategory('vetements');
                    },
                    image: 'assets/clothes.png',
                  ),
                  CategoryButton(
                    category: 'Activites',
                    onPressed: () {
                      openCategory('activites');
                    },
                    image: 'assets/activity.png',
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 100, 
                  child: ListView(
                    reverse: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              sentence.isEmpty ? 'Start typing here...' : sentence,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 167, 190, 229),
                        ),
                        child: TextButton(
                          onPressed: deleteLastWord,
                          child: const Text('Delete', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 112, 140, 188),
                        ),
                        
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                if (currentCategory == 'pronomPersonnel')buildWordsList(pronomPersonnel),
                if (currentCategory == 'nombre') buildWordsList(nombre),
                if (currentCategory == 'couleur') buildWordsList(couleur),
                if (currentCategory == 'nourriture') buildWordsList(nourriture),
                if (currentCategory == 'Sentiments') buildWordsList(Sentiments),
                if (currentCategory == 'medicale') buildWordsList(medicale),
                if (currentCategory == 'activites') buildWordsList(activites),
                if (currentCategory == 'verbe') buildWordsList(verbe),
                if (currentCategory == 'Phrases') buildWordsList(Phrases),
                if (currentCategory == 'Vehicules') buildWordsList(Vehicules),
                if (currentCategory == 'vetements') buildWordsList(vetements),
                if (currentCategory == 'Questions') buildWordsList(Questions),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final String image;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.category,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjust padding as needed
        minimumSize: const Size(150, 48), // Set minimum width and height for the button
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8), // Adjust spacing between image and text as needed
          Expanded(
            child: Text(
              category,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15), // Adjust font size as needed
            ),
          ),
        ],
      ),
    );
  }
}