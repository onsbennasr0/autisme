import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // Import your Firebase options file
import 'espace.dart';
import 'face.dart';
import 'loginenfant.dart';
import 'thememodel.dart'; // Import the ThemeModel class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(), // Create an instance of ThemeModel
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      // Use Consumer to access the ThemeModel
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme:
              themeProvider.getTheme(), // Set the theme based on the ThemeModel
          routes: {
            '/': (context) => const EspacePage(),
            '/loginenfant': (context) => const LoginenfantPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/face') {
              // Extracting arguments passed to the FacePage
              final Map<String, dynamic>? args =
                  settings.arguments as Map<String, dynamic>?;

              // Check if the arguments are not null
              if (args != null) {
                return MaterialPageRoute(
                  builder: (context) => FacePage(
                    useremailenfant: args['useremailenfant'],
                    informations: args['informations'],
                    userEmail: '',
                    userName: '',
                  ),
                );
              }
            }
            return null;
          },
        );
      },
    );
  }
}