// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'side_menu.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Montserrat',
    ),
    home: const RessourcesPage(),
  ));
}

class RessourcesPage extends StatelessWidget {
  const RessourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Ressources pour les parents', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 80, 142, 209),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),  // Icon changed to menu for clarity
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const SideMenuPage(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 80, 142, 209),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Dix conseils pour communiquer avec un enfant autiste.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTip(
              '1. Favorisez des jeux en lien avec les intérêts de l’enfant',
            ),
            _buildTip(
              '2. Mettez-vous à la hauteur de l’enfant, afin de favoriser une communication face à face et faciliter l’échange',
            ),
            _buildTip(
              '3. Mettez l’accent sur les mots importants',
            ),
            _buildTip(
              '4. Utilisez des supports visuels (gestes, photos, images)',
            ),
            _buildTip(
              '5. Ajustez votre niveau de langage à celui de l’enfant, en utilisant des énoncés juste un peu plus longs que ceux qu’il produit',
            ),
            _buildTip(
              '6. Répétez souvent les mêmes mots, dans différents contextes, afin de favoriser l’apprentissage du vocabulaire',
            ),
            _buildTip(
              '7. Parlez beaucoup de ce que qu’on fait, ou de ce que l’enfant fait, afin de donner des modèles de petits énoncés adéquats',
            ),
            _buildTip(
              '8. Exagérez les expressions et les exclamations pour susciter une réaction chez l’enfant',
            ),
            _buildTip(
              '9. Stimulez la communication dans des contextes naturels de la vie quotidienne (ex : lors des repas, du bain, des jeux)',
            ),
            _buildTip(
              '10. Gardez en tête que la communication se stimule dans le plaisir.',
            ),

            const SizedBox(height: 20.0),

            // Adresses et numéros de professionnels
            _buildSectionTitle('Adresses et numéros de professionnels :'),
            const SizedBox(height: 10.0),
            _buildInfo(
              'Psychologues spécialisés :',
              'Dr. Olfa Moussa\nAdresse : 3  rue khadouja themri, Tunis, \nTél : 27 548 330',
            ),
            _buildInfo(
              'Centre des enfants autiste :',
              'Adresse :  R46W+4FX, Rue des Orangers\nTél : 96 379 080',
            ),
            const SizedBox(height: 20.0),

            // Liens vers une playlist de musique
            _buildSectionTitle('Playlist de musique apaisante :'),
            const SizedBox(height: 10.0),
            _buildLink(
              'Écoutez notre playlist de musique relaxante sur Spotify',
              'https://open.spotify.com/playlist/37i9dQZF1DZ06evNZYQgXS',
            ),
            const SizedBox(height: 20.0),

            // Liens vers des jeux pour les enfants autistes
            _buildSectionTitle('Jeux pour les enfants autistes :'),
            const SizedBox(height: 10.0),
            _buildLink(
              'Jouez à des jeux interactifs sur Autisme-Education',
              'https://play.google.com/store/apps/details?id=com.auticiel.autimo&hl=fr',
            ),
            _buildLink(
              'Découvrez des jeux éducatifs sur Autism Speaks',
              'https://play.google.com/store/apps/details?id=com.talkingfriend.toucan&hl=fr&gl=US',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 80, 142, 209),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline, color: Color.fromARGB(255, 80, 142, 209),),
        title: Text(
          tip,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String details) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              details,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    // Handle the error or inform the user
    print('Could not launch $url');
  }
}



  Widget _buildLink(String text, String url) {
  return InkWell(
    onTap: () => _launchUrl(url),
    child: Row(
      mainAxisSize: MainAxisSize.min, // Ensures the Row only takes needed space
      children: [
        Icon(Icons.link, color: Colors.blue[800], size: 20),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.blue[800],
            decoration: TextDecoration.underline,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
}
