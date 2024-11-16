import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = 200,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Image.network(
        imageUrl,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child; // Ảnh được tải xong, trả về widget ảnh
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null, // Hiển thị tiến độ tải
              ),
            );
          }
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Icon(
            Icons.error,
            color: Colors.red,
            size: 50,
          ); // Hiển thị biểu tượng lỗi nếu không tải được ảnh
        },
      ),
    );
  }
}
