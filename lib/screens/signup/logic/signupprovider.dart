import 'dart:convert';

import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/model/alreadyexists.dart';
import 'package:click_send/model/sendotp.dart';
import 'package:click_send/screens/forgot/forgotpasswordotp.dart';
import 'package:click_send/screens/otp/otpverification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class SignupProvider extends ChangeNotifier {
  bool isloading = false;
  String errortext = "";
  SendOtpResponse? sendOtpResponse;

  bool iserror = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void assingregisterType({required String type}) {
    notifyListeners();
  }

  void reset() {
    emailcontroller.clear();
    nameController.clear();
    mobileController.clear();
    passwordController.clear();
    cPasswordController.clear();
    notifyListeners();
  }

  Future<void> douserlogin({
    required BuildContext context,
    required String mobile,
    required String registerType,
    required String dialcode,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .userregister(
        dialcode: dialcode,
        mobile: mobileController.text,
        passwordconfirmation: cPasswordController.text,
        term: "yes",
        username: nameController.text,
        usertype: registerType,
        email: emailcontroller.text,
        password: passwordController.text,
      )
          .then((value) {
        isloading = false;

        reset();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpVerification(
              message: value['message'],
              mobile: mobile,
            ),
          ),
        );

        notifyListeners();
      });
    } on UnauthorisedException catch (e) {
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
    } on InvalidInputException catch (e) {
      debugPrint(
        e.toString(),
      );
      isloading = false;
      iserror = true;
      var alreadyexists = AlreadyExists.fromJson(jsonDecode(e.message));
      if (alreadyexists.error.email.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: maincolor,
            content: Text(
              alreadyexists.error.email.first,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (alreadyexists.error.mobile.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            alreadyexists.error.mobile.first,
          ),
          duration: const Duration(seconds: 2),
        ));
      } else if (alreadyexists.error.dialcode.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            alreadyexists.error.dialcode.first,
          ),
          duration: const Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            e.message.toString(),
          ),
          duration: const Duration(seconds: 2),
        ));
      }
    } on Exception catch (e) {
      iserror = true;
      print("error is $e");
      isloading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: maincolor,
        content: Text(
          "${e.toString()} \n\n ",
        ),
        duration: const Duration(seconds: 2),
      ));

      errortext = e.toString();
      notifyListeners();
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> sendOtp({
    required BuildContext context,
    required String type,
    required String mobilenumber,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .sendEmailOTP(
        email: mobilenumber,
        type: type,
      )
          .then((value) {
        isloading = false;

        sendOtpResponse = SendOtpResponse.fromJson(value);

        reset();

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ForgotPasswordOTP(
                    message: sendOtpResponse!.message,
                    type: type,
                  )),
          (route) => false,
        );

        notifyListeners();
      });
    } on UnauthorisedException catch (e) {
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
    } on NotFoundException catch (e) {
      debugPrint(e.toString());
      isloading = false;
      iserror = true;
      MotionToast(
              icon: Icons.error,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 60.h,
              primaryColor: maincolor,
              description: const Text("User Not Found"))
          .show(context);
      notifyListeners();
    } on Exception catch (e) {
      iserror = true;

      isloading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: maincolor,
        content: Text(
          "${e.toString()} \n\n ",
        ),
        duration: const Duration(seconds: 2),
      ));

      errortext = e.toString();
      notifyListeners();
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> reSendOtp({
    required BuildContext context,
    required String type,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .reSendOTP(
        email: emailcontroller.text,
        type: type,
      )
          .then((value) {
        isloading = false;

        sendOtpResponse = SendOtpResponse.fromJson(value);

        reset();

        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => const ForgotPasswordOTP()),
        //   (route) => false,
        // );

        notifyListeners();
      });
    } on UnauthorisedException catch (e) {
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
    } on NotFoundException catch (e) {
      debugPrint(e.toString());
      isloading = false;
      iserror = true;
      MotionToast(
              icon: Icons.error,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 60.h,
              primaryColor: maincolor,
              description: const Text("User Not Found"))
          .show(context);
      notifyListeners();
    } on Exception catch (e) {
      iserror = true;

      isloading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: maincolor,
        content: Text(
          "${e.toString()} \n\n ",
        ),
        duration: const Duration(seconds: 2),
      ));

      errortext = e.toString();
      notifyListeners();
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }
}
