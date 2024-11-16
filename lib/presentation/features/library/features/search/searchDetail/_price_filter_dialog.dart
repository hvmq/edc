import 'package:flutter/material.dart';

import '../../../core/utils/color.dart';

class PriceFilterDialog extends StatefulWidget {
  final void Function(double fromPrice, double toPrice) onPriceSelected;
  final String title;
  final int rangeMin;
  final int rangeMax;
  final String unit;

  const PriceFilterDialog(
      {required this.onPriceSelected,
      required int index,
      required this.title,
      required this.rangeMin,
      required this.rangeMax,
      required this.unit,
      super.key});

  @override
  _PriceFilterDialogState createState() => _PriceFilterDialogState();
}

class _PriceFilterDialogState extends State<PriceFilterDialog> {
  double toPrice = 0;
  double fromPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // RangeSlider for Price selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${fromPrice.toStringAsFixed(0)} ${widget.unit} - ${toPrice.toStringAsFixed(0)} ${widget.unit}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  RangeSlider(
                    values: RangeValues(
                        fromPrice < widget.rangeMin.toDouble()
                            ? widget.rangeMin.toDouble()
                            : fromPrice,
                        toPrice < widget.rangeMin.toDouble()
                            ? widget.rangeMin.toDouble()
                            : toPrice),
                    min: widget.rangeMin.toDouble(),
                    max: widget.rangeMax
                        .toDouble(), // Adjust the maximum value according to your requirement
                    divisions: 100,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    labels: RangeLabels(
                      '${fromPrice.toStringAsFixed(0)} ${widget.unit}',
                      '${toPrice.toStringAsFixed(0)} ${widget.unit}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        fromPrice = values.start;
                        toPrice = values.end;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Save Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blue, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Return the selected price range when save is pressed
                  Navigator.of(context).pop();
                  widget.onPriceSelected(fromPrice, toPrice);
                },
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
