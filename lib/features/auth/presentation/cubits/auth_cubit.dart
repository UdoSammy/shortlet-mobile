import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelapp/features/auth/domain/entities/app_user.dart';
import 'package:hotelapp/features/auth/domain/repos/auth_repo.dart';
import 'package:hotelapp/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) :super(AuthInitial());

   // check if user is already authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.verifyToken();

    if(user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    }else {
      emit(Unauthenticated());
    }
  }

  // get cureent user
  AppUser? get currentUser => _currentUser;

  // login
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginUser(email, password);

      if(user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      }else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // register
  Future<void> register(String name, String email, String phone, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerUser(name, email, phone, password);

      if(user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      }else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

}