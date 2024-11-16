import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/utils/color.dart';
import '../../../features/search/search_controller.dart';

class FilterDialog extends GetView<MySearchController> {
  final List<String> options; // Options list
  final bool isSingleSelection; // Single selection flag
  final RxList<String> selectedOptions; // RxList for reactive selected options
  final String title; // Title of the dialog
  final int index;
  final void Function(int index, RxList<String> selectedOptions)?
      onMultipleOptionsSelected;

//add function to get the selected options
  const FilterDialog(
    this.onMultipleOptionsSelected, {
    required this.index,
    required this.title,
    required this.options,
    required this.selectedOptions,
    super.key,
    this.isSingleSelection = false,
  });

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
                    child: const Icon(Icons.close, color: Colors.black),
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
                  title, // Use the dynamic title here
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Rating options
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, optionIndex) {
                  if (isSingleSelection) {
                    // Use RadioListTile for single selection
                    return Obx(() => RadioListTile<String>(
                          title: Text(
                            options[optionIndex],
                            style: TextStyle(
                                color: AppColor.textColor, fontSize: 14),
                          ),
                          value: options[optionIndex],
                          groupValue: selectedOptions.value.isNotEmpty
                              ? selectedOptions.value[0]
                              : null,
                          onChanged: (String? value) {
                            // Update selected options as RxList
                            selectedOptions.clear();
                            selectedOptions.add(value!);
                          },
                          activeColor: AppColor.blueColor_3,
                        ));
                  } else {
                    return Obx(() => CheckboxListTile(
                          title: Text(
                            options[optionIndex],
                            style: TextStyle(
                                color: AppColor.textColor, fontSize: 14),
                          ),
                          value: selectedOptions.value
                              .contains(options[optionIndex]),
                          onChanged: (bool? value) {
                            if (value == true) {
                              selectedOptions.add(options[optionIndex]);
                            } else {
                              selectedOptions.remove(options[optionIndex]);
                            }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: AppColor.blueColor_3,
                        ));
                  }
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
                  Navigator.of(context).pop(selectedOptions.value);
                  onMultipleOptionsSelected!(index, selectedOptions);
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
