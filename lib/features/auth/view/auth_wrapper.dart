import 'package:flutter/material.dart';
import 'package:podcasts/features/auth/view/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:podcasts/features/auth/provider/auth_provider.dart';
import 'package:podcasts/Screens/screens.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return StreamBuilder<AuthenticationStatus>(
      stream: provider.status,
      builder:
          (BuildContext context, AsyncSnapshot<AuthenticationStatus> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        AuthenticationStatus status = snapshot.data!;
        switch (status) {
          case AuthenticationStatus.authenticated:
            return const RecordingScreen();
          case AuthenticationStatus.unauthenticated ||
                AuthenticationStatus.unknown:
            return const AuthScreen();
        }
      },
    );
  }
}
