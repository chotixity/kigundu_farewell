import 'dart:async';

import 'package:flutter/material.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthProvider with ChangeNotifier {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void logIn() {}
}
