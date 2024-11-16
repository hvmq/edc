import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovingContainer extends StatefulWidget {
  const MovingContainer({super.key});

  @override
  _MovingContainerState createState() => _MovingContainerState();
}

class _MovingContainerState extends State<MovingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true); // Để đảo chiều khi hết container

    _animation = Tween<double>(begin: 0, end: 1.sw).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color(0xff2E44AA),
                    Color(0xffF2B96A),
                    Color(0xffD83668)
                  ])),
              margin: EdgeInsets.only(left: _animation.value),
              // color: _animation.value < 0.25.sw
              //     ? Colors.transparent
              //     : Colors.black,
            ),
            // AppBlurryContainer(
            //     padding: EdgeInsets.zero,
            //     margin: EdgeInsets.only(left: _animation.value),
            //     borderRadius: 0,
            //     color: Colors.white.withOpacity(0.1),
            //     child: const SizedBox(
            //       width: 200,
            //       height: 200,
            //     ))
          ],
        );
      },
    );
  }
}
