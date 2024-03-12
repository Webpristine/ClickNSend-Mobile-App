import 'dart:ui';

import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/bids/bidstatics.dart';
import 'package:click_send/screens/job/jobstatics.dart';
import 'package:click_send/screens/myearning/myearning.dart';
import 'package:click_send/screens/profile/logic/profileprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool ispasswordvisible = false;
  bool iscpasswordvisible = false;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileProvider>().getuserprofile(context: context);
    });
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //ksd@insta@108
  void _handlerDrawer() {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeEndDrawer();
      return;
    }
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: preferences!.getString("usertype") == "company"
          ? AppDrawer(
              onDrawerItemTap: (v) {},
              scaffoldkey: _scaffoldKey,
            )
          : AppDrawerDriver(
              scaffoldkey: _scaffoldKey,
            ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: GoogleFonts.inter(
              color: const Color(0xff222B45),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _handlerDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          )
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/profilebackground.png"),
          ),
        ),
        child: Consumer<ProfileProvider>(builder: (
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
          } else if (provider.user != null) {
            OverlayLoadingProgress.stop();
            return Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    children: [
                      Text(
                        provider.user!.viewData!.profile!.userName!,
                        style: GoogleFonts.inter(
                          color: const Color(0xff222B45),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "${provider.user!.viewData!.mobile} ${provider.user!.viewData!.email}",
                        style: GoogleFonts.inter(
                          color: const Color(0xff626A7E),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      // You can customize the content of your bottom sheet here
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 12.w),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffE5E5E5),
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            child: Text(
                                              "Edit Profile",
                                              style: GoogleFonts.inter(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(
                                                  0xff404040,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsets.symmetric(
                                          //       horizontal: 16.w),
                                          //   child: Column(
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.start,
                                          //     children: [
                                          //       SizedBox(
                                          //         height: 30.h,
                                          //       ),
                                          //       Text(
                                          //         "Email",
                                          //         style: GoogleFonts.inter(
                                          //             color: Colors.black,
                                          //             fontSize: 12.sp,
                                          //             fontWeight:
                                          //                 FontWeight.w600),
                                          //       ),
                                          //       SizedBox(
                                          //         height: 10.h,
                                          //       ),
                                          //       TextFormField(
                                          //         decoration: InputDecoration(
                                          //           isDense: true,
                                          //           hintText:
                                          //               "name@clickandsend.com",
                                          //           hintStyle:
                                          //               GoogleFonts.montserrat(
                                          //             color:
                                          //                 const Color(0xff828282),
                                          //             fontSize: 12.sp,
                                          //             fontWeight: FontWeight.w400,
                                          //           ),
                                          //           border: OutlineInputBorder(
                                          //               borderSide:
                                          //                   const BorderSide(
                                          //                       color: Color(
                                          //                           0xffE0E0E0)),
                                          //               borderRadius:
                                          //                   BorderRadius.circular(
                                          //                 4.sp,
                                          //               )),
                                          //           errorBorder:
                                          //               OutlineInputBorder(
                                          //                   borderSide:
                                          //                       const BorderSide(
                                          //                           color: Color(
                                          //                               0xffE0E0E0)),
                                          //                   borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(
                                          //                     4.sp,
                                          //                   )),
                                          //           focusedBorder:
                                          //               OutlineInputBorder(
                                          //                   borderSide:
                                          //                       const BorderSide(
                                          //                           color: Color(
                                          //                               0xffE0E0E0)),
                                          //                   borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(
                                          //                     4.sp,
                                          //                   )),
                                          //           disabledBorder:
                                          //               OutlineInputBorder(
                                          //                   borderSide:
                                          //                       const BorderSide(
                                          //                           color: Color(
                                          //                               0xffE0E0E0)),
                                          //                   borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(
                                          //                     4.sp,
                                          //                   )),
                                          //           enabledBorder:
                                          //               OutlineInputBorder(
                                          //                   borderSide:
                                          //                       const BorderSide(
                                          //                           color: Color(
                                          //                               0xffE0E0E0)),
                                          //                   borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(
                                          //                     4.sp,
                                          //                   )),
                                          //           focusedErrorBorder:
                                          //               OutlineInputBorder(
                                          //             borderSide:
                                          //                 const BorderSide(
                                          //                     color: Color(
                                          //                         0xffE0E0E0)),
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //               4.sp,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Text(
                                                  "User Name",
                                                  style: GoogleFonts.inter(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                TextFormField(
                                                  controller: provider.username,
                                                  style: GoogleFonts.montserrat(
                                                    color:
                                                        const Color(0xff828282),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: "John Doe",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: const Color(
                                                          0xff828282),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xffE0E0E0)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.sp,
                                                        )),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xffE0E0E0)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              4.sp,
                                                            )),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xffE0E0E0)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              4.sp,
                                                            )),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xffE0E0E0)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              4.sp,
                                                            )),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xffE0E0E0)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              4.sp,
                                                            )),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0xffE0E0E0)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (provider.username.text
                                                        .isEmpty) {
                                                      MotionToast(
                                                        icon: Icons.error,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: double.infinity,
                                                        height: 60.h,
                                                        primaryColor: maincolor,
                                                        description: const Text(
                                                            "Enter username"),
                                                      ).show(context);
                                                    } else {
                                                      provider.updateprofile(
                                                          context: context);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 16.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        6,
                                                      ),
                                                      color: maincolor,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Update Profile",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 70.h,
                                          )
                                        ],
                                      )),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const AppImage(
                              "assets/images/edit.svg",
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              "Edit Profile",
                              style: GoogleFonts.inter(
                                  color: const Color(0xff626A7E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (preferences!.getString("usertype") == "company") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const JobStaticsScreen(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BidStaticsScreen(),
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            const AppImage(
                              "assets/images/statistics.svg",
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              preferences!.getString("usertype") == "company"
                                  ? "Job Statistics"
                                  : "Bid Statistics",
                              style: GoogleFonts.inter(
                                  color: const Color(0xff626A7E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyEarningScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const AppImage(
                              "assets/images/prime_pound.svg",
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              "Total Earning",
                              style: GoogleFonts.inter(
                                  color: const Color(0xff626A7E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (
                                context,
                                s,
                              ) {
                                return SingleChildScrollView(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        // You can customize the content of your bottom sheet here
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 12.w),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xffE5E5E5),
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              child: Text(
                                                "Change Password",
                                                style: GoogleFonts.inter(
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color(
                                                    0xff404040,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "In order to ",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                    TextSpan(
                                                        text:
                                                            "protect your account, ",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    TextSpan(
                                                        text:
                                                            "make sure your\npassword:",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                    TextSpan(
                                                        text:
                                                            "\n\n\n⚫️   Is longer than 7 characters",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                    TextSpan(
                                                        text:
                                                            "\n\n⚫️   Does not match or significantly contain your username,\n       e.g. do not use ‘username123’.",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Text(
                                                    "New Password",
                                                    style: GoogleFonts.inter(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  TextFormField(
                                                    obscureText:
                                                        ispasswordvisible
                                                            ? false
                                                            : true,
                                                    obscuringCharacter: "*",
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: "*************",
                                                      hintStyle: GoogleFonts
                                                          .montserrat(
                                                        color: const Color(
                                                            0xff828282),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xffE0E0E0)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.sp,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xffE0E0E0)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.sp,
                                                        ),
                                                      ),
                                                      suffixIcon: InkWell(
                                                        onTap: () {
                                                          s(() {
                                                            ispasswordvisible =
                                                                !ispasswordvisible;
                                                          });

                                                          //  changepasswordvisiblity();
                                                        },
                                                        child: Icon(
                                                          ispasswordvisible
                                                              ? Icons
                                                                  .remove_red_eye
                                                              : Icons
                                                                  .visibility_off_rounded,
                                                          color: const Color(
                                                              0xffC4C4C4),
                                                        ),
                                                      ),
                                                    ),
                                                    controller:
                                                        provider.password,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Text(
                                                    "Re-enter Your New Password",
                                                    style: GoogleFonts.inter(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        provider.cPassword,
                                                    // style: GoogleFonts.montserrat(
                                                    //   color:
                                                    //       const Color(0xff828282),
                                                    //   fontSize: 12.sp,
                                                    //   fontWeight: FontWeight.w400,
                                                    // ),
                                                    obscureText:
                                                        iscpasswordvisible
                                                            ? false
                                                            : true,
                                                    obscuringCharacter: "*",
                                                    decoration: InputDecoration(
                                                      suffixIcon: InkWell(
                                                        onTap: () {
                                                          s(() {
                                                            iscpasswordvisible =
                                                                !iscpasswordvisible;
                                                          });
                                                        },
                                                        child: Icon(
                                                          iscpasswordvisible
                                                              ? Icons
                                                                  .remove_red_eye
                                                              : Icons
                                                                  .visibility_off_rounded,
                                                          color: const Color(
                                                              0xffC4C4C4),
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      hintText: "*************",
                                                      hintStyle: GoogleFonts
                                                          .montserrat(
                                                        color: const Color(
                                                            0xff828282),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xffE0E0E0)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4.sp,
                                                              )),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xffE0E0E0)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40.h,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider.password.text
                                                          .isEmpty) {
                                                        MotionToast(
                                                          icon: Icons.error,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width:
                                                              double.infinity,
                                                          height: 60.h,
                                                          primaryColor:
                                                              maincolor,
                                                          description: const Text(
                                                              "Enter password"),
                                                        ).show(context);
                                                      } else if (provider
                                                          .cPassword
                                                          .text
                                                          .isEmpty) {
                                                        MotionToast(
                                                          icon: Icons.error,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width:
                                                              double.infinity,
                                                          height: 60.h,
                                                          primaryColor:
                                                              maincolor,
                                                          description: const Text(
                                                              "Password not match"),
                                                        ).show(context);
                                                      } else if (provider
                                                              .password.text !=
                                                          provider
                                                              .cPassword.text) {
                                                        MotionToast(
                                                          icon: Icons.error,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width:
                                                              double.infinity,
                                                          height: 60.h,
                                                          primaryColor:
                                                              maincolor,
                                                          description: const Text(
                                                              "Password not match"),
                                                        ).show(context);
                                                      } else {
                                                        provider.changepassword(
                                                            context: context);
                                                      }
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 16.h,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          6,
                                                        ),
                                                        color: maincolor,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Change Password",
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50.h,
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              });
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const AppImage(
                              "assets/images/lock.svg",
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              "Change Password",
                              style: GoogleFonts.inter(
                                  color: const Color(0xff626A7E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          provider.douserlogout(context: context);
                        },
                        child: Row(
                          children: [
                            const AppImage(
                              "assets/images/logout.svg",
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              "Logout",
                              style: GoogleFonts.inter(
                                  color: const Color(0xff626A7E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
