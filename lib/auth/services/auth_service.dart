import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService extends ChangeNotifier{
  final _storage = const FlutterSecureStorage();
  String? _token;
  String? get token => _token;
  bool get isAuthenticated => _token != null;

  //Replace with your backend endpoints using this: Backend in Docker on host (Android emulator or device)
  // final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  Future<void> loadToken() async{
    _token = await _storage.read(key: 'auth_token');
    notifyListeners();
  }

  Future<bool> login(String email, String password) async{
    final resp = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (resp.statusCode == 200){
      final data = jsonDecode(resp.body);
      _token = data['token'] as String?;
      if (_token != null){
        await _storage.write(key: 'auth_token', value: _token);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> register(String name, String email, String password, String confirmPassword) async{
    if (password != confirmPassword){
      return false; // or throw and error
    }
    final resp = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email' : email, 'password': password}),
    );

    print("Register response: ${resp.statusCode}");
    print("Register body: ${resp.body}");

    return resp.statusCode == 201;
  }

  Future<void> logout() async {
    _token = null;
    await _storage.delete(key: 'auth_token');
    notifyListeners();
  }
}