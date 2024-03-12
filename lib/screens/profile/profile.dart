// import 'dart:io';
// import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:click_send/common/app_colors.dart';
// import 'package:click_send/main.dart';
// import 'package:click_send/screens/chat/emptymessage.dart';
// import 'package:click_send/screens/delivery/takeimagedrop.dart';
// import 'package:click_send/screens/notification/notifications.dart';
// import 'package:click_send/screens/profile/logic/profileprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:motion_toast/motion_toast.dart';
// import 'package:overlay_loading_progress/overlay_loading_progress.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   File? selectedimage;
//   bool ispasswordvisible = false;
//   bool iscpasswordvisible = false;

//   // void changepasswordvisiblity() {
//   //   setState(() {
//   //     ispasswordvisible = !ispasswordvisible;
//   //   });
//   // }

//   void changecpasswordvisiblity() {
//     setState(() {
//       iscpasswordvisible = !iscpasswordvisible;
//     });
//   }

//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       context.read<ProfileProvider>().getuserprofile(context: context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 43.w,
//         leading: Padding(
//           padding: EdgeInsets.only(
//             left: 24.w,
//             top: 13.h,
//           ),
//           child: badges.Badge(
//             badgeStyle: badges.BadgeStyle(
//               badgeColor: maincolor,
//             ),
//             badgeContent: Text(
//               '0',
//               style: GoogleFonts.inter(
//                 color: Colors.white,
//                 fontSize: 8.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const NotificationScreen(),
//                     ),
//                   );
//                 },
//                 child: const Icon(Icons.notifications_none)),
//           ),
//         ),
//         title: Text(
//           "Profile",
//           style: GoogleFonts.inter(
//             color: Colors.black,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         actions: const [
//           IconButton(
//               onPressed: null,
//               icon: Icon(
//                 Icons.menu,
//                 color: Colors.black,
//               ))
//         ],
//       ),
//       body: Consumer<ProfileProvider>(builder: (
//         context,
//         provider,
//         child,
//       ) {
//         if (provider.isloading) {
//           SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//             OverlayLoadingProgress.start(
//               context,
//               color: maincolor,
//             );
//           });
//         } else if (provider.iserror) {
//           OverlayLoadingProgress.stop();
//         } else if (provider.user != null) {
//           OverlayLoadingProgress.stop();
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: maincolor,
//                     image: const DecorationImage(
//                       fit: BoxFit.fill,
//                       image: AssetImage("assets/images/backfground.png"),
//                     ),
//                   ),
//                   height: 140.h,
//                   width: double.infinity,
//                   child: Transform.translate(
//                     offset: Offset(0, 60.h),
//                     child: InkWell(
//                       onTap: () {
//                         provider.changeselectedImage(context: context);
//                       },
//                       child: preferences!.getString("usertype") == "company"
//                           ? Container(
//                               margin: EdgeInsets.all(15.r),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 image: DecorationImage(
//                                     image: provider.user!.viewData!.profile!
//                                                 .companylogo !=
//                                             null
//                                         ? CachedNetworkImageProvider(provider
//                                                 .user!
//                                                 .viewData!
//                                                 .profile!
//                                                 .baseUrl! +
//                                             provider.user!.viewData!.profile!
//                                                 .companylogo!)
//                                         : const NetworkImage(
//                                                 "https://ashisheditz.com/wp-content/uploads/2023/09/new-cute-WhatsApp-DP-2.jpg")
//                                             as ImageProvider,
//                                     fit: BoxFit.cover),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Colors.grey,
//                                       spreadRadius: 0,
//                                       blurRadius: 4,
//                                       offset: Offset(0, 1))
//                                 ],
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Transform.translate(
//                                 offset: Offset(
//                                   40.w,
//                                   35.h,
//                                 ),
//                                 child: Container(
//                                   margin: EdgeInsets.all(40.r),
//                                   padding: EdgeInsets.all(3.r),
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                   ),
//                                   child: Container(
//                                     padding: EdgeInsets.all(1.r),
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.black,
//                                     ),
//                                     child: Icon(
//                                       Icons.camera_alt,
//                                       size: 15.sp,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               margin: EdgeInsets.all(15.r),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 image: DecorationImage(
//                                     image: provider.user!.viewData!.profile!
//                                                 .profileImg !=
//                                             null
//                                         ? CachedNetworkImageProvider(provider
//                                                 .user!
//                                                 .viewData!
//                                                 .profile!
//                                                 .baseUrl! +
//                                             provider.user!.viewData!.profile!
//                                                 .profileImg!)
//                                         : const NetworkImage(
//                                                 "https://ashisheditz.com/wp-content/uploads/2023/09/new-cute-WhatsApp-DP-2.jpg")
//                                             as ImageProvider,
//                                     fit: BoxFit.cover),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Colors.grey,
//                                       spreadRadius: 0,
//                                       blurRadius: 4,
//                                       offset: Offset(0, 1))
//                                 ],
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Transform.translate(
//                                 offset: Offset(
//                                   40.w,
//                                   35.h,
//                                 ),
//                                 child: Container(
//                                   margin: EdgeInsets.all(40.r),
//                                   padding: EdgeInsets.all(3.r),
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                   ),
//                                   child: Container(
//                                     padding: EdgeInsets.all(1.r),
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.black,
//                                     ),
//                                     child: Icon(
//                                       Icons.camera_alt,
//                                       size: 15.sp,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 60.h,
//                 ),
//                 Text(
//                   provider.nameController.text,
//                   style: GoogleFonts.inter(
//                     color: const Color(0xff404040),
//                     fontSize: 25.sp,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                         horizontal: 20.w,
//                       ) +
//                       EdgeInsets.only(
//                         top: 30.h,
//                       ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             height: 35.h,
//                             width: 35.w,
//                             decoration: const BoxDecoration(
//                                 color: Color(0xffFFEBE2),
//                                 shape: BoxShape.circle),
//                             child: SvgPicture.asset(
//                               "assets/images/video.svg",
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20.w,
//                           ),
//                           Text(
//                             provider.plancontroller.text,
//                             style: GoogleFonts.inter(
//                               color: Colors.black,
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       const Divider(
//                         color: Color(0xffEEEEEE),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             height: 35.h,
//                             width: 35.w,
//                             decoration: const BoxDecoration(
//                                 color: Color(0xffFFEBE2),
//                                 shape: BoxShape.circle),
//                             child: SvgPicture.asset("assets/images/mail.svg"),
//                           ),
//                           SizedBox(
//                             width: 20.w,
//                           ),
//                           Text(
//                             provider.emailcontroller.text,
//                             style: GoogleFonts.inter(
//                                 color: Colors.black,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       const Divider(
//                         color: Color(0xffEEEEEE),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             height: 35.h,
//                             width: 35.w,
//                             decoration: const BoxDecoration(
//                                 color: Color(0xffFFEBE2),
//                                 shape: BoxShape.circle),
//                             child: SvgPicture.asset("assets/images/phone.svg"),
//                           ),
//                           SizedBox(
//                             width: 20.w,
//                           ),
//                           Text(
//                             provider.mobileController.text,
//                             style: GoogleFonts.inter(
//                                 color: Colors.black,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       const Divider(
//                         color: Color(0xffEEEEEE),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           showModalBottomSheet(
//                             isScrollControlled: true,
//                             context: context,
//                             backgroundColor: Colors.white,
//                             builder: (BuildContext context) {
//                               return SingleChildScrollView(
//                                 child: BackdropFilter(
//                                   filter:
//                                       ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                                   child: Container(
//                                       decoration: const BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(20),
//                                               topRight: Radius.circular(20))),
//                                       // You can customize the content of your bottom sheet here
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: 20.h,
//                                           ),
//                                           Align(
//                                             alignment: Alignment.topRight,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 margin: EdgeInsets.symmetric(
//                                                     horizontal: 12.w),
//                                                 decoration: const BoxDecoration(
//                                                     color: Color(0xffE5E5E5),
//                                                     shape: BoxShape.circle),
//                                                 child: const Icon(
//                                                   Icons.close,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 16.w),
//                                             child: Text(
//                                               "Edit Profile",
//                                               style: GoogleFonts.inter(
//                                                 fontSize: 25.sp,
//                                                 fontWeight: FontWeight.w700,
//                                                 color: const Color(
//                                                   0xff404040,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           // Padding(
//                                           //   padding: EdgeInsets.symmetric(
//                                           //       horizontal: 16.w),
//                                           //   child: Column(
//                                           //     crossAxisAlignment:
//                                           //         CrossAxisAlignment.start,
//                                           //     children: [
//                                           //       SizedBox(
//                                           //         height: 30.h,
//                                           //       ),
//                                           //       Text(
//                                           //         "Email",
//                                           //         style: GoogleFonts.inter(
//                                           //             color: Colors.black,
//                                           //             fontSize: 12.sp,
//                                           //             fontWeight:
//                                           //                 FontWeight.w600),
//                                           //       ),
//                                           //       SizedBox(
//                                           //         height: 10.h,
//                                           //       ),
//                                           //       TextFormField(
//                                           //         decoration: InputDecoration(
//                                           //           isDense: true,
//                                           //           hintText:
//                                           //               "name@clickandsend.com",
//                                           //           hintStyle:
//                                           //               GoogleFonts.montserrat(
//                                           //             color:
//                                           //                 const Color(0xff828282),
//                                           //             fontSize: 12.sp,
//                                           //             fontWeight: FontWeight.w400,
//                                           //           ),
//                                           //           border: OutlineInputBorder(
//                                           //               borderSide:
//                                           //                   const BorderSide(
//                                           //                       color: Color(
//                                           //                           0xffE0E0E0)),
//                                           //               borderRadius:
//                                           //                   BorderRadius.circular(
//                                           //                 4.sp,
//                                           //               )),
//                                           //           errorBorder:
//                                           //               OutlineInputBorder(
//                                           //                   borderSide:
//                                           //                       const BorderSide(
//                                           //                           color: Color(
//                                           //                               0xffE0E0E0)),
//                                           //                   borderRadius:
//                                           //                       BorderRadius
//                                           //                           .circular(
//                                           //                     4.sp,
//                                           //                   )),
//                                           //           focusedBorder:
//                                           //               OutlineInputBorder(
//                                           //                   borderSide:
//                                           //                       const BorderSide(
//                                           //                           color: Color(
//                                           //                               0xffE0E0E0)),
//                                           //                   borderRadius:
//                                           //                       BorderRadius
//                                           //                           .circular(
//                                           //                     4.sp,
//                                           //                   )),
//                                           //           disabledBorder:
//                                           //               OutlineInputBorder(
//                                           //                   borderSide:
//                                           //                       const BorderSide(
//                                           //                           color: Color(
//                                           //                               0xffE0E0E0)),
//                                           //                   borderRadius:
//                                           //                       BorderRadius
//                                           //                           .circular(
//                                           //                     4.sp,
//                                           //                   )),
//                                           //           enabledBorder:
//                                           //               OutlineInputBorder(
//                                           //                   borderSide:
//                                           //                       const BorderSide(
//                                           //                           color: Color(
//                                           //                               0xffE0E0E0)),
//                                           //                   borderRadius:
//                                           //                       BorderRadius
//                                           //                           .circular(
//                                           //                     4.sp,
//                                           //                   )),
//                                           //           focusedErrorBorder:
//                                           //               OutlineInputBorder(
//                                           //             borderSide:
//                                           //                 const BorderSide(
//                                           //                     color: Color(
//                                           //                         0xffE0E0E0)),
//                                           //             borderRadius:
//                                           //                 BorderRadius.circular(
//                                           //               4.sp,
//                                           //             ),
//                                           //           ),
//                                           //         ),
//                                           //       )
//                                           //     ],
//                                           //   ),
//                                           // ),
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 16.w),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 20.h,
//                                                 ),
//                                                 Text(
//                                                   "User Name",
//                                                   style: GoogleFonts.inter(
//                                                       color: Colors.black,
//                                                       fontSize: 12.sp,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10.h,
//                                                 ),
//                                                 TextFormField(
//                                                   controller: provider.username,
//                                                   style: GoogleFonts.montserrat(
//                                                     color:
//                                                         const Color(0xff828282),
//                                                     fontSize: 12.sp,
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                   decoration: InputDecoration(
//                                                     isDense: true,
//                                                     hintText: "John Doe",
//                                                     hintStyle:
//                                                         GoogleFonts.montserrat(
//                                                       color: const Color(
//                                                           0xff828282),
//                                                       fontSize: 12.sp,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                     border: OutlineInputBorder(
//                                                         borderSide:
//                                                             const BorderSide(
//                                                                 color: Color(
//                                                                     0xffE0E0E0)),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           4.sp,
//                                                         )),
//                                                     errorBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 const BorderSide(
//                                                                     color: Color(
//                                                                         0xffE0E0E0)),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               4.sp,
//                                                             )),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 const BorderSide(
//                                                                     color: Color(
//                                                                         0xffE0E0E0)),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               4.sp,
//                                                             )),
//                                                     disabledBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 const BorderSide(
//                                                                     color: Color(
//                                                                         0xffE0E0E0)),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               4.sp,
//                                                             )),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 const BorderSide(
//                                                                     color: Color(
//                                                                         0xffE0E0E0)),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               4.sp,
//                                                             )),
//                                                     focusedErrorBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide:
//                                                           const BorderSide(
//                                                               color: Color(
//                                                                   0xffE0E0E0)),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                         4.sp,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 40.h,
//                                                 ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     if (provider.username.text
//                                                         .isEmpty) {
//                                                       MotionToast(
//                                                         icon: Icons.error,
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(10),
//                                                         width: double.infinity,
//                                                         height: 60.h,
//                                                         primaryColor: maincolor,
//                                                         description: const Text(
//                                                             "Enter username"),
//                                                       ).show(context);
//                                                     } else {
//                                                       provider.updateprofile(
//                                                           context: context);
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     width: double.infinity,
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                       vertical: 16.h,
//                                                     ),
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                         6,
//                                                       ),
//                                                       color: maincolor,
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         "Update Profile",
//                                                         style:
//                                                             GoogleFonts.inter(
//                                                           color: Colors.white,
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 70.h,
//                                           )
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.symmetric(
//                             vertical: 16.h,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                               6,
//                             ),
//                             color: maincolor,
//                           ),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset("assets/images/eidt.svg"),
//                                 SizedBox(
//                                   width: 10.w,
//                                 ),
//                                 Text(
//                                   "Edit Profile",
//                                   style: GoogleFonts.inter(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.symmetric(
//                             vertical: 16.h,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6),
//                             color: Colors.white,
//                             border: Border.all(
//                               color: maincolor,
//                               width: 2.w,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Change Password",
//                               style: GoogleFonts.inter(
//                                 color: maincolor,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           provider.douserlogout(context: context);
//                         },
//                         child: Center(
//                           child: Text(
//                             "Logout",
//                             style: GoogleFonts.inter(
//                               color: maincolor,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 40.h,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         }
//         return const Text("data");
//       }),
//     );
//   }
// }
