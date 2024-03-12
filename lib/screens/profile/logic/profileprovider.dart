import 'dart:io';

import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/userdata.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:click_send/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/app_colors.dart';

class ProfileProvider extends ChangeNotifier {
  bool isloading = false;
  User? user;
  String errortext = "";
  File? profileimage;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController plancontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  TextEditingController cPassword = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  bool iserror = false;
  void changeselectedImage({required BuildContext context}) {
    pickFile(context: context).then(
      (value) {
        profileimage = File(value!.path);
        updateprofileimage(context: context);
        notifyListeners();
      },
    );
    // .then((value) {
    //   selectedimage = value;
    //   notifyListeners();
    // });
  }

  Future<void> getuserprofile({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getprofile(accesstoken: preferences!.getString("accesstoken") ?? "")
          .then((value) {
        print(value);

        isloading = false;
        user = User.fromJson((value));

        emailcontroller.text = user!.viewData!.email!;
        mobileController.text = user!.viewData!.mobile!;
        nameController.text = user!.viewData!.profile!.userName!;
        plancontroller.text = user!.viewData!.planName!;
        notifyListeners();
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      isloading = false;
      iserror = true;
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

  Future<void> douserlogout({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .userlogout(
        accesstoken: preferences!.getString("accesstoken") ?? "",
      )
          .then((value) {
        isloading = false;
        dologout(context: context);

        notifyListeners();
        // notifyListeners();

        // return MotionToast(
        //   icon: Icons.error,
        //   padding: const EdgeInsets.all(10),
        //   width: double.infinity,
        //   height: 60.h,
        //   onClose: () {
        //     Navigator.pop(context);
        //   },
        //   primaryColor: maincolor,
        //   description: Text(value["message"]),
        // ).show(context);
      });
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
    }
  }

  Future<void> changepassword({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .updatepassword(
        password: password.text,
        accesstoken: preferences!.getString("accesstoken") ?? "",
      )
          .then((value) {
        isloading = false;
        cPassword.clear();
        password.clear();

        notifyListeners();

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
    }
  }

  Future<void> updateprofile({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .updateprofile(
        username: username.text,
        accesstoken: preferences!.getString("accesstoken") ?? "",
      )
          .then((value) {
        isloading = false;
        getuserprofile(context: context);
        notifyListeners();

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
    }
  }

  Future<void> updateprofileimage({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .updateprofileimage(
        username: user?.viewData!.profile!.userName ?? "",
        image: profileimage!,
        accesstoken: preferences!.getString("accesstoken") ?? "",
      )
          .then((value) {
        user == null;

        isloading = false;
        getuserprofile(context: context);

        notifyListeners();

        MotionToast(
          icon: Icons.error,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          onClose: () {
            // Navigator.pop(context);
          },
          primaryColor: maincolor,
          description: Text(value["message"]),
        ).show(context);
      });
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
    }
  }
}

Future<void> dologout({required BuildContext context}) async {
  preferences!.clear().then((value) {
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  });
}
