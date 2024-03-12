import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/bottomnavigationbar.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/companyinfo/comapnybusiness.dart';
import 'package:click_send/screens/companyinfo/companydoc.dart';
import 'package:click_send/screens/companyinfo/logic/companyinfoprovider.dart';
import 'package:click_send/screens/driverinfo/driver_instructions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  @override
  void initState() {
    for (var i = 1; i < 5; i++) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<CompanyInfoProvider>().getcompanysteps(
              context: context,
              step: i.toString(),
            );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<CompanyInfoProvider>(
            builder: (context, controller, child) {
          if (controller.isloading) {
            SchedulerBinding.instance.addPostFrameCallback(
              (timeStamp) {
                OverlayLoadingProgress.start(
                  context,
                  color: maincolor,
                );
              },
            );
          } else if (controller.iserror) {
            OverlayLoadingProgress.stop();
          }
          OverlayLoadingProgress.stop();
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          //     Navigator.pop(context, true);
                          SystemNavigator.pop();
                        },
                        child: AppImage(
                          ImageStrings.arrowbackicon,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: AppImage(
                          ImageStrings.comapanybag,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Text(
                          "Hi, let’s start your journey\nas a Click & Send Partner",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 25.h,
                  ),
                  color: const Color(0xffF8F9FD),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.step1.message == false) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CompanyBusiness(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ) +
                              EdgeInsets.only(
                                left: 10.w,
                              ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: controller.step1.message == true
                                  ? Colors.green
                                  : maincolor,
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              left: 20.w,
                              right: 15.w,
                              bottom: 25.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: controller.step1.message == true
                                      ? SizedBox(
                                          height: 15.h,
                                        )
                                      : Text(
                                          "Start",
                                          style: GoogleFonts.inter(
                                            color: maincolor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-35, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          10.r,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 2,
                                            color:
                                                controller.step1.message == true
                                                    ? Colors.green
                                                    : maincolor,
                                          ),
                                        ),
                                        child: Text(
                                          "1",
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Business info",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Name, address, documents, etc.",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.step2.message == false) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CompanyDocument(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ) +
                              EdgeInsets.only(
                                left: 10.w,
                              ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: controller.step1.message == false
                                    ? const Color(0xffEDEDED)
                                    : controller.step2.message == true
                                        ? Colors.green
                                        : maincolor,
                              ),
                              borderRadius: BorderRadius.circular(9)),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              left: 20.w,
                              right: 15.w,
                              bottom: 25.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: controller.step1.message == false
                                        ? Icon(
                                            Icons.lock,
                                            color: const Color(0xffEDEDED),
                                            size: 20.sp,
                                          )
                                        : controller.step2.message == false
                                            ? Text(
                                                "Start",
                                                style: GoogleFonts.inter(
                                                  color: maincolor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            : SizedBox(
                                                height: 15.h,
                                              )),
                                Transform.translate(
                                  offset: const Offset(-35, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          10.r,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 2,
                                              color: controller.step1.message ==
                                                      false
                                                  ? const Color(0xffEDEDED)
                                                  : controller.step2.message ==
                                                          true
                                                      ? Colors.green
                                                      : maincolor,
                                            )),
                                        child: Text(
                                          "2",
                                          style: GoogleFonts.inter(
                                            color: const Color(0xffCECECE),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Upload Documents",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Name, email, driving license, etc.",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 9.h,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.step3.message == false) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DriverInstructions(
                                  isfromcompany: true,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ) +
                              EdgeInsets.only(
                                left: 10.w,
                              ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: controller.step2.message == false
                                  ? const Color(0xffEDEDED)
                                  : controller.step3.message == true
                                      ? Colors.green
                                      : maincolor,
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              left: 20.w,
                              right: 15.w,
                              bottom: 25.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: controller.step2.message == false
                                        ? Icon(
                                            Icons.lock,
                                            color: const Color(0xffEDEDED),
                                            size: 20.sp,
                                          )
                                        : controller.step3.message == false
                                            ? Text(
                                                "Start",
                                                style: GoogleFonts.inter(
                                                  color: maincolor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            : SizedBox(
                                                height: 15.h,
                                              )),
                                Transform.translate(
                                  offset: const Offset(-35, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          10.r,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 2,
                                              color: controller.step2.message ==
                                                      false
                                                  ? const Color(0xffEDEDED)
                                                  : controller.step3.message ==
                                                          true
                                                      ? Colors.green
                                                      : maincolor,
                                            )),
                                        child: Text(
                                          "3",
                                          style: GoogleFonts.inter(
                                            color: controller.step2.message ==
                                                    false
                                                ? const Color(0xffCECECE)
                                                : Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Read Instruction",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Read Instruction",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagesWidget(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ) +
                              EdgeInsets.only(
                                left: 10.w,
                              ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: const Color(0xffEDEDED),
                              ),
                              borderRadius: BorderRadius.circular(9)),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              left: 20.w,
                              right: 15.w,
                              bottom: 25.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.lock,
                                      color: const Color(0xffEDEDED),
                                      size: 20.sp,
                                    )),
                                Transform.translate(
                                  offset: const Offset(-35, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          10.r,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 2,
                                              color: const Color(0xffEDEDED),
                                            )),
                                        child: Text(
                                          "4",
                                          style: GoogleFonts.inter(
                                            color: const Color(0xffCECECE),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Get Your First Job",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "You are ready to do your first trip",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 9.h,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
        }),
      ),
    );
  }
}
