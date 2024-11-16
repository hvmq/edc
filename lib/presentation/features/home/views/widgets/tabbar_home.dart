import 'package:flutter/material.dart';

import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import 'tabbar_all_home.dart';

class TabBarHome extends StatefulWidget {
  const TabBarHome({super.key});

  @override
  State<TabBarHome> createState() => _TabBarHomeState();
}

class _TabBarHomeState extends State<TabBarHome>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() {
      setState(() {});
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
    return Column(
      children: [
        TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: tabController,
            unselectedLabelColor: AppColors.subText3,
            labelColor: AppColors.button5,
            labelStyle: AppTextStyles.s14w500,
            indicatorColor: AppColors.subText3,
            indicatorWeight: 0.5,
            dividerColor: AppColors.background6,
            tabs: [
              const Tab(
                text: 'All',
              ),
              Tab(
                child: Row(
                  children: [
                    AppIcon(
                      icon: AppIcons.book,
                      size: 20,
                      color: tabController.index == 1
                          ? AppColors.button5
                          : AppColors.subText3,
                    ),
                    AppSpacing.gapW4,
                    const Text('Course for beginners'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    AppIcon(
                      icon: AppIcons.blockchain,
                      size: 20,
                      color: tabController.index == 2
                          ? AppColors.button5
                          : AppColors.subText3,
                    ),
                    AppSpacing.gapW4,
                    const Text(
                      'Blockchain',
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    AppIcon(
                      icon: AppIcons.business,
                      size: 20,
                      color: tabController.index == 3
                          ? AppColors.button5
                          : AppColors.subText3,
                    ),
                    AppSpacing.gapW4,
                    const Text(
                      'Business',
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    AppIcon(
                      icon: AppIcons.language,
                      size: 20,
                      color: tabController.index == 4
                          ? AppColors.button5
                          : AppColors.subText3,
                    ),
                    AppSpacing.gapW4,
                    const Text('Language'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    AppIcon(
                      icon: AppIcons.work,
                      size: 20,
                      color: tabController.index == 5
                          ? AppColors.button5
                          : AppColors.subText3,
                    ),
                    AppSpacing.gapW4,
                    const Text('Job opportunities'),
                  ],
                ),
              )
            ]),
        Expanded(
          child: TabBarView(controller: tabController, children: [
            const TabbarAllHome(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container()
          ]),
        )
      ],
    );
  }
}
