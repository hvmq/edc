import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color.dart';
import '../../features/account/account_controller.dart';

class AccountScreen extends GetView<AccountController> {
  final AccountController accountController;
  const AccountScreen(this.accountController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'hello'.tr,
          style: TextStyle(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
