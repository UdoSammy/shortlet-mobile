import 'dart:convert';

import 'package:hotelapp/features/auth/domain/entities/app_user.dart';
import 'package:hotelapp/features/auth/domain/repos/auth_repo.dart';
import 'package:hotelapp/helpers/store_token.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ExpressAuthRepo implements AuthRepo {
  @override
  Future<AppUser> loginUser(String email, String password) async {
    try {
      // calling the api
      final response = await http.post(
        Uri.parse('localhost:3000/api/v1/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = AppUser.fromJson(jsonDecode(response.body));
        return data;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AppUser> registerUser(
      String name, String email, String phone, String password) async {
    try {
      // calling the api
      final response = await http.post(
        Uri.parse('localhost:3000/api/v1/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone
        }),
      );

      if (response.statusCode == 200) {
        final data = AppUser.fromJson(jsonDecode(response.body));
        return data;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AppUser?> verifyToken() async {
    final storeTone = StoreToken();
    const String baseUrl = 'localhost:3000/api/v1/verify-token';

    final tokens = await storeTone.getToken();
    final accessToken = tokens['accessToken'];

    if (accessToken == null || JwtDecoder.isExpired(accessToken)) {
      return null; // Token is invalid or expired
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/verifyToken'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['user']; // Return user data
        } else {
          return null; // Token invalid or user not found
        }
      } else {
        throw Exception('No logedIn user');
      }
    } catch (e) {
      throw Exception('No logedIn user $e');
    }
  }

  @override
  Future<AppUser> forgotPassord(String email) {
    // TODO: implement forgotPassord
    throw UnimplementedError();
  }

  @override
  Future<AppUser> verifyOtp(int otp) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<AppUser> resetPassword(String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
