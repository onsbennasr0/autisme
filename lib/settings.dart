import 'package:flutter/material.dart';
// For iOS style widgets

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner for a cleaner look
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // A sophisticated primary color
        hintColor: Colors.amber, // Accent color for contrast
        visualDensity: VisualDensity.adaptivePlatformDensity,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.indigoAccent),
          trackColor: MaterialStateProperty.all(Colors.indigo[100]),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[600]),
          titleMedium: TextStyle(color: Colors.indigo[400]),
        ),
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationEnabled = true;
  bool showActivityStatus = true;
  bool darkModeEnabled = false; // New setting for dark mode
  String language = 'English'; // New setting for language selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildSwitchTile(
            title: 'Enable Notifications',
            subtitle: 'Receive notifications for updates and announcements.',
            value: notificationEnabled,
            onChanged: (bool value) {
              setState(() {
                notificationEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Show Activity Status',
            subtitle: 'Let others see when you’re active.',
            value: showActivityStatus,
            onChanged: (bool value) {
              setState(() {
                showActivityStatus = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Dark Mode',
            subtitle: 'Enable dark theme for better night-time reading.',
            value: darkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                darkModeEnabled = value;
                // Additional logic to toggle dark mode in your app
              });
            },
          ),
          _buildListTile(
            title: 'Language',
            subtitle: 'Select your preferred language.',
            icon: Icons.language,
            onTap: () => _showLanguageDialog(),
          ),
          _buildListTile(
            title: 'Account',
            subtitle: 'Manage your account settings',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({required String title, String? subtitle, required bool value, required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.secondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }

  Widget _buildListTile({required String title, String? subtitle, required IconData icon, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Language"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("English"),
                  onTap: () {
                    setState(() {
                      language = 'English';
                      Navigator.pop(context);
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Español"),
                  onTap: () {
                    setState(() {
                      language = 'Español';
                      Navigator.pop(context);
                    });
                  },
                ),
                // Add more languages as needed
              ],
            ),
          ),
        );
      },
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Center(
        child: Text(
          'Account settings page',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
