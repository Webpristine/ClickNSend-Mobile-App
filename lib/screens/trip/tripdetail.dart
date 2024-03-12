import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/jobdetail.dart';
import 'package:click_send/screens/calendar/logic/calendarprovider.dart';
import 'package:click_send/screens/job/upcomingjob/listview.dart';
import 'package:click_send/screens/job/upcomingjob/mapview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class TripDetailScreen extends StatefulWidget {
  final String tripid;
  const TripDetailScreen({super.key, required this.tripid});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  Future<void> addmarker({
    required String lat,
    required String long,
  }) async {
    markers.add(
      Marker(
          markerId: const MarkerId('marker_1'),
          draggable: false,
          position: LatLng(
            double.parse(lat),
            double.parse(long),
          ),
          infoWindow: const InfoWindow(
              title: 'Marker Title', snippet: 'Marker Snippet'),
          icon: await markericon),
    );
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<CalendarProvider>()
          .getjobdetail(context: context, jobid: widget.tripid);
    });
    super.initState();
  }

  final markers = <Marker>{};
  late GoogleMapController mapController;
  bool ismapCreated = false;
  String formatDatetime(String datetimeString) {
    // Convert string to DateTime object
    DateTime inputDatetime = DateTime.parse(datetimeString);

    // Format the DateTime object as required
    String formattedDatetime =
        DateFormat('d MMM | hh:mm a').format(inputDatetime);

    return formattedDatetime;
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
      backgroundColor: const Color.fromARGB(255, 205, 203, 203),
      bottomSheet: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child:
            Consumer<CalendarProvider>(builder: (context, controller, child) {
          if (controller.isloading) {
            return Center(
                child: CircularProgressIndicator(
              color: maincolor,
            ));
          } else if (controller.jobDetail != null) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 4.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  controller.jobDetail!.viewData!.job!.name!,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  formatDatetime(
                      controller.jobDetail!.viewData!.job!.createdAt!),
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff858585)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFEE6BB),
                          ),
                          child: const AppImage("assets/images/invoice.svg"),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          controller.jobDetail!.viewData!.job!.id.toString(),
                          style: GoogleFonts.inter(
                            color: const Color(0xff5D5D5D),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFEE6BB),
                          ),
                          child: const AppImage("assets/images/car.svg"),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "${controller.jobDetail!.viewData!.job!.vehicalType} | ${controller.jobDetail!.viewData!.job!.vehicle}",
                          style: GoogleFonts.inter(
                            color: const Color(0xff5D5D5D),
                            fontSize: 13.sp,
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Divider(
                    color: Color(0xffEEEEEE),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 24.w,
                //   ),
                //   child: Timeline.tileBuilder(
                //     shrinkWrap: true,
                //     padding: EdgeInsets.zero,
                //     physics: const NeverScrollableScrollPhysics(),
                //     theme: TimelineThemeData(
                //         indicatorTheme:
                //             IndicatorThemeData(size: 12.r, color: maincolor),
                //         connectorTheme: ConnectorThemeData(color: maincolor),
                //         indicatorPosition: 0.2,
                //         nodePosition: 0),
                //     builder: TimelineTileBuilder.connected(
                //       indicatorBuilder: (context, index) {
                //         return Container(
                //           padding: const EdgeInsets.all(3),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               shape: BoxShape.circle,
                //               border: Border.all(color: maincolor)),
                //           child: Container(
                //             height: 10.h,
                //             width: 10.w,
                //             decoration: BoxDecoration(
                //               color: maincolor,
                //               shape: BoxShape.circle,
                //             ),
                //           ),
                //         );
                //       },
                //       contentsAlign: ContentsAlign.basic,
                //       connectorBuilder: (context, index, type) {
                //         return const DashedLineConnector(
                //           color: Color(0xffBDBDBD),
                //           thickness: 1.2,
                //           space: 2,
                //           dash: 4,
                //           gap: 3,
                //         );
                //       },
                //       contentsBuilder: (context, _index) => Padding(
                //         padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               controller
                //                   .jobDetail!.viewData!.drop!.first.address!,
                //               style: GoogleFonts.inter(
                //                 color: const Color(0xff5D5D5D),
                //                 fontSize: 16.sp,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //             Text(
                //               timeline.elementAt(_index).time,
                //               style: GoogleFonts.inter(
                //                 color: const Color(0xffABABAB),
                //                 fontSize: 12.sp,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //       itemCount: timeline.length,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Divider(
                    color: Color(0xffEEEEEE),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trip Fare",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "￡50",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Includes",
                        style: GoogleFonts.inter(
                          color: const Color(0xffB0B0B0),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total tax",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "￡10",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Commission",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "-￡5",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cash collected",
                            style: GoogleFonts.inter(
                              color: const Color(0xff5D5D5D),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "+￡45",
                            style: GoogleFonts.inter(
                              color: const Color(0xff71BD5E),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Divider(
                        color: Color(0xffEEEEEE),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapViewScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Balance",
                              style: GoogleFonts.inter(
                                color: const Color(0xff5D5D5D),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "￡50",
                              style: GoogleFonts.inter(
                                color: const Color(0xff5D5D5D),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            );
          }
          return const SizedBox();
        }),
      ),
      body: Consumer<CalendarProvider>(builder: (context, controller, child) {
        if (controller.jobDetail != null) {
          for (var i in controller.jobDetail!.viewData!.pickup!) {
            addmarker(lat: i.lat!, long: i.long!);
          }
          for (var i in controller.jobDetail!.viewData!.drop!) {
            addmarker(lat: i.lat!, long: i.long!);
          }

          return GoogleMap(
            buildingsEnabled: false,
            mapType: MapType.terrain,
            markers: markers,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            onMapCreated: (controller) {
              mapController = controller;

              // mapController.moveCamera(
              //   CameraUpdate.newLatLng(
              //     LatLng(value.latitude!, value.longitude!),
              //   ),
              // );

              // mapController.animateCamera(
              //   CameraUpdate.newLatLng(
              //     LatLng(value.latitude!, value.longitude!),
              //   ),
              // );
              setState(() {
                ismapCreated = true;
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(
                    controller.jobDetail!.viewData!.pickup!.first.lat!),
                double.parse(
                    controller.jobDetail!.viewData!.pickup!.first.long!),
              ),
              zoom: 15.0,
            ),
          );
        }
        return const SizedBox();
      }),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          "Trip Details",
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
    );
  }
}

class AddressTIme {
  final String address;
  final String time;
  AddressTIme({
    required this.address,
    required this.time,
  });
}
