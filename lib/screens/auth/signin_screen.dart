import 'package:flutter/material.dart';
import 'auth_service.dart';

class SignInScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign in with Google")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final user = await _authService.signInWithGoogle();
            if (user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Signed in as ${user.displayName}")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to sign in")),
              );
            }
          },
          child: const Text("Sign in with Google"),
        ),
      ),
    );
  }
}
