import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/subscriptionplan.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool isloading = false;
  bool iserror = false;
  String errortext = "";

  SubScriptionPlan? subScriptionPlan;

  Future<void> getsubscriptions({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .fetchdriverplan(
        usertype: preferences!.getString("usertype") ?? "",
        accesstoken: preferences!.getString("accesstoken") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        subScriptionPlan = SubScriptionPlan.fromJson((value));

        notifyListeners();
      });
    } on TokenExpired {
      isloading = true;
      refreshtoken();
    } on Exception catch (e) {
      logger.i(e.toString());
      isloading = false;
      iserror = true;
      // ignore: use_build_context_synchronously
      MotionToast(
        icon: Icons.error,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60.h,
        primaryColor: maincolor,
        description: const Text("Invalid User"),
      ).show(context);
      notifyListeners();
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }
}
