import 'dart:io';

import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class AddDriverProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool isloading = false;
  bool iserror = false;

  File? driverphoto;
  File? licencefront;
  File? licenceback;
  File? addressproof;
  File? insurance;
  File? transit;
  File? liability;
  File? vehicle;
  File? v5c;
  File? dvia;
  File? nationality;
  void reset() {
    nameController.clear();
    emailController.clear();
    contactController.clear();
    passwordController.clear();
    cPasswordController.clear();
    driverphoto = null;
    licencefront = null;
    licenceback = null;
    addressproof = null;
    insurance = null;
    transit = null;
    liability = null;
    vehicle = null;
    v5c = null;
    dvia = null;
    nationality = null;
  }

  Future<void> addvehicle({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .uploadcompanydriver(
              accesstoken: preferences!.getString("accesstoken") ?? "",
              addressfile: addressproof!,
              drivertype: "driver",
              dvlafile: dvia!,
              email: emailController.text,
              gitfile: transit!,
              insurancwfile: insurance!,
              liabilityfile: liability!,
              licencebackfile: licenceback!,
              licencefile: licencefront!,
              mobile: contactController.text,
              nationalitycerti: nationality!,
              password: passwordController.text,
              userid: preferences!.getString("userid") ?? "",
              username: nameController.text,
              usertype: "driver",
              vehiclecertificate: vehicle!,
              vehilefile: v5c!)
          .then((value) {
        isloading = false;
        reset();
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
    }
  }
}
