import 'package:flutter/material.dart';

import '../../../core/utils/color.dart';

class EvaluateDialog extends StatefulWidget {
  final int index;
  final void Function(int index, List<int> selectedRatings) onRatingSelected;

  const EvaluateDialog(
      {required this.index, required this.onRatingSelected, super.key});

  @override
  _EvaluateDialogState createState() => _EvaluateDialogState();
}

class _EvaluateDialogState extends State<EvaluateDialog> {
  // A list to store the selected ratings (as integers)
  List<int> selectedRatings = [];

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Evaluate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Rating options with Checkboxes
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Number of rating options (1-5 stars)
                itemBuilder: (context, index) {
                  final int starCount = 5 - index;
                  final String ratingLabel = '$starCount-star';
                  return CheckboxListTile(
                    activeColor: Colors.blue,
                    title: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            i < starCount ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          '$starCount - star',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    value: selectedRatings.contains(starCount),
                    onChanged: (bool? isChecked) {
                      setState(() {
                        final int starValue = int.parse(ratingLabel.substring(
                            0, 1)); // Extract and convert to int
                        if (isChecked == true) {
                          // Add the integer value to the selectedRatings list
                          selectedRatings.add(starValue);
                        } else {
                          // Remove the integer value if the checkbox is deselected
                          selectedRatings.remove(starValue);
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
            ),

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
                  // Save action here
                  Navigator.of(context).pop(selectedRatings);
                  widget.onRatingSelected(widget.index, selectedRatings);
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
