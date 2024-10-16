import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hardcoded list of favorite movies with local assets
    final List<Map<String, String>> favoriteMovies = [
      {
        'title': 'Inception',
        'image': 'lib/Assets/movie_posters/lacasa de papel.jpeg',
        'rating': '8.8'
      },
      {
        'title': 'The Dark Knight',
        'image': 'lib/Assets/movie_posters/lacasa de papel.jpeg',
        'rating': '9.0'
      },
      {
        'title': 'Interstellar',
        'image': 'lib/Assets/movie_posters/lacasa de papel.jpeg',
        'rating': '8.6'
      },
      {
        'title': 'Fight Club',
        'image': 'lib/Assets/movie_posters/lacasa de papel.jpeg',
        'rating': '8.8'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: favoriteMovies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 10, 
            mainAxisSpacing: 10, 
            childAspectRatio: 0.7, 
          ),
          itemBuilder: (context, index) {
            final movie = favoriteMovies[index];
            return Stack(
              children: [
                // Movie Card
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(movie['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Movie Details
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            movie['rating']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Remove Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${movie['title']} removed from favorites')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
