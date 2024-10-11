import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, 
      child: Stack(
        children: [
          // Movie poster background image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            child: Image.asset(
              'lib/Assets/movie_posters/power.jpeg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 500,
            ),
          ),

          // Gradient overlay for a dark effect at the bottom of the banner
          Positioned(
            bottom: 0,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          // Overlaying movie title and buttons
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Power',
                  style: TextStyle(
                    fontSize: 36, // Increased font size for title
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0, // Remove elevation
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.play_arrow, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'Play',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18, // Slightly larger font size
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0, // Remove elevation
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'More Info',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18, // Slightly larger font size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
