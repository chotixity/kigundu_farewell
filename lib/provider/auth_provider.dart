import 'dart:async';

import 'package:flutter/material.dart';
import 'package:podcasts/services/auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthProvider with ChangeNotifier {
  final Auth _auth = Auth();
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void SignUp(String email, String password) {
    _auth.signUpWithEmailAndPassword(email, password);
    _controller.add(AuthenticationStatus.authenticated);
  }
}
