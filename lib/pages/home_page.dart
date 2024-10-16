import 'package:flutter/material.dart';
import 'package:movie_app/pages/favourites.dart';
import 'package:movie_app/pages/movie_category.dart';
import 'package:movie_app/pages/profile_page.dart';
import 'package:movie_app/pages/settings_page.dart';
import 'package:movie_app/pages/top_pics_row.dart';
import 'package:movie_app/pages/trending_now_row.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(), 
    FavoritesPage(),
    MovieCategoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: _pages,
      physics: BouncingScrollPhysics(),
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Theme.of(context).colorScheme.primary, 
      unselectedItemColor: Theme.of(context).colorScheme.inversePrimary, 
      backgroundColor: Theme.of(context).colorScheme.tertiary, 
      elevation: 8, 
    ),
  );
}

}

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

            // Top picks row
            TopPicks(),
            SizedBox(height: 10,),

            // TrendingNowRow(),
            TopPicks(),
            SizedBox(height: 10,),

            // More top picks
            TopPicks(),
          ],
        ),
      ),
    );
  }
}







