import 'package:hotelapp/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
    Future<AppUser> loginUser(String email, String password);
    Future<AppUser> registerUser(String name, String email, String phone, String password);
    Future<AppUser?> verifyToken();
    Future<AppUser> forgotPassord(String email);
    Future<AppUser> verifyOtp(int otp);
    Future<AppUser> resetPassword(String newPassword);
}