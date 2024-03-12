import 'dart:io';
import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/bottomnavigationbar.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/instructions.dart';
import 'package:click_send/model/vehicletype.dart';
import 'package:click_send/screens/driverinfo/driverinfo.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverInfoProvider extends ChangeNotifier {
  bool isloading = false;
  VehicleType? vehicleType;
  VehicleType? vehiclebody;
  Instructions? instructions;
  bool iserror = false;
  TextEditingController ownernumber = TextEditingController();
  TextEditingController drivernumber = TextEditingController();
  TextEditingController ownername = TextEditingController();
  TextEditingController vehiclenumber = TextEditingController();
  TextEditingController city = TextEditingController();
  StepModel step1 = StepModel(step: "1", message: false, error: false);
  StepModel step2 = StepModel(step: "2", message: false, error: false);
  StepModel step3 = StepModel(step: "3", message: false, error: false);
  StepModel step4 = StepModel(step: "4", message: false, error: false);
  int selectedindex = 0;
  File? licencefile;
  File? addressfile;
  File? insurancwfile;
  File? gitfile;
  File? liabilityfile;
  File? vehilefile;
  File? dvlafile;
  File? vehiclecertificate;
  File? nationalitycerti;

  String? selectedvehicle;
  String? selectedbody;

  String errortext = "";

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

  void changevehicletype({required String value}) {
    selectedvehicle = value;
    notifyListeners();
  }

  void changevehiclebody({required String value}) {
    selectedbody = value;
    notifyListeners();
  }

  Future<void> addvehicle({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .addnewvehicle(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        city: "Vadodara",
        drivernumber: drivernumber.text,
        ownername: ownername.text,
        ownernumber: ownernumber.text,
        userid: preferences!.getString("userid") ?? "",
        vehiclenumber: vehiclenumber.text,
        vehicletype: selectedvehicle!,
        vehilceBody: selectedbody!,
      )
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

  Future<void> adddocument({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .uploadvehileimage(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
        addressfile: addressfile!,
        dvlafile: dvlafile!,
        gitfile: gitfile!,
        insurancwfile: insurancwfile!,
        liabilityfile: liabilityfile!,
        licencefile: licencefile!,
        nationalitycerti: nationalitycerti!,
        vehiclecertificate: vehiclecertificate!,
        vehilefile: vehilefile!,
      )
          .then((value) {
        isloading = false;
        reset();
        licencefile = null;
        addressfile = null;
        dvlafile = null;
        gitfile = null;
        insurancwfile = null;
        liabilityfile = null;
        nationalitycerti = null;
        vehiclecertificate = null;
        vehilefile = null;
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

  void reset() {
    drivernumber.clear();
    ownername.clear();
    ownernumber.clear();
    vehiclenumber.clear();
    selectedbody = null;
    selectedvehicle = null;
  }

  Future<void> getinstructions({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getinstructions(
              accesstoken: preferences!.getString("accesstoken") ?? "")
          .then((value) {
        print(value);
        isloading = false;
        instructions = Instructions.fromJson((value));

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

  Future<void> addterms({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .driverterms(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
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

  void changeselectedImage({required BuildContext context}) {
    pickFile(context: context).then(
      (value) {
        if (selectedindex == 0) {
          licencefile = value;
        } else if (selectedindex == 1) {
          addressfile = value;
        } else if (selectedindex == 2) {
          insurancwfile = value;
        } else if (selectedindex == 3) {
          gitfile = value;
        } else if (selectedindex == 4) {
          liabilityfile = value;
        } else if (selectedindex == 5) {
          vehilefile = value;
        } else if (selectedindex == 6) {
          dvlafile = value;
        } else if (selectedindex == 7) {
          vehiclecertificate = value;
        } else if (selectedindex == 8) {
          nationalitycerti = value;
        }
        notifyListeners();
      },
    );
  }

  Future<void> checkthirdstep({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .checkdriversteps(
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
                builder: (context) => DriverInfo(),
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

  Future<void> getdriversteps({
    required BuildContext context,
    required String step,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .checkdriversteps(
              step: step,
              userid: preferences!.getString("userid") ?? "",
              accesstoken: preferences!.getString("accesstoken") ?? "")
          .then((value) {
        print("data value is $value");
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
    } on NotFoundException catch (e) {
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

  void changeuploadindex(int index) {
    selectedindex = index;
    notifyListeners();
  }
}

String getFileName(File file) {
  // Use the path property to get the file's path
  String filePath = file.path;

  // Use the path package to extract the file name from the path
  List<String> pathParts = filePath.split(Platform.pathSeparator);
  return pathParts.last;
}

Future<File?> pickFile({
  List<String>? extensions,
  required BuildContext context,
  ImageSource source = ImageSource.gallery,
}) async {
  try {
    // ignore: invalid_use_of_visible_for_testing_member
    final xPath = await ImagePicker.platform.getImageFromSource(
      source: source,
    );
    if (xPath != null) {
      final paths = File(xPath.path);

      return File(paths.path);
    } else {
      MotionToast(
        icon: Icons.error,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60.h,
        primaryColor: maincolor,
        description: const Text("No file selected."),
      ).show(context);

      return null;
    }
  } catch (ex) {
    MotionToast(
      icon: Icons.error,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 60.h,
      primaryColor: maincolor,
      description: Text("Unsupported operation$ex"),
    ).show(context);
  }
  return null;
}

class StepModel {
  String step;
  bool message = false;
  bool error = false;
  StepModel({
    required this.step,
    required this.message,
    required this.error,
  });
}
