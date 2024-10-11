import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:provider/provider.dart'; 
import 'package:movie_app/models/movie_data_class.dart';
import 'movie_details_page.dart'; 

class TopPicks extends StatelessWidget {
  const TopPicks({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<MovieStream>(context).movies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //row head
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Top Picks",
            style: TextStyle(
              fontSize: 24
            ),
            ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent
            
          ),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, 
            itemCount: movies.length >= 15 ? 15 : movies.length, 
            itemBuilder: (context, index) {
              Movie movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movie: movie),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0), 
                  width: 120, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200], 
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      movie.posterUrl, 
                      fit: BoxFit.cover,
                      height: 200, 
                      width: 120, 
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'Image not found',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
