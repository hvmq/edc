import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/controllers/app_controller.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';

class EDCZoomController extends AppController {
  final PageController _pageController = PageController();
  Timer? _timer;
  final int _currentPage = 0;

  List<String> features = [
    'Online course',
    'Scholarship',
    'Learning diary',
    'Numerology',
    'Horoscopes',
    'Apply for job',
    'Blockchain library',
    'Study abroad',
    'Mining',
    'Personal orientation',
    'Teacher recruitment',
  ];
  final List<Map<String, String>> mentors = [
    {
      'name': 'Benny Balance',
      'image': ImageConstants.top_mentor,
      'rating': '4.5',
      'reviews': '100'
    },
    {
      'name': 'Anna Advice',
      'image': ImageConstants.top_mentor,
      'rating': '4.7',
      'reviews': '85'
    },
    {
      'name': 'Chris Coach',
      'image': ImageConstants.top_mentor,
      'rating': '4.8',
      'reviews': '120'
    },
  ];
}
