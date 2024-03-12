import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/calendar/calendar.dart';
import 'package:click_send/screens/chat/emptymessage.dart';
import 'package:click_send/screens/delivery/takingimage.dart';
import 'package:click_send/screens/home/logic/homeprovider.dart';
import 'package:click_send/screens/job/afterjobview.dart';
import 'package:click_send/screens/job/jobdetail.dart';
import 'package:click_send/screens/notification/logic/notificationprovider.dart';
import 'package:click_send/screens/notification/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  const HomeScreen({
    super.key,
    this.parentScaffoldKey,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NotificationProvider>().getnotifications(context: context);
      callapi();
    });
    super.initState();
  }

  void callapi() {
    context
        .read<HomeProvider>()
        .fetchuserlocation(from: "home", context: context);
    if (preferences!.getString("usertype") == "driver") {
      context.read<HomeProvider>().getdrivercounts(context: context);
    } else {
      context.read<HomeProvider>().getcounts(context: context);
      context.read<HomeProvider>().getdrivers(context: context);
    }
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
      appBar: AppBar(
        leadingWidth: 43.w,
        leading: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              top: 13.h,
            ),
            child: badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: maincolor),
              badgeContent: Text(
                0.toString() ?? '0',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.notifications_none)),
            )),
        title: Text(
          "Homepage",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _handlerDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        if (provider.isloading) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            OverlayLoadingProgress.start(context,
                color: maincolor, barrierColor: Colors.white);
          });
        } else if (provider.iserror) {
          OverlayLoadingProgress.stop();
        } else if (provider.isloading == false && provider.alljobs != null) {
          OverlayLoadingProgress.stop();

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(
                16.0.r,
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: maincolor,
                                  spreadRadius: -10,
                                  blurRadius: 24,
                                  offset: const Offset(
                                    0,
                                    18,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffFF7A00),
                                  Color(0xffFFBF86),
                                ],
                                begin: Alignment.topLeft,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                  vertical: 25.h,
                                ) +
                                EdgeInsets.only(left: 15.w, right: 35.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  preferences!.getString("usertype") ==
                                          "company"
                                      ? provider.totalCounts!.viewData.drivers
                                          .toString()
                                      : provider.totalCounts?.viewData.jobs
                                              .toString() ??
                                          "0",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  preferences!.getString("usertype") ==
                                          "company"
                                      ? "Total Drivers"
                                      : "Total Jobs",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: maincolor,
                                  spreadRadius: -10,
                                  blurRadius: 24,
                                  offset: const Offset(
                                    0,
                                    18,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffFF7A00),
                                  Color(0xffFFBF86),
                                ],
                                begin: Alignment.topLeft,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                  vertical: 25.h,
                                ) +
                                EdgeInsets.only(
                                  left: 15.w,
                                  right: 38.w,
                                ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.totalCounts?.viewData.bids
                                          .toString() ??
                                      "0",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Total Bids",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: maincolor,
                                  spreadRadius: -10,
                                  blurRadius: 24,
                                  offset: const Offset(
                                    0,
                                    18,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffFF7A00),
                                  Color(0xffFFBF86),
                                ],
                                begin: Alignment.topLeft,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                  vertical: 30.h,
                                ) +
                                EdgeInsets.only(left: 15.w, right: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${convertToK(double.parse(provider.totalCounts?.viewData.earning.toString() ?? "0"))} ",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Total Earning",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 10.w,
                      //     ),
                      //     Container(
                      //       height: 15.h,
                      //       width: 15.w,
                      //       padding: EdgeInsets.all(
                      //         4.r,
                      //       ),
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle, color: maincolor),
                      //       child: Container(
                      //         decoration: const BoxDecoration(
                      //           color: Colors.white,
                      //           shape: BoxShape.circle,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 5.w,
                      //     ),
                      //     Text(
                      //       "Today",
                      //       style: GoogleFonts.inter(
                      //         color: const Color(0xff8F9BB3),
                      //         fontSize: 12.sp,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: preferences!.getString("usertype") == "company"
                            ? ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            AppImage(
                                              provider.driverList!.viewData!
                                                          .data!
                                                          .elementAt(index)
                                                          .profileImg !=
                                                      null
                                                  ? provider.driverList!
                                                          .viewData!.data!
                                                          .elementAt(index)
                                                          .baseUrl! +
                                                      provider.driverList!
                                                          .viewData!.data!
                                                          .elementAt(index)
                                                          .profileImg!
                                                  : "assets/images/bi_camera.svg",
                                              height: 64.h,
                                              width: 74.w,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .driverList!
                                                                  .viewData!
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .userName!,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .inter(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .phone,
                                                                      color:
                                                                          maincolor,
                                                                      size:
                                                                          10.h,
                                                                    ),
                                                                    Text(
                                                                      provider
                                                                              .driverList!
                                                                              .viewData!
                                                                              .data!
                                                                              .elementAt(index)
                                                                              .mobile!
                                                                              .isNotEmpty
                                                                          ? "  ${provider.driverList!.viewData!.data!.elementAt(index).mobile!}"
                                                                          : "",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: const Color(
                                                                            0xff8F9BB3),
                                                                        fontSize:
                                                                            8.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/images/exapnd.svg",
                                                                      color:
                                                                          maincolor,
                                                                      height:
                                                                          10.h,
                                                                      width:
                                                                          13.w,
                                                                    ),
                                                                    Text(
                                                                      "  " +
                                                                          provider
                                                                              .driverList!
                                                                              .viewData!
                                                                              .data!
                                                                              .elementAt(index)
                                                                              .runningjob!
                                                                              .toString() +
                                                                          " Running",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: const Color(
                                                                            0xff8F9BB3),
                                                                        fontSize:
                                                                            8.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/images/quantity.svg",
                                                                      color:
                                                                          maincolor,
                                                                      height:
                                                                          10.h,
                                                                      width:
                                                                          13.w,
                                                                    ),
                                                                    Text(
                                                                      "  ${provider.driverList!.viewData!.data!.elementAt(index).totaljob!} Completed",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: const Color(
                                                                            0xff8F9BB3),
                                                                        fontSize:
                                                                            8.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                        size: 20.sp,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider()
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                                itemCount: provider
                                        .driverList?.viewData!.data!.length ??
                                    0,
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (provider.jobs!.viewData!.data!
                                              .elementAt(index)
                                              .items ==
                                          null) {
                                        MotionToast(
                                          icon: Icons.error,
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 60.h,
                                          primaryColor: maincolor,
                                          description:
                                              const Text("No Items Found"),
                                        ).show(context);
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TakingImagePickup(
                                              itemid: provider
                                                  .jobs!.viewData!.data!
                                                  .elementAt(index)
                                                  .items!
                                                  .first
                                                  .product!
                                                  .id
                                                  .toString(),
                                              jobid: provider
                                                  .jobs!.viewData!.data!
                                                  .elementAt(index)
                                                  .id
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      }

                                      // Navigator.of(
                                      // context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => TripDetailScreen(
                                      //       tripid: controller
                                      //           .jobHistory!.viewData!.data!
                                      //           .elementAt(index)
                                      //           .id
                                      //           .toString(),
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            AppImage(
                                              provider.alljobs!.viewData!.data!
                                                      .elementAt(index)
                                                      .items!
                                                      .isNotEmpty
                                                  ? provider.alljobs!.viewData!
                                                          .data!
                                                          .elementAt(index)
                                                          .items!
                                                          .first
                                                          .product!
                                                          .baseUrl! +
                                                      provider.alljobs!
                                                          .viewData!.data!
                                                          .elementAt(index)
                                                          .items!
                                                          .first
                                                          .product!
                                                          .image!
                                                  : "assets/images/bi_camera.svg",
                                              height: 64.h,
                                              width: 74.w,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .alljobs!
                                                                  .viewData!
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .name!,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .inter(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .access_time,
                                                                      color:
                                                                          maincolor,
                                                                      size:
                                                                          10.h,
                                                                    ),
                                                                    Text(
                                                                      provider
                                                                              .alljobs!
                                                                              .viewData!
                                                                              .data!
                                                                              .elementAt(index)
                                                                              .items!
                                                                              .isNotEmpty
                                                                          ? "  ${provider.alljobs!.viewData!.data!.elementAt(index).items!.first.product!.material}"
                                                                          : "",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: const Color(
                                                                            0xff8F9BB3),
                                                                        fontSize:
                                                                            8.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/images/exapnd.svg",
                                                                      color:
                                                                          maincolor,
                                                                      height:
                                                                          10.h,
                                                                      width:
                                                                          13.w,
                                                                    ),
                                                                    Text(
                                                                      provider
                                                                              .alljobs!
                                                                              .viewData!
                                                                              .data!
                                                                              .elementAt(index)
                                                                              .items!
                                                                              .isNotEmpty
                                                                          ? "  ${provider.alljobs!.viewData!.data!.elementAt(index).items!.first.product!.length}x${provider.alljobs!.viewData!.data!.elementAt(index).items!.first.product!.width}x${provider.alljobs!.viewData!.data!.elementAt(index).items!.first.product!.height}"
                                                                          : "",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: const Color(
                                                                            0xff8F9BB3),
                                                                        fontSize:
                                                                            8.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/images/quantity.svg",
                                                                      color:
                                                                          maincolor,
                                                                      height:
                                                                          10.h,
                                                                      width:
                                                                          13.w,
                                                                    ),
                                                                    Text(
                                                                      provider
                                                                              .alljobs!
                                                                              .viewData!
                                                                              .data!
                                                                              .elementAt(index)
                                                                              .items!
                                                                              .isNotEmpty
                                                                          ? "  ${provider.alljobs!.viewData!.data!.elementAt(index).items!.first.product!.quantity} Qty"
                                                                          : "",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: const Color(
                                                                            0xff8F9BB3),
                                                                        fontSize:
                                                                            8.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                        size: 20.sp,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  getstauts(
                                                      status: provider.alljobs!
                                                          .viewData!.data!
                                                          .elementAt(index)
                                                          .status
                                                          .toString())
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider()
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                                itemCount:
                                    provider.alljobs?.viewData!.data!.length ??
                                        0,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

String convertToK(double amount) {
  if (amount >= 1000) {
    double kAmount = amount / 1000;
    return '${kAmount.toStringAsFixed(2)}K'; // Format to two decimal places
  } else {
    return amount.toStringAsFixed(
        2); // No need to convert, just format to two decimal places
  }
}

class AllProducts {
  final String date;
  final List<Products> products;
  AllProducts({
    required this.date,
    required this.products,
  });
}

class Products {
  final String image;
  final String name;
  final String bids;
  final String remaining;
  final String status;
  Products({
    required this.bids,
    required this.image,
    required this.name,
    required this.remaining,
    required this.status,
  });
}
