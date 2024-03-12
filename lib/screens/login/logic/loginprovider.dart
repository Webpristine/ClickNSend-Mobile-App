// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/userdetail.dart';
import 'package:click_send/screens/companyinfo/companyinfo.dart';
import 'package:click_send/screens/companyinfo/logic/companyinfoprovider.dart';
import 'package:click_send/screens/driverinfo/driverinfo.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:click_send/screens/login/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  UserDetail? userDetail;
  bool isloading = false;
  final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String errortext = "";

  bool iserror = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void reset() {
    iserror = false;
    isloading = false;
    notifyListeners();
  }

  Future<fa.User?> handleSignIn({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final fa.AuthCredential credential = fa.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final fa.UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final fa.User? user = authResult.user;
        socialLogin(context: context, email: user!.email!);
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //     builder: (context) => const CompanyInfoScreen(),
        //   ),
        //   (route) => false,
        // );
        return user;
      }
    } catch (error) {
      print("Error signing in: $error");
    }

    return null;
  }

  Future<void> douserlogin({required BuildContext context}) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .douserlogin(
        email: emailcontroller.text,
        password: passwordController.text,
      )
          .then((value) {
        isloading = false;

        userDetail = UserDetail.fromJson(value);

        if (userDetail!.user.userType == "company") {
          reset();
          emailcontroller.clear();
          passwordController.clear();
          preferences!.setString("accesstoken", userDetail!.accessToken);

          preferences!.setString(
            "userid",
            userDetail!.user.id.toString(),
          );
          preferences!.setString("usertype", userDetail!.user.userType);
          preferences!.setString(
            "usertype",
            userDetail!.user.userType,
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const CompanyInfoScreen(),
            ),
            (route) => false,
          );
        } else if (userDetail!.user.userType == "driver") {
          reset();
          emailcontroller.clear();
          passwordController.clear();
          preferences!.setString("accesstoken", userDetail!.accessToken);

          preferences!.setString(
            "userid",
            userDetail!.user.id.toString(),
          );
          preferences!.setString("usertype", userDetail!.user.userType);
          preferences!.setString(
            "usertype",
            userDetail!.user.userType,
          );
          context.read<DriverInfoProvider>().checkthirdstep(context: context);
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(
          //     builder: (context) => const DriverInfo(),
          //   ),
          //   (route) => false,
          // );
        } else {
          MotionToast(
            icon: Icons.error,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 60.h,
            primaryColor: maincolor,
            description: const Text("Invaild User Type"),
          ).show(context);
        }

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
      if (kDebugMode) {
        print("errorss is ${e.message}");
      }
      isloading = false;
      iserror = true;
      MotionToast(
        icon: Icons.error,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60.h,
        primaryColor: maincolor,
        description: Text(e.message),
      ).show(context);
      notifyListeners();
    } on TokenExpired catch (e) {
      print("error is ${e.toString()}");
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
    } on Exception catch (e) {
      print("error is ${e.toString()}");
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

  Future<void> socialLogin({
    required BuildContext context,
    required String email,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .socialLogin(
        email: email,
      )
          .then((value) {
        isloading = false;

        userDetail = UserDetail.fromJson(value);

        if (userDetail!.user.userType == "company") {
          reset();
          emailcontroller.clear();
          passwordController.clear();
          preferences!.setString("accesstoken", userDetail!.accessToken);

          preferences!.setString(
            "userid",
            userDetail!.user.id.toString(),
          );
          preferences!.setString("usertype", userDetail!.user.userType);
          preferences!.setString(
            "usertype",
            userDetail!.user.userType,
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const CompanyInfoScreen(),
            ),
            (route) => false,
          );
        } else if (userDetail!.user.userType == "driver") {
          reset();
          emailcontroller.clear();
          passwordController.clear();
          preferences!.setString(
            "accesstoken",
            userDetail!.accessToken,
          );

          preferences!.setString(
            "userid",
            userDetail!.user.id.toString(),
          );
          preferences!.setString(
            "usertype",
            userDetail!.user.userType,
          );
          preferences!.setString(
            "usertype",
            userDetail!.user.userType,
          );
          context.read<DriverInfoProvider>().checkthirdstep(context: context);
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(
          //     builder: (context) => const DriverInfo(),
          //   ),
          //   (route) => false,
          // );
        } else {
          MotionToast(
            icon: Icons.error,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 60.h,
            primaryColor: maincolor,
            description: const Text("Invaild User Type"),
          ).show(context);
        }

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
      if (kDebugMode) {
        print("errorss is ${e.message}");
      }
      isloading = false;
      iserror = true;
      MotionToast(
        icon: Icons.error,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60.h,
        primaryColor: maincolor,
        description: Text(e.message),
      ).show(context);
      notifyListeners();
    } on TokenExpired catch (e) {
      print("error is ${e.toString()}");
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
    } on Exception catch (e) {
      print("error is ${e.toString()}");
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

Future isLoggedIn({required BuildContext context}) async {
  final String istokenavailable = preferences!.getString("accesstoken") ?? "";

  if (istokenavailable == "") {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    });
  } else {
    print(istokenavailable);
    if (preferences!.getString("usertype") == "company") {
      context.read<CompanyInfoProvider>().checkthirdstep(context: context);

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) => const CompanyInfoScreen(),
      //     ),
      //     (route) => false,
      //   );
      // });
    } else {
      context.read<DriverInfoProvider>().checkthirdstep(context: context);
      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const DriverInfo(),
      //     ),
      //     (route) => false,
      //   );
      // });
    }
  }
}

Future refreshtoken() async {
  await AppRepository()
      .refreshtoken(accesstoken: preferences!.getString("accesstoken") ?? "")
      .then((value) {
    log("Token is" + value.toString());
  });
}
