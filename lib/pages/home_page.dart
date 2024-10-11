import 'package:flutter/material.dart';
import 'package:movie_app/pages/settings_page.dart';
import 'package:movie_app/pages/top_pics_row.dart';
import 'package:movie_app/pages/trending_now_row.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            }, 
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TopBanner(),
            SizedBox(height: 10,),

            //Top picks row
            TopPicks(),

            TopPicks(),

            TopPicks()
          ],
        ),
      ),
    );
  }
}
