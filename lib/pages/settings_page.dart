import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          Expanded( // Add Expanded here
            child: ListView(
              children: [
                ListTile(
                  title: const Text("DarkMode"),
                  leading: const Icon(Icons.dark_mode),
                  trailing: Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return CupertinoSwitch(
                        value: themeProvider.isDarkMode, // Access the value correctly
                        onChanged: (bool value) {
                          themeProvider.toggleTheme(); // Call the toggle method
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
