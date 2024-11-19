import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Model/TeamModel.dart';


class ApiService {
  final String secondUrl = 'https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?l=English%20Premier%20League';
  final String postUrl = 'https://mediadwi.com/api/latihan/login';


  Future<List<TeamModel>> fetchTeams() async {
    try {
      final response = await http.get(Uri.parse(secondUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData.containsKey('teams') && jsonData['teams'] is List) {
          List<dynamic> teamsData = jsonData['teams'];

          List<TeamModel> teams = teamsData.map((e) =>
              TeamModel.fromJson(e as Map<String, dynamic>)
          ).toList();

          return teams;
        } else {
          throw Exception('Invalid JSON structure: Missing or invalid "teams" key');
        }
      } else {
        throw Exception('Failed to load teams with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load teams: $e');
    }
  }


  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(postUrl),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to login");
    }
  }
}
