import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  String baseUrl = '${dotenv.env['BASE_URL']}user';

  Future<User> login(payload) async {
    try {
      User? user;
      final body = json.encode(payload);
      final uri = Uri.parse('$baseUrl/login');
      final response = await http.post(uri, headers: headers, body: body);

      final result = await json.decode(response.body);
      user = User.fromJson({...result['data']});
      return user;
    } catch (e) {
      throw Exception('cannot login $e');
    }
  }

  Future<List<User>> getSubordinate(userId) async {
    List<User> sub = [];
    try {
      final uri = Uri.parse('$baseUrl/get-subordinates');
      final body = json.encode({"userID": userId});

      final response = await http.post(uri, headers: headers, body: body);
      Map<String, dynamic> userData = await json.decode(response.body);
      List subData = userData['data']['subordinates'];

      subData.forEach((el) {
        sub.add(User.fromJson(el));
      });
      return sub;
    } catch (e) {
      throw Exception('cannot get subordinate $e');
    }
  }
}
