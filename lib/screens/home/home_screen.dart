import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dahboard_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({required this.user});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkUserExists(String email) async {
    final DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child('users');

    final snapshot = await usersRef.orderByChild('email').equalTo(email).get();
    print("there is no email found!!!");
    return snapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home - Welcome ${user.displayName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have signed out')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL ?? ''),
            ),
            const SizedBox(height: 20),
            Text('Welcome ${user.displayName}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print("the user email is ${user.email}");
                final emailExists = await checkUserExists(user.email ?? '');

                if (emailExists) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('User not found in the database')),
                  );
                }
              },
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
