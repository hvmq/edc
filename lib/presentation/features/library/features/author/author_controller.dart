import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../home/home.dart';
import '../../api/contanst.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/utils/show_noti.dart';

class DetailAuthorController extends AppController {
  var authorData = {}.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    final int idAuthor = Get.arguments['idAuthor'];
    await fetchAuthorDetails(idAuthor: idAuthor);
  }

  Future<void> fetchAuthorDetails({required int idAuthor}) async {
    final String url = '$baseUrl/app/authors/$idAuthor?limit=100';
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Adding the token in the Authorization header
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes))['data'];
        authorData.value = data; // Assign the parsed data to the observable
      } else {
        showError('Failed to fetch author details');
      }
    } catch (e) {
      showError('Failed to fetch author details: $e');
    }
  }

  String? calculateBookAge(int ageAverage) {
    if (ageAverage <= 0) {
      return null;
    } else {
      return '$ageAverage';
    }
  }
}
