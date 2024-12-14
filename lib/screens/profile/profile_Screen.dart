import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/events/profile_event.dart';
import '../../blocs/profile_bloc.dart';
import '../../blocs/states/profile_state.dart';
import '../../repositories/profile_repository.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(userRepository: UserRepository())
        ..add(FetchUserDetails()),
      child: Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;
              return ListView(
                children: [
                  ListTile(
                    title: Text('Name: ${user['name']}'),
                  ),
                  ListTile(
                    title: Text('Email: ${user['email']}'),
                  ),
                  ListTile(
                    title: Text('Phone: ${user['phone']}'),
                  ),
                ],
              );
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No user data found.'));
            }
          },
        ),
      ),
    );
  }
}
