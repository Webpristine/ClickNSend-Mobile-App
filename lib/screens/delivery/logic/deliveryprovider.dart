import 'dart:developer';
import 'dart:io';

import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/delivery/signreceiver.dart';
import 'package:click_send/screens/delivery/takeimagedrop.dart';
import 'package:click_send/screens/feedback/feedback.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_signature/signature.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DeliveryProvider extends ChangeNotifier {
  bool isloading = false;
  String errortext = "";
  bool iserror = false;
  List<File> selectedimage = [];
  int rating = 1;
  TextEditingController reviewController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  final control = HandSignatureControl(
    threshold: 2.0,
    smoothRatio: 0.65,
    velocityRange: 1.0,
  );

  File? selectedsign;
  Future<File> saveByteDataToFile(ByteData byteData) async {
    // Convert ByteData to Uint8List
    Uint8List uint8List = byteData.buffer.asUint8List();

    // Get the application's cache directory
    final directory = await getTemporaryDirectory();

    // Generate a unique file name using uuid
    String uniqueFileName = const Uuid().v4();
    String filePath = '${directory.path}/$uniqueFileName.png';

    // Write the Uint8List to a file
    File file = File(filePath);
    await file.writeAsBytes(uint8List);

    return file;
  }

  void convertSignintoImage({
    required BuildContext context,
    required String id,
    required String type,
    required String itemid,
  }) {
    control.toImage().then((value) async {
      await saveByteDataToFile(value!).then((value) {
        itemdelivered(
          context: context,
          id: id,
          type: type,
          itemid: itemid,
          file: value,
        );
      });

      notifyListeners();
    });
  }

  Future<void> itempick({
    required BuildContext context,
    required String id,
    required String type,
    required String itemid,
  }) async {
    // jobHistory = null;

    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .itemPickDrop(
        jobId: id,
        itemId: itemid,
        type: type,
        images: selectedimage,
        // date: date,
        accessToken: preferences!.getString("accesstoken") ?? "",
        // userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        isloading = false;
        selectedimage.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TakeImageDrop(
              itemid: itemid,
              jobid: id,
            ),
          ),
        );
        // jobHistory = JobHistory.fromJson((value));

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

  Future<void> itemdrop({
    required BuildContext context,
    required String id,
    required String type,
    required String itemid,
  }) async {
    // jobHistory = null;

    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .itemPickDrop(
        jobId: id,
        itemId: itemid,
        type: type,
        images: selectedimage,
        // date: date,
        accessToken: preferences!.getString("accesstoken") ?? "",
        // userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        isloading = false;
        selectedimage.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignFromReceiver(
              itemid: itemid,
              jobid: id,
            ),
          ),
        );
        // jobHistory = JobHistory.fromJson((value));

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

  Future<void> itemdelivered({
    required BuildContext context,
    required String id,
    required String type,
    required String itemid,
    required File file,
  }) async {
    // jobHistory = null;

    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .itemDelivered(
        jobId: id,
        itemId: itemid,
        type: type,
        name: nameController.text,
        sign: file,
        // date: date,
        accessToken: preferences!.getString("accesstoken") ?? "",
        // userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        nameController.clear();
        control.clear();
        selectedsign = null;
        MotionToast(
          icon: Icons.error,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60.h,
          primaryColor: maincolor,
          description: Text(value["message"]),
        ).show(context);
        //  selectedimage.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FeedBackScreen(
              id: id,
              // itemid: itemid,
              // jobid: id,
            ),
          ),
        );

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

  Future<void> itemfeedback({
    required BuildContext context,
    required String id,
    required File image,
  }) async {
    // jobHistory = null;

    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .addrating(
        jobId: id,
        image: image,
        givenby: "Driver",
        rating: rating,
        review: reviewController.text,
        // date: date,
        accessToken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        isloading = false;
        print("Job is $value");
        nameController.clear();
        rating = 0;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
        // jobHistory = JobHistory.fromJson((value));

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
