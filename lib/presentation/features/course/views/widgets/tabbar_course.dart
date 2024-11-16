import 'package:flutter/material.dart';

import '../../../../resource/resource.dart';
import '../../certificate/certificate_view.dart';
import '../../document/course_document_view.dart';
import '../../history/course_history_view.dart';
import 'course_home.dart';

class TabBarCourse extends StatefulWidget {
  const TabBarCourse({super.key});

  @override
  State<TabBarCourse> createState() => _TabBarCourseState();
}

class _TabBarCourseState extends State<TabBarCourse>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int currentIndex = 0;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBarWidget() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: TabBar(
            controller: tabController,
            isScrollable: true,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.button5,
            ),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: AppColors.border2,
            labelColor: Colors.white,
            tabs: const [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text('Courses'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text('Certificates'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text('History'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text('Document'),
                ),
              ),
            ]),
      );
    }

    return Column(
      children: [
        tabBarWidget(),
        Expanded(
          child: TabBarView(controller: tabController, children: const [
            CourseHome(),
            CertificateView(),
            CourseHistoryView(),
            CourseDocumentView(),
          ]),
        )
      ],
    );
  }
}
