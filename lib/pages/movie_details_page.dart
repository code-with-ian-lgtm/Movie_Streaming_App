import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_data_class.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _showPoster = true; 
  bool _isFavorite = false; 

  // List to keep track of favorite movies
  List<Movie> _favorites = [];

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset(widget.movie.trailerUrl)
      ..initialize().then((_) {
        if (!mounted) return; 

        setState(() {
          _isVideoInitialized = true;
        });

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _showPoster = false; 
          });
          _initializeChewieController(); 
          _videoController?.play(); 
        });
      });
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoController!.value.aspectRatio, 
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite; 
      if (_isFavorite) {
        addToFavorites(widget.movie); 
      } else {
        removeFromFavorites(widget.movie); 
      }
    });
  }

  // Method to add a movie to favorites
  void addToFavorites(Movie movie) {
    if (!_favorites.contains(movie)) {
      _favorites.add(movie);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.movieName} added to favorites!')),
      );
    }
  }

  // Method to remove a movie from favorites
  void removeFromFavorites(Movie movie) {
    _favorites.remove(movie);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${movie.movieName} removed from favorites!')),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.movieName),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 400, 
            child: Stack(
              children: [
                if (_showPoster)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                    child: Image.asset(
                      widget.movie.posterUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                // Display the video player after the poster
                if (_isVideoInitialized && !_showPoster)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.movieName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${widget.movie.rating} / 10',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Director: ${widget.movie.director}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Add to favorites button
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: _isFavorite ? Colors.red : Colors.grey,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Release Date: ${widget.movie.releaseDate.year}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.movie.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Cast:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.movie.cast.join(', '),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
