import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class DriverInfo1 extends StatefulWidget {
  const DriverInfo1({super.key});

  @override
  State<DriverInfo1> createState() => _DriverInfo1State();
}

class _DriverInfo1State extends State<DriverInfo1> {
  @override
  void initState() {
    context.read<DriverInfoProvider>().getvehicletype(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<DriverInfoProvider>(builder: (
        context,
        provider,
        child,
      ) {
        if (provider.isloading) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            OverlayLoadingProgress.start(
              context,
              color: maincolor,
            );
          });
        } else if (provider.iserror) {
          OverlayLoadingProgress.stop();
        }
        OverlayLoadingProgress.stop();
        return SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppImage(
                    ImageStrings.arrowbackicon,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    "Welcome to Click & Send",
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: maincolor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    "Please fill the details below to\nstart earning",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                DriverTextField(
                  textInputType: TextInputType.phone,
                  controller: provider.ownernumber,
                  text: "Owner’s Number",
                  imagepath: ImageStrings.contacticon,
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  controller: provider.drivernumber,
                  textInputType: TextInputType.phone,
                  text: "Driver’s Number",
                  imagepath: ImageStrings.contacticon,
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  controller: provider.ownername,
                  textInputType: TextInputType.name,
                  text: "Owner’s Name",
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  controller: provider.vehiclenumber,
                  text: "Vehicle Number",
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 3.h,
                  ),
                  child: DropdownButton<String>(
                    //   value: controller.securitytype,
                    hint: Text(
                      "City",
                      style: GoogleFonts.inter(
                        color: const Color(
                          0xffA9A9A9,
                        ),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 30.h,
                      color: const Color(0xff979797),
                    ),
                    isExpanded: true,

                    dropdownColor: Colors.white,
                    underline: const SizedBox(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    items:
                        ['driver', 'company', 'customer'].map((String items) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              items,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      //  controller.assignSecuerityType(securityType: newValue!);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 3.h,
                  ),
                  child: DropdownButton<String>(
                    hint: Text(
                      provider.selectedvehicle ?? "Vehicle Type",
                      style: GoogleFonts.inter(
                        color: provider.selectedvehicle == null
                            ? const Color(
                                0xffA9A9A9,
                              )
                            : Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 30.h,
                      color: const Color(0xff979797),
                    ),
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    underline: const SizedBox(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    items: provider.vehicleType?.viewData.map((String items) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              items,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      provider.changevehicletype(value: newValue!);
                      context
                          .read<DriverInfoProvider>()
                          .getvehiclebody(context: context, type: newValue);
                      //  controller.assignSecuerityType(securityType: newValue!);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 3.h,
                  ),
                  child: DropdownButton<String>(
                    //   value: controller.securitytype,
                    hint: Text(
                      provider.selectedbody ?? "Vehicle Body Type",
                      style: GoogleFonts.inter(
                        color: provider.selectedbody == null
                            ? const Color(
                                0xffA9A9A9,
                              )
                            : Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 30.h,
                      color: const Color(0xff979797),
                    ),
                    isExpanded: true,

                    dropdownColor: Colors.white,
                    underline: const SizedBox(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    items: provider.vehiclebody?.viewData.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: items,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  items,
                                ),
                              ),
                            ),
                          );
                        }).toList() ??
                        [],
                    onChanged: (String? newValue) {
                      provider.changevehiclebody(value: newValue!);
                      //  controller.assignSecuerityType(securityType: newValue!);
                    },
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                InkWell(
                  onTap: () {
                    if (provider.ownername.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Owner's number required"),
                      ).show(context);
                    } else if (provider.drivernumber.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Driver's number required"),
                      ).show(context);
                    } else if (provider.ownername.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Owner's name required"),
                      ).show(context);
                    } else if (provider.vehiclenumber.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Vehicle number required"),
                      ).show(context);
                    } else if (provider.selectedvehicle == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Please select vehicle"),
                      ).show(context);
                    } else if (provider.selectedbody == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Please select vehicle body"),
                      ).show(context);
                    } else {
                      provider.addvehicle(context: context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      color: maincolor,
                    ),
                    child: Center(
                      child: Text(
                        "Proceed",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }
}

class DriverTextField extends StatelessWidget {
  final String text;
  final String? imagepath;
  final TextEditingController controller;
  final TextInputType textInputType;
  const DriverTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.textInputType,
    this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20.w,
            top: 10.h,
            bottom: 10.h,
          ),
          suffixIcon: imagepath != null
              ? Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: AppImage(
                    ImageStrings.contacticon,
                  ),
                )
              : null,
          hintText: text,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xffA9A9A9),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
