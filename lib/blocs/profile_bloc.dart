import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/blocs/states/profile_state.dart';
import '../repositories/profile_repository.dart';
import 'events/profile_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUserDetails>((event, emit) async {
      try {
        emit(UserLoading());
        final userDetails = await userRepository.fetchUserDetails();
        emit(UserLoaded(userDetails));
      } catch (e) {
        emit(UserError("Failed to load user details: $e"));
      }
    });
  }
}
