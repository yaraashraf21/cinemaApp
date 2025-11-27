import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/movie.dart';
import '../services/app_state.dart';
import 'movie_details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  List<Movie> get _filteredMovies {
    if (_searchQuery.isEmpty) return AppState.movies;
    return AppState.movies
        .where(
          (m) => m.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Cinema Booking'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                widget.user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search movies by title...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Now Showing',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredMovies.isEmpty
                ? const Center(child: Text('No movies found'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = _filteredMovies[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                  user: widget.user,
                                  movie: movie,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple.shade400,
                                      Colors.blue.shade400,
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    movie.emoji,
                                    style: const TextStyle(fontSize: 80),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      movie.description,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 16),
                                        const SizedBox(width: 4),
                                        Text('${movie.timeSlots.length} slots'),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.people, size: 16),
                                        const SizedBox(width: 4),
                                        Text('${movie.totalSeats} seats'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/user.dart';
// import '../models/movie.dart';
// import '../services/app_state.dart';
// import 'movie_details_screen.dart';
// import 'login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   final User user;

//   const HomeScreen({Key? key, required this.user}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String _searchQuery = '';
//   List<Movie> _movies = [];
//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchMovies();
//   }

//   void _fetchMovies() async {
//     final movies = await AppState.getMovies();
//     setState(() {
//       _movies = movies;
//       _loading = false;
//     });
//   }

//   List<Movie> get _filteredMovies {
//     if (_searchQuery.isEmpty) return _movies;
//     return _movies
//         .where((m) => m.title.toLowerCase().contains(_searchQuery.toLowerCase()))
//         .toList();
//   }

//   void _logout() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('🎬 Cinema Booking'),
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Center(
//               child: Text(
//                 widget.user.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.purple,
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: (value) => setState(() => _searchQuery = value),
//               decoration: InputDecoration(
//                 hintText: 'Search movies by title...',
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Now Showing',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineSmall
//                     ?.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _filteredMovies.isEmpty
//                     ? const Center(child: Text('No movies found'))
//                     : ListView.builder(
//                         padding: const EdgeInsets.all(16.0),
//                         itemCount: _filteredMovies.length,
//                         itemBuilder: (context, index) {
//                           final movie = _filteredMovies[index];
//                           return Card(
//                             elevation: 4,
//                             margin: const EdgeInsets.only(bottom: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => MovieDetailsScreen(
//                                       user: widget.user,
//                                       movie: movie,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Poster Image
//                                   Container(
//                                     height: 150,
//                                     decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(15),
//                                         topRight: Radius.circular(15),
//                                       ),
//                                       image: DecorationImage(
//                                         image: NetworkImage(movie.posterUrl),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           movie.title,
//                                           style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           movie.description,
//                                           style: TextStyle(
//                                             color: Colors.grey.shade600,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 12),
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.access_time, size: 16),
//                                             const SizedBox(width: 4),
//                                             Text('${movie.timeSlots.length} slots'),
//                                             const SizedBox(width: 16),
//                                             const Icon(Icons.people, size: 16),
//                                             const SizedBox(width: 4),
//                                             Text('${movie.totalSeats} seats'),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }
