import 'dart:io';

import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/bottomnavigationbar.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/vehicletype.dart';
import 'package:click_send/screens/companyinfo/companyinfo.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyInfoProvider extends ChangeNotifier {
  bool isloading = false;
  VehicleType? vehicleType;
  VehicleType? vehiclebody;
  String? selectedvehicle;
  String? selectedbody;
  bool iserror = false;
  StepModel step1 = StepModel(step: "1", message: false, error: false);
  StepModel step2 = StepModel(step: "2", message: false, error: false);
  StepModel step3 = StepModel(step: "3", message: false, error: false);
  StepModel step4 = StepModel(step: "4", message: false, error: false);
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController drivernumberController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();

  String errortext = "";

  File? certi;
  File? vat;
  int selectedindex = 0;
  void changeselectedImage({required BuildContext context}) {
    pickFile(context: context).then(
      (value) {
        if (selectedindex == 0) {
          certi = value;
        } else if (selectedindex == 1) {
          vat = value;
        }
        notifyListeners();
      },
    );
  }

  void changeuploadindex(int index) {
    selectedindex = index;
    notifyListeners();
  }

  Future<void> adddocument({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .uploadcompanydoc(
              accesstoken: preferences!.getString("accesstoken") ?? "",
              userid: preferences!.getString("userid") ?? "",
              certi: certi ?? File(""),
              vat: vat ?? File(""))
          .then((value) {
        isloading = false;

        vat = null;
        certi = null;

        notifyListeners();
        // notifyListeners();

        return MotionToast(
          icon: Icons.error,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          onClose: () {
            Navigator.pop(context);

            notifyListeners();
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

  Future<void> addterms({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .companytems(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
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

  Future<void> getcompanysteps({
    required BuildContext context,
    required String step,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .checkcompanysteps(
              step: step,
              userid: preferences!.getString("userid") ?? "",
              accesstoken: preferences!.getString("accesstoken") ?? "")
          .then((value) {
        isloading = false;
        // instructions = Instructions.fromJson((value));
        if (step == "1") {
          step1.step = value["step"];
          step1.message = bool.parse(value["message"]);
        } else if (step == "2") {
          step2.step = value["step"];
          step2.message = bool.parse(value["message"]);
        } else if (step == "3") {
          step3.step = value["step"];
          step3.message = bool.parse(value["message"]);
        } else if (step == "4") {
          step4.step = value["step"];
          step4.message = bool.parse(value["message"]);
        }

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
        description: const Text("Something went wrong"),
      ).show(context);
      notifyListeners();
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> getvehicletype({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getvehicletype(
              accesstoken: preferences!.getString("accesstoken") ?? "")
          .then((value) {
        print(value);
        isloading = false;
        vehicleType = VehicleType.fromJson((value));

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

  Future<void> checkthirdstep({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .checkcompanysteps(
              step: "3",
              userid: preferences!.getString("userid") ?? "",
              accesstoken: preferences!.getString("accesstoken") ?? "")
          .then((value) {
        isloading = false;
        if (value["message"] == "true") {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PagesWidget(),
              ),
              (route) => false,
            );
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CompanyInfoScreen(),
              ),
              (route) => false,
            );
          });
        }

        notifyListeners();
      });
    } on TokenExpired {
      isloading = true;
      refreshtoken();
    } on NotFoundException catch (e) {
    } on Exception catch (e) {
      logger.i(e.toString());
      isloading = false;
      iserror = true;
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => PagesWidget(),
          ),
          (route) => false,
        );
      });
      notifyListeners();
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> getvehiclebody({
    required BuildContext context,
    required String type,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getvehiclebody(
        type: type,
        accesstoken: preferences!.getString("accesstoken") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        vehiclebody = VehicleType.fromJson((value));

        notifyListeners();
      });
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

  Future<void> addbusinessinfo({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .addcompanyinfo(
        address: addressController.text,
        drivernumber: drivernumberController.text,
        username: nameController.text,
        vehiclebody: selectedbody!,
        vehiclenumber: selectedvehicle!,
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
        vehicletype: selectedvehicle!,
      )
          .then((value) {
        isloading = false;
        // reset();
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

  void changevehicletype({required String value}) {
    selectedvehicle = value;
    notifyListeners();
  }

  void changevehiclebody({required String value}) {
    selectedbody = value;
    notifyListeners();
  }
}
