import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/jobdetail.dart';
import 'package:click_send/model/jobhistory.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class CalendarProvider extends ChangeNotifier {
  bool isloading = false;
  String errortext = "";
  bool iserror = false;
  JobHistory? jobHistory;

  JobDetail? jobDetail;
  Future<void> getjobhistory({
    required BuildContext context,
    required String latitude,
    required String longitude,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getJobList(
        latitude: latitude,
        longitude: longitude,
        status: "history",
        type: preferences!.getString("usertype") ?? "",
        accessToken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        jobHistory = JobHistory.fromJson((value));

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

  Future<void> getjobdetail({
    required BuildContext context,
    required String jobid,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getJobDetails(
        jobId: jobid,
        accessToken: preferences!.getString("accesstoken") ?? "",
        // userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        jobDetail = JobDetail.fromJson((value));

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

  Future<void> getjobsByDate({
    required BuildContext context,
    required String date,
  }) async {
    jobHistory = null;

    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getJobListByDate(
        status: "pending",
        type: preferences!.getString("usertype") ?? "",
        date: date,
        accessToken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        jobHistory = JobHistory.fromJson((value));

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
