import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/calendar/logic/calendarprovider.dart';
import 'package:click_send/screens/chat/openmessage.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:click_send/screens/home/logic/homeprovider.dart';
import 'package:click_send/screens/job/afterjobview.dart';
import 'package:click_send/screens/trip/tripdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // List<Products> allproducts = [
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  //   Products(
  //     bids: "500",
  //     image:
  //         "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
  //     name: "Vegetable Box",
  //     remaining: "5 Days Remaining",
  //     status: "Completed",
  //   ),
  // ];
  String seletecteddate = "";
  @override
  void initState() {
    context
        .read<HomeProvider>()
        .fetchuserlocation(from: "calendar", context: context);
    changedate(date: DateTime.now().toIso8601String());
    super.initState();
  }

  void changedate({
    required String date,
  }) {
    String inputDatetimeString = date;

    // Convert string to DateTime object
    DateTime inputDatetime = DateTime.parse(inputDatetimeString);

    // Format the DateTime object as required
    String formattedDatetime =
        DateFormat('EEEE, MMM yyyy').format(inputDatetime);
    setState(() {
      seletecteddate = formattedDatetime;
    });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(
            "Calendar",
            style: GoogleFonts.inter(
                color: const Color(0xff222B45),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _handlerDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            )
          ],
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.37),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Theme(
                  data: ThemeData(
                      textTheme: TextTheme(
                    subtitle1: GoogleFonts.inter(
                      color: const Color(0xff8F9BB3),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2324),
                    onDateChanged: (date) {
                      changedate(date: date.toIso8601String());
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(date);

                      context
                          .read<CalendarProvider>()
                          .getjobsByDate(context: context, date: formattedDate);
                    },
                  ),
                ),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Consumer<CalendarProvider>(
                  builder: (context, controller, child) {
                if (controller.isloading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: maincolor,
                  ));
                }
                if (controller.jobHistory == null) {
                  return Center(
                    child: Text(
                      "No Jobs Found",
                      style: GoogleFonts.inter(
                        color: const Color(0xff8F9BB3),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                } else if (controller.jobHistory != null) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            height: 15.h,
                            width: 15.w,
                            padding: EdgeInsets.all(
                              4.r,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: maincolor),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            seletecteddate,
                            style: GoogleFonts.inter(
                              color: const Color(0xff8F9BB3),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TripDetailScreen(
                                      tripid: controller
                                          .jobHistory!.viewData!.data!
                                          .elementAt(index)
                                          .id
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      AppImage(
                                        controller.jobHistory!.viewData!.data!
                                                .elementAt(index)
                                                .items!
                                                .first
                                                .product!
                                                .baseUrl! +
                                            controller
                                                .jobHistory!.viewData!.data!
                                                .elementAt(index)
                                                .items!
                                                .first
                                                .product!
                                                .image!,
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
                                                        controller.jobHistory!
                                                            .viewData!.data!
                                                            .elementAt(index)
                                                            .name!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                                size: 10.h,
                                                              ),
                                                              Text(
                                                                controller
                                                                        .jobHistory!
                                                                        .viewData!
                                                                        .data!
                                                                        .elementAt(
                                                                            index)
                                                                        .items!
                                                                        .isNotEmpty
                                                                    ? "  ${controller.jobHistory!.viewData!.data!.elementAt(index).items!.first.product!.material}"
                                                                    : "",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  color: const Color(
                                                                      0xff8F9BB3),
                                                                  fontSize:
                                                                      8.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 15.w,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/exapnd.svg",
                                                                color:
                                                                    maincolor,
                                                                height: 10.h,
                                                                width: 13.w,
                                                              ),
                                                              Text(
                                                                controller
                                                                        .jobHistory!
                                                                        .viewData!
                                                                        .data!
                                                                        .elementAt(
                                                                            index)
                                                                        .items!
                                                                        .isNotEmpty
                                                                    ? "  ${controller.jobHistory!.viewData!.data!.elementAt(index).items!.first.product!.length}x${controller.jobHistory!.viewData!.data!.elementAt(index).items!.first.product!.width}x${controller.jobHistory!.viewData!.data!.elementAt(index).items!.first.product!.height}"
                                                                    : "",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  color: const Color(
                                                                      0xff8F9BB3),
                                                                  fontSize:
                                                                      8.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 15.w,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/quantity.svg",
                                                                color:
                                                                    maincolor,
                                                                height: 10.h,
                                                                width: 13.w,
                                                              ),
                                                              Text(
                                                                controller
                                                                        .jobHistory!
                                                                        .viewData!
                                                                        .data!
                                                                        .elementAt(
                                                                            index)
                                                                        .items!
                                                                        .isNotEmpty
                                                                    ? "  ${controller.jobHistory!.viewData!.data!.elementAt(index).items!.first.product!.quantity} Qty"
                                                                    : "",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  color: const Color(
                                                                      0xff8F9BB3),
                                                                  fontSize:
                                                                      8.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 60.w,
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
                                                status: controller
                                                    .jobHistory!.viewData!.data!
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
                              controller.jobHistory!.viewData!.data!.length,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getstauts({required String status}) {
  if (status == "5") {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffD8F2D0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        "Cancelled".toString(),
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff71BD5E),
        ),
      ),
    );
  } else if (status == "4") {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffD8F2D0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        "Completed".toString(),
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff71BD5E),
        ),
      ),
    );
  } else if (status == "3") {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffD8F2D0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        "Started".toString(),
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff71BD5E),
        ),
      ),
    );
  } else if (status == "2") {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFBEDD3),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        "Confirmed".toString(),
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffFF7A00),
        ),
      ),
    );
  } else if (status == "1") {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFFE1E1),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        "Accepted".toString(),
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffFF0000),
        ),
      ),
    );
  } else if (status == "0") {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFFE1E1),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        "Pending".toString(),
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffFF0000),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 5.w,
      vertical: 2.5.h,
    ),
    decoration: BoxDecoration(
      color: const Color(0xffD8F2D0),
      borderRadius: BorderRadius.circular(17),
    ),
    child: Text(
      "Completed".toString(),
      style: GoogleFonts.inter(
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff71BD5E),
      ),
    ),
  );
}
