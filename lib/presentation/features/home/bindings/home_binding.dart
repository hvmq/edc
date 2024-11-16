import 'package:get/get.dart';

import '../../all.dart';
import '../../call_gateway/call_history/call_history_controller.dart';
import '../../call_gateway/contact/contact_controller.dart';
import '../../course/certificate/certificate_controller.dart';
import '../../course/controllers/course_controller.dart';
import '../../course/document/course_document_controller.dart';
import '../../course/history/course_history_controller.dart';
import '../../course/lesson/document_detail/document_detail_controller.dart';
import '../../course/lesson/education_program/education_program_controller.dart';
import '../../course/lesson/homework/homework_controller.dart';
import '../../course/lesson/lesson_homework/lesson_homework_controller.dart';
import '../../library/features/main/main_controller.dart';
import '../../newsfeed/personal_page/personal_page_controller.dart';
import '../../zoom/zoom_home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut(() => ChatDashboardController());

    Get.lazyPut<ContactController>(() => ContactController());

    Get.put<CallHistoryController>(CallHistoryController());

    Get.lazyPut<PersonalPageController>(
      () => PersonalPageController(),
      fenix: true,
    );
    Get.lazyPut(() => ChatHubController(), fenix: true);
    Get.lazyPut(() => ZoomHomeController(), fenix: true);
    Get.lazyPut<CourseController>(() => CourseController(), fenix: true);
    Get.put<MainController>(MainController());
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
    Get.lazyPut<CertificateController>(() => CertificateController(),
        fenix: true);
    Get.lazyPut<CourseHistoryController>(() => CourseHistoryController(),
        fenix: true);
    Get.lazyPut<CourseDocumentController>(() => CourseDocumentController(),
        fenix: true);

    Get.lazyPut<DocumentDetailController>(() => DocumentDetailController(),
        fenix: true);
    Get.lazyPut<EducationProgramController>(() => EducationProgramController(),
        fenix: true);
    Get.lazyPut<HomeworkController>(() => HomeworkController(), fenix: true);
    Get.lazyPut<LessonHomeworkController>(() => LessonHomeworkController(),
        fenix: true);
  }
}
