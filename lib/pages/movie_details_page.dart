// import 'package:flutter/material.dart';
// import 'package:movie_app/models/movie_data_class.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

// class MovieDetailsPage extends StatefulWidget {
//   final Movie movie;

//   const MovieDetailsPage({super.key, required this.movie});

//   @override
//   _MovieDetailsPageState createState() => _MovieDetailsPageState();
// }

// class _MovieDetailsPageState extends State<MovieDetailsPage> {
//   VideoPlayerController? _videoController;
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the video controller with the trailer from assets
//     _videoController = VideoPlayerController.asset(widget.movie.trailerUrl)
//       ..initialize().then((_) {
//         if (!mounted) return; // Check if the widget is still mounted
//         setState(() {
//           // Initialize the Chewie controller
//           _chewieController = ChewieController(
//             videoPlayerController: _videoController!,
//             autoPlay: true,
//             looping: false,
//             aspectRatio: _videoController!.value.aspectRatio, // Correct aspect ratio
//           );
//         });
//       });
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.movie.movieName),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 400, 
//             child: Chewie(
//               controller: _chewieController!,
//             ),
//           ),
//           const SizedBox(height: 16.0),

//           // Additional movie details go here...
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.movie.movieName,
//                     style: const TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.redAccent,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           '${widget.movie.rating} / 10',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         "Director: ${widget.movie.director}",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Release Date: ${widget.movie.releaseDate.year}",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey[800],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   const Text(
//                     "Description:",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     widget.movie.description,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Theme.of(context).colorScheme.inversePrimary,
//                       height: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   const Text(
//                     "Cast:",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     widget.movie.cast.join(', '),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Theme.of(context).colorScheme.inversePrimary,
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).pop(); // Go back to the previous screen
//         },
//         child: const Icon(Icons.arrow_back),
//       ),
//     );
//   }
// }


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
  bool _showPoster = true; // State to control poster visibility

  @override
  void initState() {
    super.initState();

    // Initialize the video controller with the trailer from assets
    _videoController = VideoPlayerController.asset(widget.movie.trailerUrl)
      ..initialize().then((_) {
        if (!mounted) return; // Check if the widget is still mounted

        setState(() {
          _isVideoInitialized = true;
        });

        // Delay for 1 second, then show the video
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _showPoster = false; // Hide the poster
          });
          _initializeChewieController(); // Initialize Chewie controller
          _videoController?.play(); // Start playing the video
        });
      });
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoController!.value.aspectRatio, // Correct aspect ratio
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
          // Container to hold both poster and video player
          Container(
            height: 400, // Set a fixed height for visibility
            child: Stack(
              children: [
                // Show the poster if it is still visible
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

          // Additional movie details go here...
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
          Navigator.of(context).pop(); // Go back to the previous screen
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
