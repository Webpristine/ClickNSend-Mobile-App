import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/job/jobdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

import '../../trip/tripdetail.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  List<AddressTIme> timeline = [
    AddressTIme(
      address: "10 Street London",
      time: "October 24, 2023 | 09:44 AM",
    ),
    AddressTIme(
      address: "Small Heath, Birmingham",
      time: "October 24, 2023 | 09:44 AM",
    )
  ];
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
      backgroundColor: const Color.fromARGB(255, 200, 200, 201),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Nearby Jobs",
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: Colors.white,
            ),
            child: Icon(
              Icons.menu,
              color: maincolor,
            ),
          ),
          SizedBox(
            width: 15.h,
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              gradient: const LinearGradient(
                tileMode: TileMode.clamp,
                begin: Alignment.topCenter,
                colors: [
                  Color(0xffFF7A00),
                  Color(0xffFFA95A),
                ],
              ),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(
                16.r,
              ),
              padding: EdgeInsets.all(
                16.r,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Timeline.tileBuilder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    theme: TimelineThemeData(
                        indicatorTheme:
                            IndicatorThemeData(size: 18.r, color: maincolor),
                        connectorTheme: ConnectorThemeData(
                          color: maincolor,
                        ),
                        indicatorPosition: 0.2,
                        nodePosition: 0),
                    builder: TimelineTileBuilder.connected(
                      indicatorBuilder: (context, index) {
                        if (index == 0) {
                          return DotIndicator(
                              color: maincolor,
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "assets/images/rectangle.png"))),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12.sp,
                                ),
                              ));
                        }
                        return DotIndicator(
                            color: const Color(0xff5D5D5D),
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      colorFilter: const ColorFilter.mode(
                                          Color(0xff5D5D5D),
                                          BlendMode.saturation),
                                      image: AssetImage(
                                          "assets/images/rectangle.png"))),
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                            ));
                      },
                      contentsAlign: ContentsAlign.basic,
                      connectorBuilder: (context, index, type) {
                        return const DashedLineConnector(
                          color: Color(0xffBDBDBD),
                          thickness: 1.2,
                          space: 3,
                          dash: 4,
                          gap: 3,
                        );
                      },
                      contentsBuilder: (context, _index) => Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          bottom: 10.h,
                        ),
                        child: Text(
                          timeline[_index].address,
                          style: GoogleFonts.inter(
                            color: const Color(0xff5D5D5D),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      itemCount: timeline.length,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "L",
                            style: GoogleFonts.inter(
                              color: const Color(0xff979797),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "10’",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        children: [
                          Text(
                            "W",
                            style: GoogleFonts.inter(
                              color: const Color(0xff979797),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "6’",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        children: [
                          Text(
                            "H",
                            style: GoogleFonts.inter(
                              color: const Color(0xff979797),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "10’",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        children: [
                          Text(
                            "W",
                            style: GoogleFonts.inter(
                              color: const Color(0xff979797),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "10KG’",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => JobDetailScreen()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          child: Text(
                            "Apply Now",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff000000)
                                        .withOpacity(0.225),
                                    spreadRadius: 0,
                                    blurRadius: 8,
                                    offset: const Offset(0, 4))
                              ],
                              gradient: const LinearGradient(colors: [
                                Color(0xffFF7A00),
                                Color(0xffFFAC61),
                              ])),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
