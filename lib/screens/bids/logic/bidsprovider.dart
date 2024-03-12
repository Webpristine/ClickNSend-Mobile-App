import 'dart:developer';

import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BidsProvider extends ChangeNotifier {
  bool isloading = false;
  bool iserror = false;
  String errortext = "";

  Future<void> getbidsStatic({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .driverbidstatic(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        log(value.toString());
        isloading = false;
        //reset();
        notifyListeners();
        // notifyListeners();

        return MotionToast(
          icon: Icons.error,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          onClose: () {
            Navigator.pop(context);
          },
          primaryColor: maincolor,
          description: Text(value["message"]),
        ).show(context);
      });
    } on TokenExpired {
      isloading = true;
    } on NotFoundException catch (e) {
      log(e.toString());
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
    }
  }
}
