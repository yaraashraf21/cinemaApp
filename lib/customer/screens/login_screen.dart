import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/app_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isRegister = false;

  void _handleAuth() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill in all fields');
      return;
    }

    if (_isRegister) {
      final confirmPassword = _confirmPasswordController.text.trim();
      if (password != confirmPassword) {
        _showMessage('Passwords do not match!');
        return;
      }

      if (AppState.users.any((u) => u.email == email)) {
        _showMessage('User already exists!');
        return;
      }

      final newUser = User(
        email: email,
        password: password,
        name: email.split('@')[0],
      );
      AppState.users.add(newUser);
      _navigateToHome(newUser);
    } else {
      final user = AppState.users.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse: () => User(email: '', password: '', name: ''),
      );
      if (user.email.isEmpty) {
        _showMessage('Invalid credentials!');
        return;
      }
      _navigateToHome(user);
    }
  }

  void _navigateToHome(User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade900, Colors.blue.shade900],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🎬', style: TextStyle(fontSize: 64)),
                      const SizedBox(height: 16),
                      Text(
                        'Cinema Booking',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isRegister ? 'Create Account' : 'Welcome Back',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      if (_isRegister) const SizedBox(height: 16),
                      if (_isRegister)
                        TextField(
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                        ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            _isRegister ? 'Register' : 'Login',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isRegister = !_isRegister;
                          });
                        },
                        child: Text(
                          _isRegister
                              ? 'Already have an account? Login'
                              : "Don't have an account? Register",
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Demo Accounts:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('user1@example.com / password123'),
                            Text('user2@example.com / password123'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import '../models/user.dart';
// import '../services/app_state.dart';
// import 'home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _fullNameController = TextEditingController(); // Full Name
//   bool _isRegister = false;
//   bool _loading = false;

//   void _handleAuth() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final fullName = _fullNameController.text.trim();

//     if (email.isEmpty || password.isEmpty || (_isRegister && fullName.isEmpty)) {
//       _showMessage('Please fill in all fields');
//       return;
//     }

//     setState(() => _loading = true);

//     if (_isRegister) {
//       final confirmPassword = _confirmPasswordController.text.trim();
//       if (password != confirmPassword) {
//         _showMessage('Passwords do not match!');
//         setState(() => _loading = false);
//         return;
//       }

//       final newUser = await AppState.registerUser(email, fullName, password);
//       setState(() => _loading = false);

//       if (newUser == null) {
//         _showMessage('User already exists!');
//         return;
//       }

//       _navigateToHome(newUser);
//     } else {
//       final user = await AppState.loginUser(email, password);
//       setState(() => _loading = false);

//       if (user == null) {
//         _showMessage('Invalid credentials!');
//         return;
//       }

//       _navigateToHome(user);
//     }
//   }

//   void _navigateToHome(User user) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.purple.shade900, Colors.blue.shade900],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(32.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text('🎬', style: TextStyle(fontSize: 64)),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Cinema Booking',
//                         style: Theme.of(context).textTheme.headlineMedium
//                             ?.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         _isRegister ? 'Create Account' : 'Welcome Back',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyLarge
//                             ?.copyWith(color: Colors.grey),
//                       ),
//                       const SizedBox(height: 24),
//                       if (_isRegister)
//                         TextField(
//                           controller: _fullNameController,
//                           decoration: const InputDecoration(
//                             labelText: 'Full Name',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.person),
//                           ),
//                         ),
//                       if (_isRegister) const SizedBox(height: 16),
//                       TextField(
//                         controller: _emailController,
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.email),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         controller: _passwordController,
//                         decoration: const InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.lock),
//                         ),
//                         obscureText: true,
//                       ),
//                       if (_isRegister) const SizedBox(height: 16),
//                       if (_isRegister)
//                         TextField(
//                           controller: _confirmPasswordController,
//                           decoration: const InputDecoration(
//                             labelText: 'Confirm Password',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.lock_outline),
//                           ),
//                           obscureText: true,
//                         ),
//                       const SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: _loading ? null : _handleAuth,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.purple,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: _loading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white)
//                               : Text(
//                                   _isRegister ? 'Register' : 'Login',
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             _isRegister = !_isRegister;
//                           });
//                         },
//                         child: Text(_isRegister
//                             ? 'Already have an account? Login'
//                             : "Don't have an account? Register"),
//                       ),
//                       const SizedBox(height: 24),
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               'Demo Accounts:',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 8),
//                             Text('user1@example.com / password123'),
//                             Text('user2@example.com / password123'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _fullNameController.dispose();
//     super.dispose();
//   }
// }
