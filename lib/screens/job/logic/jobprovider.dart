import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class JobProvider extends ChangeNotifier {
  bool isloading = false;
  String errortext = "";
  TextEditingController bidamount = TextEditingController();
  TextEditingController bidcomment = TextEditingController();

  bool iserror = false;

  resetform() {
    bidamount.clear();
    bidcomment.clear();
    notifyListeners();
  }

  Future<void> applybid({
    required String jobid,
    required BuildContext context,
  }) async {
    isloading = true;
    // resetform();
    notifyListeners();
    try {
      await AppRepository()
          .applyBid(
        jobId: jobid,
        description: bidcomment.text,
        amount: double.parse(bidamount.text),
        isApply: "1",
        accessToken: preferences!.getString("accesstoken") ?? "",
        driverId: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        MotionToast(
          icon: Icons.check_circle,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          primaryColor: Colors.green,
          description: Text(value["message"]),
        ).show(context);
        bidcomment.clear();
        bidamount.clear();
        Navigator.pop(context);

        notifyListeners();
      });
    } on Handle500Exception catch (e) {
      isloading = true;
      iserror = true;
      MotionToast(
        icon: Icons.error,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60.h,
        primaryColor: maincolor,
        description: Text(e.message["error"]),
      ).show(context);
      notifyListeners();
    } on TokenExpired {
      isloading = true;
      refreshtoken();
    } on Exception catch (e) {
      debugPrint(e.toString());
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
