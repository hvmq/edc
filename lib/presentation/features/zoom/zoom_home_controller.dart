import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/note.dart';

import '../../base/all.dart';
import 'zoom_home_view.dart';

class ZoomHomeController extends BaseController {
  RxList<MeetingHistoryItem> meetingHistoryListRx = <MeetingHistoryItem>[].obs;
  List<MeetingHistoryItem> get meetingHistoryList =>
      meetingHistoryListRx.toList();

  RxList<Note> meetingNoteListRx = <Note>[].obs;
  List<Note> get meetingNoteList => meetingNoteListRx.toList();

  RxString sharedLink = ''.obs;

  TextEditingController nameZoom = TextEditingController();

  RxBool disableButton = true.obs;
  RxBool isEnableCamera = true.obs;
  RxBool isEnableNoAudio = true.obs;

  RxString startTimeSchedule = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameZoom.text = currentUser.fullName;
    loadMeetingHistory();
    getSharedLink();
    loadNote();
    if (nameZoom.text.isEmpty) {
      setDisableButton(true);
    } else {
      setDisableButton(false);
    }
  }

  void setDisableButton(bool value) {
    disableButton.value = value;
  }

  Future<void> loadMeetingHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('meetingHistoryList');
    if (jsonString != null && jsonString != '') {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      final itemhistory = jsonList.map((jsonItem) {
        return MeetingHistoryItem.fromMap(
            Map<String, String>.from(jsonDecode(jsonItem)));
      }).toList();

      final itemCurrentHistory = itemhistory
          .where((element) => element.userId == currentUser.id.toString())
          .toList();
      meetingHistoryListRx.assignAll(itemCurrentHistory);
    }

    update();
  }

  Future<void> addMeetingHistoryItem(String idMeeting, String time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final item = MeetingHistoryItem(
        userId: currentUser.id.toString(), idMeeting: idMeeting, time: time);
    final itemCurrentHistory = meetingHistoryListRx.reversed.toList();
    itemCurrentHistory.add(item);
    meetingHistoryListRx.value = itemCurrentHistory.reversed.toList();
    final List<String> jsonList = meetingHistoryListRx.map((item) {
      return jsonEncode(item.toMap());
    }).toList();
    await prefs.setString('meetingHistoryList', jsonEncode(jsonList));
  }

  Future<void> loadNote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('notesZoom');
    if (jsonString != null && jsonString != '') {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      final itemNotes = jsonList.map((jsonItem) {
        return Note.fromMap(Map<String, dynamic>.from(jsonDecode(jsonItem)));
      }).toList();

      final itemCurrentHistory = itemNotes
          .where((element) => element.userId == currentUser.id)
          .toList();
      meetingNoteListRx.assignAll(itemCurrentHistory);
    }
    update();
  }

  Future<void> addNoteItem(String title, String? description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final item = Note(
        userId: currentUser.id, title: title, description: description ?? '');
    final itemCurrentNote = meetingNoteListRx.reversed.toList();
    itemCurrentNote.add(item);
    meetingNoteListRx.value = itemCurrentNote.reversed.toList();
    final List<String> jsonList = meetingNoteListRx.map((item) {
      return jsonEncode(item.toMap());
    }).toList();
    await prefs.setString('notesZoom', jsonEncode(jsonList));
  }

  Future<void> updateNoteItem(Note updatedNote) async {
    log(updatedNote.title);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int index = meetingNoteListRx
        .indexWhere((note) => note.userId == updatedNote.userId);
    log(index.toString());
    if (index != -1) {
      meetingNoteListRx[index] = updatedNote;
      final List<String> jsonList = meetingNoteListRx.map((item) {
        return jsonEncode(item.toMap());
      }).toList();
      await prefs.setString('notesZoom', jsonEncode(jsonList));
    }
    update();
  }

  Future<void> removeNoteItem(Note noteToRemove) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    meetingNoteListRx.removeWhere((note) =>
        note.userId == noteToRemove.userId && note.title == noteToRemove.title);
    final List<String> jsonList = meetingNoteListRx.map((item) {
      return jsonEncode(item.toMap());
    }).toList();
    await prefs.setString('notesZoom', jsonEncode(jsonList));
  }

  Future<void> getSharedLink() async {
    late String getsharedLink;
  }
}
