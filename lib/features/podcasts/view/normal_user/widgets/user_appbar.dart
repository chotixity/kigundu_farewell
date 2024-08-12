import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:podcasts/features/auth/provider/auth_provider.dart';

class UserAppbar extends StatefulWidget implements PreferredSizeWidget {
  const UserAppbar({super.key});

  @override
  State<UserAppbar> createState() => _UserAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UserAppbarState extends State<UserAppbar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return AppBar(
      title: Text(authProvider.userData['displayName']!),
    );
  }
}
