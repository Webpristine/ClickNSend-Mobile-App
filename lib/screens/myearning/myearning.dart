import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/job/jobstatics.dart';
import 'package:click_send/screens/myearning/transactionhistory.dart';
import 'package:click_send/screens/trip/tripdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyEarningScreen extends StatefulWidget {
  const MyEarningScreen({super.key});

  @override
  State<MyEarningScreen> createState() => _MyEarningScreenState();
}

class _MyEarningScreenState extends State<MyEarningScreen> {
  final List<ChartData> chartData = <ChartData>[
    ChartData(2010, 21, Color(0xff)),
    ChartData(2011, 24, Color(0xff)),
    ChartData(2012, 35, Color(0xff)),
    ChartData(2013, 38, Color(0xff)),
    ChartData(2014, 54, Color(0xff)),
    ChartData(2015, 21, Color(0xff)),
    ChartData(2016, 24, Color(0xff)),
    ChartData(2017, 35, Color(0xff)),
    ChartData(2018, 38, Color(0xff)),
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
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          "My Earnings",
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
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(11)),
            child: Column(
              children: [
                Container(
                  height: 250.h,
                  child: SfCartesianChart(
                      enableSideBySideSeriesPlacement: false,
                      enableAxisAnimation: false,
                      primaryYAxis: CategoryAxis(
                        isVisible: false,
                      ),
                      primaryXAxis: CategoryAxis(
                          labelStyle: GoogleFonts.inter(
                        color: Color(0xff454459),
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w500,
                      )),
                      series: <ChartSeries>[
                        SplineSeries<ChartData, int>(
                            dataSource: chartData,
                            // Type of spline
                            splineType: SplineType.clamped,
                            enableTooltip: false,
                            cardinalSplineTension: 0.9,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y)
                      ]),
                ),
                Text(
                  "Today",
                  style: GoogleFonts.inter(
                    color: const Color(0xff8F9BB3),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "￡249.21",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 37.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Divider(
                    color: Color(0xffEEEEEE),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.back_hand_outlined,
                            color: maincolor,
                            size: 18.sp,
                          ),
                          Text(
                            "  14 Jobs",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: maincolor,
                            size: 18.sp,
                          ),
                          Text(
                            "  23h 45m",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wallet Balance",
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff8F9BB3),
                          ),
                        ),
                        Text(
                          "￡1,289",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFBEDD3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(children: [
                        Text(
                          "Withdraw",
                          style: GoogleFonts.inter(
                            color: maincolor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: maincolor,
                          size: 15.h,
                        )
                      ]),
                    )
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                  child: const Divider(
                    color: Color(0xffEEEEEE),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      (MaterialPageRoute(
                        builder: (context) => TransactionScreen(),
                      )),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15.sp,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
