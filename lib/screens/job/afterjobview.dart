import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/calendar/calendar.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:click_send/screens/job/jobdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:timelines/timelines.dart';

class AfterJobView extends StatefulWidget {
  const AfterJobView({super.key});

  @override
  State<AfterJobView> createState() => _AfterJobViewState();
}

class _AfterJobViewState extends State<AfterJobView> {
  TextEditingController customernotecontroller = TextEditingController();
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
    // const data = TimelineStatus.values;

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
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "Job Title",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 88.h,
                  width: 99.w,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://rukminim2.flixcart.com/image/612/612/xif0q/shoe/c/e/5/-original-imagg7t2qvzg6jjy.jpeg?q=70",
                        )),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // child: FittedBox(
                  //   fit: BoxFit.fill,
                  //   child: const AppImage(
                  //     "https://rukminim2.flixcart.com/image/612/612/xif0q/shoe/c/e/5/-original-imagg7t2qvzg6jjy.jpeg?q=70",
                  //   ),
                  // ),
                ),
                SizedBox(
                  width: 20.h,
                ),
                Container(
                  height: 88.h,
                  width: 99.w,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://rukminim2.flixcart.com/image/612/612/xif0q/shoe/c/e/5/-original-imagg7t2qvzg6jjy.jpeg?q=70",
                        )),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // child: FittedBox(
                  //   fit: BoxFit.fill,
                  //   child: const AppImage(
                  //     "https://rukminim2.flixcart.com/image/612/612/xif0q/shoe/c/e/5/-original-imagg7t2qvzg6jjy.jpeg?q=70",
                  //   ),
                  // ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Gourmet Box",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 19.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/type_icon.svg",
                      color: maincolor,
                      height: 14.h,
                      width: 14.w,
                    ),
                    Text(
                      "  Liquid",
                      style: GoogleFonts.inter(
                        color: const Color(0xff8F9BB3),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
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
                      "assets/images/type_icon.svg",
                      color: maincolor,
                      height: 14.h,
                      width: 14.w,
                    ),
                    Text(
                      "  10x10x10",
                      style: GoogleFonts.inter(
                        color: const Color(0xff8F9BB3),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
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
                      color: maincolor,
                      height: 14.h,
                      width: 14.w,
                    ),
                    Text(
                      "  4kg",
                      style: GoogleFonts.inter(
                        color: const Color(0xff8F9BB3),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: const Divider(),
            ),
            Timeline.tileBuilder(
              shrinkWrap: true,
              theme: TimelineThemeData(
                nodePosition: 0,
                connectorTheme: const ConnectorThemeData(
                  thickness: 3.0,
                  space: 0,
                  color: Color(0xffd3d3d3),
                ),
                indicatorTheme: const IndicatorThemeData(
                  size: 25.0,
                ),
              ),
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              builder: TimelineTileBuilder.connected(
                  contentsBuilder: (_, index) {
                    if (index == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "  10 Street London",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 5.h,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Distance",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff8F9BB3),
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "150km",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xff5D5D5D),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (index == 1 || index == 2) {
                      return Row(
                        children: [
                          Text(
                            "location 1",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Pickup",
                            style: GoogleFonts.inter(
                              color: maincolor,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      );
                    }
                    return Text(
                      "  Small Heath, Birmingham",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                  connectorBuilder: (_, index, __) {
                    if (index == 0) {
                      return const DashedLineConnector(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1.2,
                        space: 2,
                        dash: 4,
                        gap: 3,
                      );
                    } else {
                      return const DashedLineConnector(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1.2,
                        space: 2,
                        dash: 4,
                        gap: 3,
                      );
                    }
                  },
                  // indicatorBuilder: (_, index) {
                  //   switch (data[index]) {
                  //     case TimelineStatus.done:
                  //       return DotIndicator(
                  //           color: maincolor,
                  //           child: Container(
                  //             padding: EdgeInsets.zero,
                  //             decoration: const BoxDecoration(
                  //                 color: Colors.white,
                  //                 image: DecorationImage(
                  //                     image: AssetImage(
                  //                         "assets/images/rectangle.png"))),
                  //             child: Icon(
                  //               Icons.star,
                  //               color: Colors.white,
                  //               size: 8.sp,
                  //             ),
                  //           ));
                  //     case TimelineStatus.sync:
                  //       return DotIndicator(
                  //         color: maincolor,
                  //         size: 9.sp,
                  //       );

                  //     case TimelineStatus.inProgress:
                  //       return DotIndicator(
                  //         color: maincolor,
                  //         size: 9.sp,
                  //       );
                  //     case TimelineStatus.todo:
                  //     default:
                  //       return DotIndicator(
                  //           color: const Color(0xff5D5D5D),
                  //           child: Container(
                  //             padding: EdgeInsets.zero,
                  //             decoration: const BoxDecoration(
                  //                 color: Colors.white,
                  //                 image: DecorationImage(
                  //                     colorFilter: ColorFilter.mode(
                  //                         Color(0xff5D5D5D),
                  //                         BlendMode.saturation),
                  //                     image: AssetImage(
                  //                         "assets/images/rectangle.png"))),
                  //             child: Icon(
                  //               Icons.star,
                  //               color: Colors.white,
                  //               size: 9.sp,
                  //             ),
                  //           ));
                  //   }
                  // },
                  itemExtentBuilder: (_, __) => kTileHeight,
                  itemCount: 20
                  // data.length,
                  ),
              physics: const NeverScrollableScrollPhysics(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: const Divider(),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getdatetimewidget(
                      content: "26 July, 2023",
                      icon: Icons.calendar_today,
                      title: "Pick up Date"),
                  getdatetimewidget(
                      content: "26 July, 2023",
                      icon: Icons.calendar_today,
                      title: "Drop out Date")
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getdatetimewidget(
                      content: "10:00 PM",
                      icon: Icons.access_time_outlined,
                      title: "Pick up Time"),
                  Padding(
                    padding: EdgeInsets.only(right: 28.w),
                    child: getdatetimewidget(
                        content: "10:00 PM",
                        icon: Icons.access_time_outlined,
                        title: "Drop out Time"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: const Divider(),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Note from customer",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ) +
                          EdgeInsets.only(right: 40.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF5F5F5),
                      ),
                      child: Text(
                        "A dummy note from customer.",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Note to customer",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: TextFormField(
                controller: customernotecontroller,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: "Write something here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: Color(0xffDADADA),
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: Color(0xffDADADA),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: Color(0xffDADADA),
                        )),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: Color(0xffDADADA),
                        )),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: Color(0xffDADADA),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: Color(0xffDADADA),
                        )),
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xffDEDEDE),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                if (customernotecontroller.text.isEmpty) {
                  return MotionToast(
                    icon: Icons.error,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 60.h,
                    primaryColor: maincolor,
                    description: const Text("Please Add Description"),
                  ).show(context);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                }
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
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
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
