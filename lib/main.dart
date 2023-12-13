import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _usernameError = '';
  String _passwordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(size: 70),
                SizedBox(width: 4),
                Text('Flutter',
                    style:
                        TextStyle(fontSize: 30, fontStyle: FontStyle.normal)),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              _usernameError,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            Text(
              _passwordError,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text.trim();
                String password = _passwordController.text.trim();

                setState(() {
                  _usernameError = '';
                  _passwordError = '';
                });

                if (!_validateInputs(username, password)) {
                  return;
                }

                // Başarılı giriş olduğunda SnackBar göster
                _showSnackBar('Email: $username\nPassword: $password');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("New User?"),
                TextButton(
                  onPressed: () {},
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs(String username, String password) {
    if (username.isEmpty && password.isEmpty) {
      setState(() {
        _usernameError = 'Please enter your email';
        _passwordError = 'Please enter your password';
      });
      return false;
    } else if (username.isEmpty) {
      setState(() {
        _usernameError = 'Please enter your email';
        _passwordError = '';
      });
      return false;
    } else if (password.isEmpty) {
      setState(() {
        _usernameError = '';
        _passwordError = 'Please enter your password';
      });
      return false;
    }
    return true;
  }

  void _showSnackBar(String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
