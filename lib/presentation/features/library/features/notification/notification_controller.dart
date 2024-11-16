import 'package:get/get.dart';

import '../../core/controllers/app_controller.dart';

class NotificationController extends AppController {
  // Define the notifications with the correct type
  var newestNotifications = <Map<String, String>>[].obs;
  var previousNotifications = <Map<String, String>>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Load initial data (you can replace this with actual API call or logic)
    loadNotifications();
  }

  void loadNotifications() {
    // Example data for newest notifications
    newestNotifications.value = [
      {
        'image': 'https://picsum.photos/200',
        'text': 'You have just completed the course Mentoring and Coaching 1:1',
        'time': '15 minutes ago',
      },
      {
        'image': 'https://picsum.photos/200',
        'text': 'You have just completed the course Multilingual Teacher',
        'time': '15 minutes ago',
      }
    ];

    // Example data for previous notifications
    previousNotifications.value = [
      {
        'image': 'https://picsum.photos/200',
        'text': 'Course on Advanced Flutter has been assigned',
        'time': '2 hours ago',
      },
    ];
  }
}
