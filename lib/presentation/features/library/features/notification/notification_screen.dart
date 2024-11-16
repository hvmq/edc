import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/notification/notification_controller.dart';

// Define your AppColor class if not already defined
class AppColor {
  static const primaryColor = Color(0xFF0F172A); // Example primary color
  static const secondColor = Color(0xFF1E293B); // Example secondary color
  static const greenColor =
      Color(0xFF22C55E); // Example green color for the border
}

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor, // Use primary color
        title:
            const Text('Notification', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.primaryColor, // Background for the entire screen

          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Newest Section
              _buildSectionTitle('Newest'),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.newestNotifications.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notifications',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling for ListView inside ScrollView
                  shrinkWrap: true,
                  itemCount: controller.newestNotifications.length,
                  itemBuilder: (context, index) {
                    final item = controller.newestNotifications[index];
                    return NotificationItem(
                      imageUrl: item['image']!,
                      text: item['text']!,
                      time: item['time']!,
                    );
                  },
                );
              }),
              const SizedBox(height: 20),

              // Before Section
              _buildSectionTitle('Before'),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.previousNotifications.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notifications',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.previousNotifications.length,
                  itemBuilder: (context, index) {
                    final item = controller.previousNotifications[index];
                    return NotificationItem(
                      imageUrl: item['image']!,
                      text: item['text']!,
                      time: item['time']!,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      backgroundColor: AppColor.primaryColor,
    );
  }

  // Helper widget for section titles with green border and secondary background
  Widget _buildSectionTitle(String title) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.secondColor, // Background color for the section
        border: Border(
          left: BorderSide(
            color: AppColor.greenColor, // Green left border
            width: 4.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String time;

  const NotificationItem({
    required this.imageUrl,
    required this.text,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Handle more actions
            },
          ),
        ],
      ),
    );
  }
}
