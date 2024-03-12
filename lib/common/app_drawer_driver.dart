import 'dart:ui';

import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/screens/invoice/invoicescreen.dart';
import 'package:click_send/screens/profile/logic/profileprovider.dart';
import 'package:click_send/screens/profile/myprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class AppDrawerDriver extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  const AppDrawerDriver({
    super.key,
    required this.scaffoldkey,
  });

  @override
  State<AppDrawerDriver> createState() => _AppDrawerDriverState();
}

class _AppDrawerDriverState extends State<AppDrawerDriver> {
  bool ispasswordvisible = false;
  bool iscpasswordvisible = false;
  String usertype = "";
  Future isuserskipped() async {
    final String userType = preferences!.getString("usertype") ?? "";

    setState(() {
      usertype = userType;
    });
  }

  ProfileProvider profileProvider = ProfileProvider();
  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    isuserskipped();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EchoBackdropFilterWidget(
      child: Drawer(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(
          0.8,
        ),

        // shadowColor: Colors.transparent,
        // surfaceTintColor: Colors.black,
        width: 280.w,

        child: ClipRRect(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 54.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //   sizedBoxWithHeight(64),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      AppImage(
                        'assets/images/menu.svg',
                        height: 25.h,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Menu",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              )),
                          const SizedBox(),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          widget.scaffoldkey.currentState!.closeEndDrawer();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  itemCount: drawerItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(
                    height: 20.h,
                  ),
                  itemBuilder: (_, index) => _renderListItem(index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderListItem(int index) {
    return GestureDetector(
      onTap: () => _handleDrawerItemTap(drawerItems[index].type),
      child: Row(
        children: [
          AppImage(
            drawerItems[index].icon,
            height: 25.h,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(drawerItems[index].text,
                  style: GoogleFonts.inter(
                    color: const Color(0xff626A7E),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(),
            ],
          )
        ],
      ),
    );
  }

  void _handleDrawerItemTap(DrawerItemType type) {
    switch (type) {
      case DrawerItemType.MY_PROFILE:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyProfileScreen(),
          ),
        );
        // if (userplan == "Free") {
        //   AppEnvironment.navigator.push(
        //     PageRouteBuilder(
        //       opaque: false,
        //       pageBuilder: (_, __, ___) => const PurchaseNew(
        //         isfromhome: true,
        //       ),
        //     ),
        //   );
        // } else {
        //   AppEnvironment.navigator.pushNamed(GeneralRoutes.pastQrScreen);
        // }
        break;

      case DrawerItemType.INVOICE:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InvoiceScreen(),
          ),
        );
        // AppEnvironment.navigator.push(
        //   PageRouteBuilder(
        //     opaque: false,
        //     pageBuilder: (_, __, ___) => const TermsConditions(),
        //   ),
        // );
        break;

      case DrawerItemType.CHANGE_PASSWORD:
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (
              context,
              s,
            ) {
              return Consumer<ProfileProvider>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        // You can customize the content of your bottom sheet here
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12.w),
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
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "In order to ",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    TextSpan(
                                        text: "protect your account, ",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    TextSpan(
                                        text: "make sure your\npassword:",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    TextSpan(
                                        text:
                                            "\n\n\n⚫️   Is longer than 7 characters",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    TextSpan(
                                        text:
                                            "\n\n⚫️   Does not match or significantly contain your username,\n       e.g. do not use ‘username123’.",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    "New Password",
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    obscureText:
                                        ispasswordvisible ? false : true,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "*************",
                                      hintStyle: GoogleFonts.montserrat(
                                        color: const Color(0xff828282),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE0E0E0)),
                                        borderRadius: BorderRadius.circular(
                                          4.sp,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE0E0E0)),
                                        borderRadius: BorderRadius.circular(
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
                                              ? Icons.remove_red_eye
                                              : Icons.visibility_off_rounded,
                                          color: const Color(0xffC4C4C4),
                                        ),
                                      ),
                                    ),
                                    controller: provider.password,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    "Re-enter Your New Password",
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    controller: provider.cPassword,
                                    // style: GoogleFonts.montserrat(
                                    //   color:
                                    //       const Color(0xff828282),
                                    //   fontSize: 12.sp,
                                    //   fontWeight: FontWeight.w400,
                                    // ),
                                    obscureText:
                                        iscpasswordvisible ? false : true,
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
                                              ? Icons.remove_red_eye
                                              : Icons.visibility_off_rounded,
                                          color: const Color(0xffC4C4C4),
                                        ),
                                      ),
                                      isDense: true,
                                      hintText: "*************",
                                      hintStyle: GoogleFonts.montserrat(
                                        color: const Color(0xff828282),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE0E0E0)),
                                          borderRadius: BorderRadius.circular(
                                            4.sp,
                                          )),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE0E0E0)),
                                        borderRadius: BorderRadius.circular(
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
                                      if (provider.password.text.isEmpty) {
                                        MotionToast(
                                          icon: Icons.error,
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 60.h,
                                          primaryColor: maincolor,
                                          description:
                                              const Text("Enter password"),
                                        ).show(context);
                                      } else if (provider
                                          .cPassword.text.isEmpty) {
                                        MotionToast(
                                          icon: Icons.error,
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 60.h,
                                          primaryColor: maincolor,
                                          description:
                                              const Text("Password not match"),
                                        ).show(context);
                                      } else if (provider.password.text !=
                                          provider.cPassword.text) {
                                        MotionToast(
                                          icon: Icons.error,
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 60.h,
                                          primaryColor: maincolor,
                                          description:
                                              const Text("Password not match"),
                                        ).show(context);
                                      } else {
                                        provider.changepassword(
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                        color: maincolor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Change Password",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
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
            });
          },
        );
        // AppEnvironment.navigator.push(
        //   PageRouteBuilder(
        //     opaque: false,
        //     pageBuilder: (_, __, ___) => const PrivacyPolicyScreen(),
        //   ),
        // );
        break;

      case DrawerItemType.LOG_OUT:
        profileProvider.douserlogout(context: context);
        // AppEnvironment.navigator.push(
        //   PageRouteBuilder(
        //     opaque: false,
        //     pageBuilder: (_, __, ___) => const FaqScreen(),
        //   ),
        // );
        break;
      default:
    }
  }
}

class EchoBackdropFilterWidget extends StatefulWidget {
  const EchoBackdropFilterWidget(
      {super.key, required this.child, this.alignment});

  final Widget child;
  final Alignment? alignment;

  @override
  State<EchoBackdropFilterWidget> createState() =>
      _EchoBackdropFilterWidgetState();
}

class _EchoBackdropFilterWidgetState extends State<EchoBackdropFilterWidget> {
  double _drawerWidth = 0;
  double _drawerHeight = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _drawerWidth = context.size!.width;
      }),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _drawerHeight = context.size!.height;
      }),
    );
    return Stack(
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              alignment: widget.alignment,
              width: _drawerWidth,
              height: _drawerHeight,
            ),
          ),
        ),
        widget.child
      ],
    );
  }
}

final drawerItems = <DrawerItem>[
  // const DrawerItem(
  //   icon: "assets/images/jobdetail.svg",
  //   text: 'Job Details',
  //   type: DrawerItemType.JOB_DETAIL,
  // ),
  const DrawerItem(
    icon: "assets/images/myprofile.svg",
    text: 'My Profile',
    type: DrawerItemType.MY_PROFILE,
  ),
  const DrawerItem(
    icon: "assets/images/myinvoice.svg",
    text: 'Invoice',
    type: DrawerItemType.INVOICE,
  ),
  const DrawerItem(
    icon: "assets/images/change.svg",
    text: 'Change Password',
    type: DrawerItemType.CHANGE_PASSWORD,
  ),
  const DrawerItem(
    icon: "assets/images/logout.svg",
    text: 'Logout',
    type: DrawerItemType.LOG_OUT,
  ),
];

class DrawerItem {
  final String icon;
  final String text;
  final String? subtext;
  final DrawerItemType type;

  const DrawerItem({
    required this.icon,
    this.subtext,
    required this.text,
    required this.type,
  });
}

enum DrawerItemType {
  JOB_DETAIL,
  MY_PROFILE,
  INVOICE,
  CHANGE_PASSWORD,
  ADD_DRIVER,
  DRIVER_LIST,
  LOG_OUT,
}
