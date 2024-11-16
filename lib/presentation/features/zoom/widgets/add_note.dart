import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/all.dart';
import '../../../../models/note.dart';
import '../../../resource/resource.dart';
import '../zoom_home_controller.dart';

class AddTaskClassic extends StatefulWidget {
  final String type;
  final Note? note;
  const AddTaskClassic({required this.type, this.note, super.key});

  @override
  State<AddTaskClassic> createState() => _AddTaskClassicState();
}

int selectColor = 0;

class _AddTaskClassicState extends State<AddTaskClassic> {
  int selectColor = 0;

  DateTime currentDateTime = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController timeEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();
  TextEditingController describeEditingController = TextEditingController();

  @override
  void initState() {
    dateEditingController.text =
        DateFormat('dd/MM/yyyy').format(currentDateTime);
    if (widget.type == 'edit') {
      titleEditingController.text = widget.note!.title;
      describeEditingController.text = widget.note!.description ?? '';
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      locale: const Locale('vi', 'VN'),
    );
    if (selectedDate != null && selectedDate != currentDateTime) {
      setState(() {
        currentDateTime = selectedDate;
      });
      dateEditingController.text =
          DateFormat('dd/MM/yyyy').format(currentDateTime);
    }
  }

  Future<void> _showTimePicker() async {
    final selectedTime =
        await showTimePicker(context: context, initialTime: currentTime);
    if (selectedTime != null && selectedTime != currentTime) {
      setState(() {
        currentTime = selectedTime;
      });
      timeEditingController.text = '${currentTime.hour}:${currentTime.minute}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        height: 0.55.sh,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D0140),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                          widget.type == 'add'
                              ? context.l10n.zoom__add_note
                              : context.l10n.zoom__update_note,
                          style: AppTextStyles.s20w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(context.l10n.zoom__title,
                          style: AppTextStyles.s16Base),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(
                            color: const Color(0xFFDEE3F2),
                          )),
                      child: TextFormField(
                        controller: titleEditingController,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'TodoAi-Book'),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          hintText: context.l10n.zoom__enter_title_note,
                          hintStyle: const TextStyle(
                              fontSize: 16, fontFamily: 'TodoAi-Book'),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                        maxLines: null,
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                      ),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 10, bottom: 5),
                    //   child: Text(
                    //     'Color',
                    //     style: TextStyle(
                    //         fontSize: 16, fontFamily: 'TodoAi-Medium'),
                    //   ),
                    // ),
                    // Stack(children: [
                    //   Container(
                    //     height: 40,
                    //     width: 230,
                    //     decoration: BoxDecoration(
                    //       color: const Color.fromARGB(255, 228, 228, 228),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   Positioned(
                    //     left: 10,
                    //     top: 3,
                    //     child: Wrap(
                    //       children: List<Widget>.generate(7, (int index) {
                    //         return GestureDetector(
                    //           onTap: () {
                    //             setState(() {
                    //               selectColor = index;
                    //             });
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                    //             child: CircleAvatar(
                    //               radius: 10,
                    //               backgroundColor: index == 0
                    //                   ? Colors.red
                    //                   : index == 1
                    //                       ? Colors.yellow
                    //                       : index == 2
                    //                           ? Colors.green
                    //                           : index == 3
                    //                               ? Colors.blue
                    //                               : index == 4
                    //                                   ? Colors.pinkAccent
                    //                                   : index == 5
                    //                                       ? Colors.deepPurple
                    //                                       : Colors.black,
                    //               child: selectColor == index
                    //                   ? const Icon(
                    //                       Icons.done,
                    //                       color: Colors.white,
                    //                       size: 12,
                    //                     )
                    //                   : const SizedBox(),
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    //     ),
                    //   ),
                    // ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        context.l10n.zoom__description,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'TodoAi-Medium'),
                      ),
                    ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(
                            color: const Color(0xFFDEE3F2),
                          )),
                      child: TextFormField(
                        controller: describeEditingController,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'TodoAi-Book'),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: context.l10n.zoom__enter_description_note,
                          hintStyle: const TextStyle(
                              fontSize: 16, fontFamily: 'TodoAi-Book'),
                        ),
                        maxLines: null,
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                      ),
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    if (widget.type == 'add') ...[
                      GestureDetector(
                        onTap: () {
                          Get.find<ZoomHomeController>().addNoteItem(
                              titleEditingController.text,
                              describeEditingController.text);
                          Get.back();
                        },
                        child: SizedBox(
                          child: Container(
                              width: 0.9.sw - 40,
                              padding: AppSpacing.edgeInsetsAll16,
                              decoration: BoxDecoration(
                                  color: AppColors.button5,
                                  borderRadius:
                                      BorderRadius.circular(Sizes.s128)),
                              child: Text(
                                context.l10n.zoom__done,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.s18w600.text2Color,
                              )),
                        ),
                      )
                    ] else ...[
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.find<ZoomHomeController>()
                                    .removeNoteItem(widget.note!);
                                Get.back();
                                Get.back();
                              },
                              child: SizedBox(
                                child: Container(
                                    width: 0.9.sw - 40,
                                    padding: AppSpacing.edgeInsetsAll16,
                                    decoration: BoxDecoration(
                                        color: AppColors.negative,
                                        borderRadius:
                                            BorderRadius.circular(Sizes.s128)),
                                    child: Text(
                                      context.l10n.zoom__remove,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.s18w600.text2Color,
                                    )),
                              ),
                            ),
                          ),
                          AppSpacing.gapW20,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.find<ZoomHomeController>().updateNoteItem(
                                    Note(
                                        userId: widget.note!.userId,
                                        title: titleEditingController.text,
                                        description:
                                            describeEditingController.text));
                                Get.back();
                                Get.back();
                              },
                              child: SizedBox(
                                child: Container(
                                    width: 0.9.sw - 40,
                                    padding: AppSpacing.edgeInsetsAll16,
                                    decoration: BoxDecoration(
                                        color: AppColors.button5,
                                        borderRadius:
                                            BorderRadius.circular(Sizes.s128)),
                                    child: Text(
                                      context.l10n.zoom__update,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.s18w600.text2Color,
                                    )),
                              ),
                            ),
                          )
                        ],
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
