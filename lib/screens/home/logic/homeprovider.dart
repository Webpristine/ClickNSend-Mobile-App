import 'package:click_send/api/app_exceptions.dart';
import 'package:click_send/api/app_repository.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/driverlist.dart';
import 'package:click_send/model/jobs.dart';
import 'package:click_send/model/totalcounts.dart';
import 'package:click_send/screens/calendar/logic/calendarprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../login/logic/loginprovider.dart';

class HomeProvider extends ChangeNotifier {
  TotalCounts? totalCounts;
  bool isloading = false;
  Jobs? jobs;
  Jobs? alljobs;
  DriverList? driverList;

  double? latitude;
  double? longitude;

  String errortext = "";
  void fetchuserlocation({
    required String from,
    required BuildContext context,
  }) async {
    // Get the current location
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

// Access the latitude and longitude properties
    latitude = position.latitude;
    longitude = position.longitude;

    if (from == "home") {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        getjobs(
            context: context,
            latitude: latitude.toString(),
            longitude: longitude.toString());
        getAlljobs(
            context: context,
            latitude: latitude.toString(),
            longitude: longitude.toString());
      });
    } else if (from == "listview") {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        getjobs(
            context: context,
            latitude: latitude.toString(),
            longitude: longitude.toString());
      });
    } else if (from == "calendar") {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<CalendarProvider>().getjobhistory(
            context: context,
            latitude: latitude.toString(),
            longitude: longitude.toString());
      });
    }
    // List<Placemark> placemarks = await GeocodingPlatform.instance
    //     .placemarkFromCoordinates(position.latitude, position.longitude);
    // Placemark place = placemarks.first;

    notifyListeners();
  }

  bool iserror = false;

  Future<void> getcounts({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getcounts(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        totalCounts = TotalCounts.fromJson((value));

        notifyListeners();
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
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> getdrivercounts({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();

    try {
      await AppRepository()
          .getDriverDashboard(
        accessToken: preferences!.getString("accesstoken") ?? "",
        userId: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        print(value);
        isloading = false;
        totalCounts = TotalCounts.fromJson((value));

        notifyListeners();
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
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> getjobs({
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
        status: "pending",
        type: preferences!.getString("usertype") ?? "",
        accessToken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        isloading = false;
        jobs = Jobs.fromJson((value));

        notifyListeners();
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
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> getAlljobs({
    required BuildContext context,
    required String latitude,
    required String longitude,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .getalljobs(
        type: preferences!.getString("usertype") ?? "",
        latitude: latitude,
        longitude: longitude,
        accessToken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        alljobs = Jobs.fromJson((value));
        isloading = false;

        notifyListeners();
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
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }

  Future<void> getdrivers({
    required BuildContext context,
  }) async {
    isloading = true;

    notifyListeners();
    try {
      await AppRepository()
          .fetchdriverlist(
        accesstoken: preferences!.getString("accesstoken") ?? "",
        userid: preferences!.getString("userid") ?? "",
      )
          .then((value) {
        isloading = false;
        driverList = DriverList.fromJson((value));

        notifyListeners();
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
    } finally {
      isloading = false;
      iserror = false;
      notifyListeners();
    }
  }
}
