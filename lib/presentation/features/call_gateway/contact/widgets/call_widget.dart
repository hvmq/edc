import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../home/controllers/home_controller.dart';
import '../../call_history/histories_widget.dart';
import '../all.dart';
import 'contacts_widget.dart';

class CallPage extends BaseView<ContactController> {
  const CallPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              buildAppBar(context),
              Container(
                  decoration: BoxDecoration(color: AppColors.divider),
                  height: 1),
              // buildTabBar(context),
              // buildBody(),
              const Expanded(
                child: ContactsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) => Padding(
        padding: AppSpacing.edgeInsetsAll20,
        child: Row(
          children: [
            AppIcon(
              icon: AppIcons.arrowLeft,
              color: AppColors.text1,
            ).clickable(() {
              Navigator.pop(context);
            }),
            AppSpacing.gapW8,
            Text(l10n.call__contact, style: AppTextStyles.s16w600),
            const Spacer(),
            AppIcon(
              icon: Assets.icons.add,
              color: AppColors.text1,
              size: 16,
              onTap: () {
                showBottomSheetAddContacts(context);
              },
            ),
          ],
        ),
      );

  Widget buildTabBar(BuildContext context) => Container(
        margin: AppSpacing.edgeInsetsH40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border2),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.background13,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(5),
        child: TabBar(
          onTap: (value) {
            controller.tabController.index = value;
          },
          controller: controller.tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.button5,
          ),
          unselectedLabelColor: AppColors.border2,
          labelColor: Colors.white,
          tabs: [
            Tab(text: context.l10n.call__numpad),
            Tab(text: context.l10n.call__contact),
            Tab(text: context.l10n.call__history),
          ],
        ),
      );

  Widget buildBody() => Expanded(
        child: NotificationListener<OverscrollNotification>(
          onNotification: (OverscrollNotification notification) {
            final homeController = Get.find<HomeController>();
            // Kiểm tra điều kiện kéo sang phải
            if (notification.overscroll < 0 &&
                controller.tabController.index == 0) {
              homeController.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            // Kiểm tra điều kiện kéo sang trái
            else if (notification.overscroll > 0 &&
                controller.tabController.index == 2) {
              homeController.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            return false;
          },
          child: TabBarView(
            controller: controller.tabController,
            children: const <Widget>[
              ContactsWidget(),
              HistoriesWidget(),
            ],
          ),
        ),
      );

  void showBottomSheetAddContacts(BuildContext context) => Get.toNamed(
        Routes.addContactNumber,
        arguments: {
          'user': null,
          'isAddContact': true, // or false, depending on your logic
        },
      );
}
