import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../services/auth.dart';

enum AuthType { login, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisibility = false;

  final GlobalKey _authFormKey = GlobalKey();

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kigundu App',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/podcast_image.jpg'),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text("Sign In With"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: () {
                    Auth().signInWithGoogle();
                  },
                  icon: const FaIcon(FontAwesomeIcons.google),
                ),
                const SizedBox(
                  width: 40,
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.apple),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
