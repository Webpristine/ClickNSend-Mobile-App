import 'package:click_send/api/app_repository.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/bids/logic/bidsprovider.dart';
import 'package:click_send/screens/myearning/myearning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as sg;

class BidStaticsScreen extends StatefulWidget {
  const BidStaticsScreen({super.key});

  @override
  State<BidStaticsScreen> createState() => _BidStaticsScreenState();
}

class _BidStaticsScreenState extends State<BidStaticsScreen> {
  @override
  void initState() {
    context.read<BidsProvider>().getbidsStatic(context: context);
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
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              _handlerDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Bids Statistics",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            padding: EdgeInsets.all(
              16.r,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.04),
                    spreadRadius: 0,
                    blurRadius: 26,
                    offset: const Offset(
                      0,
                      8,
                    ))
              ],
              borderRadius: BorderRadius.circular(
                11,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  heightFactor: 0.8,
                  child:
                      sg.SfRadialGauge(enableLoadingAnimation: true, axes: <sg
                          .RadialAxis>[
                    sg.RadialAxis(
                      minimum: 0,
                      maximum: 30,
                      startAngle: -4,
                      canScaleToFit: false,
                      endAngle: 128,
                      showLabels: false,
                      showTicks: false,
                      radiusFactor: 0.6,
                      pointers: const <sg.GaugePointer>[
                        sg.RangePointer(
                          value: 30,
                          cornerStyle: sg.CornerStyle.bothCurve,
                          width: 10,
                          sizeUnit: sg.GaugeSizeUnit.logicalPixel,
                          color: Color(0xffFE9A01),
                        ),
                      ],
                    ),
                    sg.RadialAxis(
                      canScaleToFit: false,
                      minimum: 0,
                      maximum: 30,
                      annotations: <sg.GaugeAnnotation>[
                        sg.GaugeAnnotation(
                            angle: 90,
                            axisValue: 5,
                            positionFactor: 0.2,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: const Color(0xff71BD5E),
                                              width: 2)),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_upward,
                                          color: const Color(0xff71BD5E),
                                          size: 13.h,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text("5.45%",
                                        style: GoogleFonts.inter(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff71BD5E))),
                                  ],
                                ),
                                Text(
                                  "+300",
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 34.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Growth",
                                  style: GoogleFonts.inter(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff8F9BB3)),
                                )
                              ],
                            ))
                      ],
                      startAngle: 123,
                      endAngle: 250,
                      showLabels: false,
                      showTicks: false,
                      radiusFactor: 0.61,
                      pointers: const <sg.GaugePointer>[
                        sg.RangePointer(
                          value: 100,
                          cornerStyle: sg.CornerStyle.bothCurve,
                          width: 15,
                          sizeUnit: sg.GaugeSizeUnit.logicalPixel,
                          color: Color(0xff2777FE),
                        ),
                      ],
                    ),
                    sg.RadialAxis(
                      minimum: 0,
                      maximum: 30,
                      startAngle: 240,
                      canScaleToFit: false,
                      endAngle: 360,
                      showLabels: false,
                      showTicks: false,
                      radiusFactor: 0.63,
                      pointers: const <sg.GaugePointer>[
                        sg.RangePointer(
                          value: 30,
                          cornerStyle: sg.CornerStyle.bothCurve,
                          width: 20,
                          sizeUnit: sg.GaugeSizeUnit.logicalPixel,
                          color: Color(0xff00C291),
                        ),
                      ],
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 2.5.h,
                          ),
                          height: 14.h,
                          width: 14.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFA500),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pending",
                              style: GoogleFonts.inter(
                                color: const Color(0xff8F9BB3),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "50",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 2.5.h,
                          ),
                          height: 14.h,
                          width: 14.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffFF0000),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Denied",
                              style: GoogleFonts.inter(
                                color: const Color(0xff8F9BB3),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "13",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 2.5.h,
                          ),
                          height: 14.h,
                          width: 14.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff00C291),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Won",
                              style: GoogleFonts.inter(
                                color: const Color(0xff8F9BB3),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "25",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.04),
                    spreadRadius: 0,
                    blurRadius: 26,
                    offset: const Offset(
                      0,
                      8,
                    ))
              ],
              borderRadius: BorderRadius.circular(
                11,
              ),
            ),
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            padding: EdgeInsets.all(
              16.r,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyEarningScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffF8F9FD),
                          borderRadius: BorderRadius.circular(
                            12,
                          )),
                      child: Column(
                        children: [
                          Container(
                              height: 150.h,
                              width: 150.w,
                              child: sg.SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  axes: <sg.RadialAxis>[
                                    sg.RadialAxis(
                                      minimum: 0,
                                      maximum: 30,
                                      annotations: <sg.GaugeAnnotation>[
                                        sg.GaugeAnnotation(
                                            angle: 90,
                                            axisValue: 5,
                                            positionFactor: 0.2,
                                            widget: Text(50.ceil().toString(),
                                                style: GoogleFonts.inter(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)))
                                      ],
                                      startAngle: -10,
                                      endAngle: 190,
                                      showLabels: false,
                                      showTicks: false,
                                      radiusFactor: 0.6,
                                      pointers: const <sg.GaugePointer>[
                                        sg.RangePointer(
                                          value: 30,
                                          cornerStyle: sg.CornerStyle.bothFlat,
                                          width: 10,
                                          sizeUnit:
                                              sg.GaugeSizeUnit.logicalPixel,
                                          color: Color(0xffF1F3FA),
                                        ),
                                      ],
                                    ),
                                    sg.RadialAxis(
                                      minimum: 0,
                                      maximum: 30,
                                      startAngle: 180,
                                      endAngle: 360,
                                      showLabels: false,
                                      showTicks: false,
                                      radiusFactor: 0.6,
                                      pointers: const <sg.GaugePointer>[
                                        sg.RangePointer(
                                          value: 30,
                                          cornerStyle: sg.CornerStyle.bothCurve,
                                          width: 10,
                                          sizeUnit:
                                              sg.GaugeSizeUnit.logicalPixel,
                                          color: Color(0xffFE9A01),
                                        ),
                                      ],
                                    ),
                                  ])),
                          SizedBox(
                            height: 0.h,
                          ),
                          Text(
                            "Bids Denied",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F9FD),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 150.h,
                            width: 150.w,
                            child: sg.SfRadialGauge(
                                enableLoadingAnimation: true,
                                axes: <sg.RadialAxis>[
                                  sg.RadialAxis(
                                    annotations: <sg.GaugeAnnotation>[
                                      sg.GaugeAnnotation(
                                          angle: 90,
                                          axisValue: 5,
                                          positionFactor: 0.2,
                                          widget: Text(50.ceil().toString(),
                                              style: GoogleFonts.inter(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)))
                                    ],
                                    minimum: 0,
                                    maximum: 30,
                                    startAngle: -10,
                                    endAngle: 190,
                                    showLabels: false,
                                    showTicks: false,
                                    radiusFactor: 0.6,
                                    pointers: const <sg.GaugePointer>[
                                      sg.RangePointer(
                                        value: 30,
                                        cornerStyle: sg.CornerStyle.bothFlat,
                                        width: 10,
                                        sizeUnit: sg.GaugeSizeUnit.logicalPixel,
                                        color: Color(0xffF1F3FA),
                                      ),
                                    ],
                                  ),
                                  sg.RadialAxis(
                                    minimum: 0,
                                    maximum: 30,
                                    startAngle: 200,
                                    endAngle: 360,
                                    showLabels: false,
                                    showTicks: false,
                                    radiusFactor: 0.6,
                                    pointers: const <sg.GaugePointer>[
                                      sg.RangePointer(
                                        value: 30,
                                        cornerStyle: sg.CornerStyle.bothCurve,
                                        width: 10,
                                        sizeUnit: sg.GaugeSizeUnit.logicalPixel,
                                        color: Color(0xff00C291),
                                      ),
                                    ],
                                  ),
                                ])),
                        Text(
                          "Bids Won",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
