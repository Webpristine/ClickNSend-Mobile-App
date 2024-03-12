import 'dart:io';

import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/helpers/strings_extentation.dart';
import 'package:click_send/screens/companyinfo/companydriver.dart';
import 'package:click_send/screens/delivery/takeimagedrop.dart';
import 'package:click_send/screens/driver/logic/adddriverprovider.dart';
import 'package:click_send/screens/driverinfo/driver_info_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddDriverProvider>(builder: (context, controller, child) {
      return WillPopScope(
        onWillPop: () async {
          controller.reset();
          Navigator.pop(context);

          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 43.w,
            leading: Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                top: 13.h,
              ),
              child: Consumer<AddDriverProvider>(
                  builder: (context, controller, child) {
                return InkWell(
                  onTap: () {
                    controller.reset();
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                );
              }),
            ),
            title: Text(
              "Add Driver",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Consumer<AddDriverProvider>(
                builder: (context, controller, child) {
              if (controller.isloading) {
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  OverlayLoadingProgress.start(
                    context,
                    color: maincolor,
                  );
                });
              } else if (controller.iserror) {
                OverlayLoadingProgress.stop();
              } else if (controller.isloading == false) {
                OverlayLoadingProgress.stop();
              }
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    DriverTextField(
                      controller: controller.nameController,
                      textInputType: TextInputType.name,
                      text: "Enter Full Name",
                      // imagepath: ImageStrings.contacticon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DriverTextField(
                      controller: controller.emailController,
                      textInputType: TextInputType.emailAddress,
                      text: "Enter Your Email Address",
                      // imagepath: ImageStrings.contacticon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DriverTextField(
                      controller: controller.contactController,
                      textInputType: TextInputType.number,
                      text: "Enter Your Contact Number",
                      // imagepath: ImageStrings.contacticon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DriverTextField(
                      controller: controller.passwordController,
                      textInputType: TextInputType.visiblePassword,
                      text: "Enter Password",
                      // imagepath: ImageStrings.contacticon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DriverTextField(
                      controller: controller.cPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      text: "Enter Confirm Password",
                      // imagepath: ImageStrings.contacticon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.driverphoto = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Driver Photo",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.driverphoto != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.driverphoto != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.driverphoto = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.driverphoto!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.licencefront = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Driver Licence Front",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.licencefront != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.licencefront != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.licencefront = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.licencefront!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.licenceback = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Driver Licence Back",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.licenceback != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.licenceback != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.licenceback = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.licenceback!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.addressproof = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Address Proof",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.addressproof != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.addressproof != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.addressproof = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.addressproof!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.insurance = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Insurance Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.insurance != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.insurance != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.insurance = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.insurance!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.transit = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Transit Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.transit != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.transit != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.transit = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.transit!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.liability = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Liability Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.liability != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.liability != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.liability = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.liability!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.vehicle = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Vehicle Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.vehicle != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.vehicle != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.vehicle = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.vehicle!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.v5c = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select V5c Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.v5c != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.v5c != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.v5c = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.v5c!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.dvia = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Dvia Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.dvia != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.dvia != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.dvia = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.dvia!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(context: context).then((value) {
                          setState(() {
                            controller.nationality = File(value.path);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            // horizontal: 30.w,
                            ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffE4E4E4),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            const AppImage(
                              "assets/images/gallery.svg",
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Natianality Proof Certificate",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ".jpg .png .jpeg",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.nationality != null,
                        child: SizedBox(
                          height: 30.h,
                        )),
                    controller.nationality != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: SizedBox(
                                height: 70.h,
                                child: badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: -12,
                                    start: 47,
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.nationality = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0,
                                                blurRadius: 3)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 70.h,
                                      width: 60.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          controller.nationality!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                )),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.nameController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text("Please Enter Your Name"),
                          ).show(context);
                        } else if (!controller.emailController.text
                            .isValidEmail()) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please Enter Valid E-mail"),
                          ).show(context);
                        } else if (controller.contactController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please Enter Your Mobile Number"),
                          ).show(context);
                        } else if (controller.passwordController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text("Please Enter Password"),
                          ).show(context);
                        } else if (controller.passwordController.text.length <
                            8) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text(
                                "Password Length Should Be 8 Characters Long"),
                          ).show(context);
                        } else if (controller.passwordController.text !=
                            controller.cPasswordController.text) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text("Password Not Match"),
                          ).show(context);
                        } else if (controller.driverphoto == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select driver photo"),
                          ).show(context);
                        } else if (controller.licencefront == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select Licence Front"),
                          ).show(context);
                        } else if (controller.licenceback == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select Licence Back"),
                          ).show(context);
                        } else if (controller.addressproof == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select address proof"),
                          ).show(context);
                        } else if (controller.insurance == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text(
                                "Please select insurance certificate"),
                          ).show(context);
                        } else if (controller.transit == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select transit certificate"),
                          ).show(context);
                        } else if (controller.liability == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text(
                                "Please select liability certificate"),
                          ).show(context);
                        } else if (controller.vehicle == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select vehicle certificate"),
                          ).show(context);
                        } else if (controller.v5c == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select V5c certificate"),
                          ).show(context);
                        } else if (controller.dvia == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please select Dvia certificate"),
                          ).show(context);
                        } else if (controller.nationality == null) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text(
                                "Please select nationality certificate"),
                          ).show(context);
                        } else {
                          controller.addvehicle(context: context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                              bottom: 20.h,
                              //    top: controller.selectedimage.isNotEmpty ? 20.h : 40.h,
                            ) +
                            EdgeInsets.symmetric(
                              horizontal: 0.w,
                            ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: maincolor,
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
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
              );
            }),
          ),
        ),
      );
    });
  }
}
