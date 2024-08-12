import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:podcasts/services/auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthProvider with ChangeNotifier {
  final Auth _auth = Auth();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _controller = StreamController<AuthenticationStatus>();

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        _controller.add(AuthenticationStatus.unauthenticated);
      } else {
        _controller.add(AuthenticationStatus.authenticated);
      }
    });
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(
        Duration.zero); // Needed to ensure the stream starts correctly.
    yield* _controller.stream;
  }

  Future<void> signInWithGoogle() async {
    try {
      await _auth.signInWithGoogle();
      _controller.add(AuthenticationStatus.authenticated);
      notifyListeners();
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      notifyListeners();
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      return {
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'uid': user.uid,
      };
    } else {
      throw Exception('No user signed in');
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
