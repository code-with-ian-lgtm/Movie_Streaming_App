import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ThemeProvider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        //Movie Provider
        ChangeNotifierProvider(create: (context) => MovieStream())
      ],
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}