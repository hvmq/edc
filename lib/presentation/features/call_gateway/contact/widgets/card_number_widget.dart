import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resource/resource.dart';
import '../all.dart';

class CardNumberWidget extends StatefulWidget {
  final ContactController controller;
  const CardNumberWidget({required this.controller, super.key});

  @override
  State<CardNumberWidget> createState() => _CardNumberWidgetState();
}

class _CardNumberWidgetState extends State<CardNumberWidget> {
  int _currentIndex = 0;
  final List<String> _numbers = [
    '88888888888',
    '1000',
    '999999999',
    '1000',
    '999999999',
    '1000',
    '88888888888',
    '1000',
    '3333 3333 333',
  ];
  String _currentNumber = 'XXXX XXXX XXXX';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
      if (_currentIndex < _numbers.length) {
        setState(() {
          _currentNumber = _numbers[_currentIndex++];
        });
      } else {
        setState(() {
          _currentNumber =
              widget.controller.currentUser.phone ?? 'XXXX XXXX XXXX';
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.cardNumber.image(
          width: 1.sw,
        ),
        Positioned(
          left: 0.1.sw,
          bottom: 0.415.sw,
          width: 0.25.sw,
          child: Text(
            '@${widget.controller.currentUser.displayName}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Positioned(
          left: 0.28.sw,
          bottom: 0.34.sw,
          child: Text(
            _currentNumber,
            style: AppTextStyles.s18w600,
          ),
        ),
      ],
    );
  }
}

// class AnimatedSequenceNumbers extends StatefulWidget {
//   const AnimatedSequenceNumbers({super.key});

//   @override
//   _AnimatedSequenceNumbersState createState() =>
//       _AnimatedSequenceNumbersState();
// }

// class _AnimatedSequenceNumbersState extends State<AnimatedSequenceNumbers> {
//   


//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
//       if (_currentIndex < _numbers.length) {
//         setState(() {
//           _currentNumber = _numbers[_currentIndex++];
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(_currentNumber,
//         style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
//   }
// }
