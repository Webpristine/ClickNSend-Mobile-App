import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/companyinfo/logic/companyinfoprovider.dart';
import 'package:click_send/screens/driverinfo/driver_info_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class CompanyBusiness extends StatefulWidget {
  const CompanyBusiness({super.key});

  @override
  State<CompanyBusiness> createState() => _CompanyBusinessState();
}

class _CompanyBusinessState extends State<CompanyBusiness> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CompanyInfoProvider>().getvehicletype(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompanyInfoProvider>(builder: (context, provider, child) {
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
                    //     Navigator.pop(context, true);
                    Navigator.pop(context);
                  },
                  child: AppImage(
                    ImageStrings.arrowbackicon,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    "Welcome to Click & Send",
                    style: GoogleFonts.inter(
                      color: maincolor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  text: "Name",
                  textInputType: TextInputType.name,
                  controller: provider.nameController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  text: "Address",
                  textInputType: TextInputType.streetAddress,
                  controller: provider.addressController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  textInputType: TextInputType.phone,
                  controller: provider.drivernumberController,
                  text: "Driver’s Number",
                  imagepath: ImageStrings.contacticon,
                ),
                SizedBox(
                  height: 20.h,
                ),
                DriverTextField(
                  textInputType: TextInputType.name,
                  controller: provider.vehicleController,
                  text: "Vehicle Number",
                ),
                SizedBox(
                  height: 30.h,
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
                          .read<CompanyInfoProvider>()
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
                    if (provider.nameController.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Name required"),
                      ).show(context);
                    } else if (provider.addressController.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Address required"),
                      ).show(context);
                    } else if (provider.drivernumberController.text.isEmpty) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Driver's Number required"),
                      ).show(context);
                    } else if (provider.vehicleController.text.isEmpty) {
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
                      provider.addbusinessinfo(context: context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
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

class Vehicles {
  final String vehicleimage;
  final String vehiclename;
  Vehicles({
    required this.vehicleimage,
    required this.vehiclename,
  });
}
