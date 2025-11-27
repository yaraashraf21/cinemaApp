import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/movie.dart';
import 'seat_selection_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  final User user;
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.user, required this.movie})
    : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  String? _selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.blue.shade400],
                ),
              ),
              child: Center(
                child: Text(
                  widget.movie.emoji,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Select Time Slot',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.movie.timeSlots.map((slot) {
                      final isSelected = _selectedTimeSlot == slot;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTimeSlot = slot;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.purple.shade50
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.purple
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: isSelected ? Colors.purple : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                slot,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.purple
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (_selectedTimeSlot != null) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeatSelectionScreen(
                                user: widget.user,
                                movie: widget.movie,
                                timeSlot: _selectedTimeSlot!,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Continue to Seat Selection',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/user.dart';
// import '../models/movie.dart';
// import 'seat_selection_screen.dart';

// class MovieDetailsScreen extends StatefulWidget {
//   final User user;
//   final Movie movie;

//   const MovieDetailsScreen({Key? key, required this.user, required this.movie})
//       : super(key: key);

//   @override
//   State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
// }

// class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
//   String? _selectedTimeSlot;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.movie.title),
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Poster Image بدل Emoji
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(widget.movie.posterUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.movie.description,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Select Time Slot',
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: widget.movie.timeSlots.map((slot) {
//                       final isSelected = _selectedTimeSlot == slot;
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             _selectedTimeSlot = slot;
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 16,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.purple.shade50
//                                 : Colors.white,
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.purple
//                                   : Colors.grey.shade300,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.access_time,
//                                 color: isSelected ? Colors.purple : Colors.grey,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 slot,
//                                 style: TextStyle(
//                                   color:
//                                       isSelected ? Colors.purple : Colors.black,
//                                   fontWeight: isSelected
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   if (_selectedTimeSlot != null) ...[
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SeatSelectionScreen(
//                                 user: widget.user,
//                                 movie: widget.movie,
//                                 timeSlot: _selectedTimeSlot!,
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.purple,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Continue to Seat Selection',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
