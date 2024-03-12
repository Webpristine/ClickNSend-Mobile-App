import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/model/sendotp.dart';
import 'package:click_send/screens/forgot/forgotpasswordotp.dart';
import 'package:click_send/screens/forgot/newpassword.dart';
import 'package:click_send/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool isloading = false;
  String errortext = "";
  bool iserror = false;
  SendOtpResponse? sendOtpResponse;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String otp = "";

  void changeotp(value) {
    otp = value;
    notifyListeners();
  }

  void reset() {
    iserror = false;
    isloading = false;
    notifyListeners();
  }

  Future<void> sendOtp({
    required BuildContext context,
    required String type,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .sendEmailOTP(
        email: emailcontroller.text.isNotEmpty
            ? emailcontroller.text
            : phoneController.text,
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

  Future<void> validateOTP({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .verifyOTP(
        email: emailcontroller.text.isNotEmpty
            ? emailcontroller.text
            : phoneController.text,
        otp: otp,
      )
          .then((value) {
        isloading = false;

        MotionToast(
          icon: Icons.error,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          primaryColor: maincolor,
          description: Text(value["message"]),
        ).show(context);

        reset();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NewPasswordScreen(),
          ),
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
              description: const Text("OTP Expired/Not Found"))
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

  Future<void> resetpassword({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .resetpassword(
        email: emailcontroller.text.isNotEmpty
            ? emailcontroller.text
            : phoneController.text,
        password: passwordController.text,
        passwordconfirmation: passwordController.text,
        otp: otp,
      )
          .then((value) {
        isloading = false;

        MotionToast(
          icon: Icons.error,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          primaryColor: maincolor,
          description: Text(value["message"]),
        ).show(context);

        reset();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
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
}
