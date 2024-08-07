import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/auth.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _authFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(65),
                child: Image.asset(
                  height: 130,
                  width: 130,
                  'assets/images/podcast_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(label: Text("Email")),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: _passwordVisibility,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  suffix: IconButton(
                    onPressed: () {
                      _togglePasswordVisibility();
                    },
                    icon: Icon(
                      _passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.inversePrimary),
                    minimumSize: const WidgetStatePropertyAll<Size>(
                        Size(double.infinity, 40))),
                onPressed: () {},
                child: const Text('Sign In'),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 3,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Or Use",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 3,
                    color: Theme.of(context).colorScheme.secondary,
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
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
      ),
    );
  }
}
