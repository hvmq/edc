import 'package:flutter/material.dart';

const double _kPreviewSwipeToReplySensitive = 30.0;
const double _kAdjustSwipeValue = 4;

class PreviewSwipeToReply extends StatefulWidget {
  const PreviewSwipeToReply({
    required this.child,
    required this.onReply,
    required this.isMyMessage,
    super.key,
  });

  final Widget child;
  final VoidCallback? onReply;
  final bool isMyMessage;

  @override
  State<PreviewSwipeToReply> createState() => _PreviewSwipeToReplyState();
}

class _PreviewSwipeToReplyState extends State<PreviewSwipeToReply>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _dragPositionNotifier =
      ValueNotifier<double>(0.0);

  double _dragStartPoint = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragDown: (detail) {
        _dragStartPoint = detail.globalPosition.dx;
      },
      onHorizontalDragUpdate: (detail) {
        if (detail.delta.dx > 0) {
          return;
        }

        double update = detail.globalPosition.dx - _dragStartPoint;
        // make update value physical
        update = update / _kAdjustSwipeValue;

        // if (!widget.isMyMessage && update > 0) {
        //   _dragPositionNotifier.value = update;
        // } else if (widget.isMyMessage && update < 0) {
        //   _dragPositionNotifier.value = update;
        // }

        _dragPositionNotifier.value = update;
      },
      onHorizontalDragEnd: (detail) {
        if (_dragPositionNotifier.value.abs() >
            _kPreviewSwipeToReplySensitive) {
          widget.onReply?.call();
          _dragPositionNotifier.value = 0.0;
        }
        _dragPositionNotifier.value = 0.0;
      },
      child: ValueListenableBuilder(
        valueListenable: _dragPositionNotifier,
        builder: (_, double value, __) {
          return Align(
            alignment: widget.isMyMessage
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Transform.translate(
              offset: Offset(value, 0.0),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }

  // Widget _buildPreviewSwipeToReplyIcon(double value) {
  //   if (value == 0.0 || value.abs() < _kPreviewSwipeToReplySensitive) {
  //     return AppSpacing.emptyBox;
  //   }

  //   return Align(
  //     alignment: value > 0 ? Alignment.centerLeft : Alignment.centerRight,
  //     child: Container(
  //       padding: AppSpacing.edgeInsetsAll8,
  //       child: const Icon(Icons.reply),
  //     ),
  //   );
  // }
}
