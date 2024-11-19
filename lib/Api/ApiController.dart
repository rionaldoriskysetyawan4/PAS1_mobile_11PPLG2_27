import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/TeamModel.dart';
import 'ApiService.dart';

class Apicontroller extends GetxController {
  var isLoadingCharacters = true.obs;
  var isLoadingTeams = true.obs;
  var teamList = <TeamModel>[].obs;

  @override
  void onInit() {
    fetchTeams();
    super.onInit();
  }



  void fetchTeams() async {
    try {
      isLoadingTeams(true);
      var teams = await ApiService().fetchTeams();
      teamList.assignAll(teams);
      print('Teams loaded: ${teamList.length}');
    } catch (e) {
      print('Failed to fetch teams: $e');
    } finally {
      isLoadingTeams(false);
    }
  }

}