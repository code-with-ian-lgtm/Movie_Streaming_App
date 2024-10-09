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
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ListView(
            children: [
              ListTile(
                title: Text("DarkMode"),
                leading: Icon(Icons.dark_mode),
                trailing: Consumer<ThemeProvider>(builder: ((context,ThemeProvider,value){
                  return CupertinoSwitch(value: ThemeProvider.isDarkMode, onChanged: (bool value){
                    ThemeProvider.toggleTheme();
                  });
                }),
              ))
            ],
          )
        ],
      ),
    );
  }
}