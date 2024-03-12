import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/home/logic/homeprovider.dart';
import 'package:click_send/screens/job/jobdetail.dart';
import 'package:click_send/screens/trip/tripdetail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class JobListViewScreen extends StatefulWidget {
  const JobListViewScreen({super.key});

  @override
  State<JobListViewScreen> createState() => _JobListViewScreenState();
}

class _JobListViewScreenState extends State<JobListViewScreen> {
  late GoogleMapController mapController;
  bool ismapCreated = false;

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
  final markers = <Marker>{};

  String jobtype = "list";

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().fetchuserlocation(
            from: "listview",
            context: context,
          );
    });
    super.initState();
  }

  PageController pageController = PageController();

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
        centerTitle: true,
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
      body: jobtype == "list"
          ? Consumer<HomeProvider>(builder: (context, controller, child) {
              if (controller.isloading) {
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  OverlayLoadingProgress.start(
                    context,
                    color: maincolor,
                  );
                });
              } else if (controller.iserror) {
                OverlayLoadingProgress.stop();
              } else if (controller.isloading == false ||
                  controller.jobs != null) {
                OverlayLoadingProgress.stop();

                return RefreshIndicator(
                  onRefresh: () {
                    return controller.getjobs(
                        context: context,
                        latitude: controller.latitude.toString(),
                        longitude: controller.longitude.toString());
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailScreen(
                                data: controller.jobs!.viewData!.data!
                                    .elementAt(index),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            16.r,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xffECECEC))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: AppImage(
                                      controller.jobs!.viewData!.data!
                                              .elementAt(index)
                                              .items!
                                              .isNotEmpty
                                          ? controller.jobs!.viewData!.data!
                                                  .elementAt(index)
                                                  .items!
                                                  .first
                                                  .product!
                                                  .baseUrl! +
                                              controller.jobs!.viewData!.data!
                                                  .elementAt(index)
                                                  .items!
                                                  .first
                                                  .product!
                                                  .image!
                                          : "assets/images/building.svg",
                                      height: 74.h,
                                      width: 74.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.jobs!.viewData!.data!
                                                    .elementAt(index)
                                                    .name!,
                                                style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.access_time,
                                                        color: maincolor,
                                                        size: 13.sp,
                                                      ),
                                                      Text(
                                                        controller.jobs!
                                                                .viewData!.data!
                                                                .elementAt(
                                                                    index)
                                                                .items!
                                                                .isNotEmpty
                                                            ? "  ${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.material}"
                                                            : "",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: const Color(
                                                              0xff8F9BB3),
                                                          fontSize: 10.sp,
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
                                                      SvgPicture.asset(
                                                        "assets/images/exapnd.svg",
                                                        color: maincolor,
                                                        height: 10.h,
                                                        width: 13.w,
                                                      ),
                                                      Text(
                                                        controller.jobs!
                                                                .viewData!.data!
                                                                .elementAt(
                                                                    index)
                                                                .items!
                                                                .isNotEmpty
                                                            ? "  ${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.length}x${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.width}x${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.height}"
                                                            : "",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: const Color(
                                                              0xff8F9BB3),
                                                          fontSize: 10.sp,
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
                                                      SvgPicture.asset(
                                                        "assets/images/quantity.svg",
                                                        color: maincolor,
                                                        height: 10.h,
                                                        width: 13.w,
                                                      ),
                                                      Text(
                                                        controller.jobs!
                                                                .viewData!.data!
                                                                .elementAt(
                                                                    index)
                                                                .items!
                                                                .isNotEmpty
                                                            ? "  ${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.quantity} Qty"
                                                            : "",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: const Color(
                                                              0xff8F9BB3),
                                                          fontSize: 10.sp,
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
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Timeline.tileBuilder(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      theme: TimelineThemeData(
                                          indicatorTheme: IndicatorThemeData(
                                              size: 18.r, color: maincolor),
                                          connectorTheme: ConnectorThemeData(
                                            color: maincolor,
                                          ),
                                          indicatorPosition: 0.2,
                                          nodePosition: 0),
                                      builder: TimelineTileBuilder.connected(
                                        indicatorBuilder: (context, indiindex) {
                                          if (indiindex == 0) {
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
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Color(
                                                                    0xff5D5D5D),
                                                                BlendMode
                                                                    .saturation),
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
                                        connectorBuilder:
                                            (context, index, type) {
                                          return const DashedLineConnector(
                                            color: Color(0xffBDBDBD),
                                            thickness: 1.2,
                                            space: 3,
                                            dash: 4,
                                            gap: 3,
                                          );
                                        },
                                        contentsBuilder: (context, _index) =>
                                            Padding(
                                          padding: EdgeInsets.only(
                                            left: 8.w,
                                            bottom: 10.h,
                                          ),
                                          child: Text(
                                            controller.jobs!.viewData!.data!
                                                        .elementAt(index)
                                                        .items !=
                                                    null
                                                ? controller
                                                    .jobs!
                                                    .viewData!
                                                    .data![index]
                                                    .items!
                                                    .first
                                                    .address!
                                                    .elementAt(_index)
                                                    .address!
                                                : "",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5D5D5D),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        itemCount: controller
                                                .jobs!.viewData!.data!
                                                .elementAt(index)
                                                .items!
                                                .isNotEmpty
                                            ? controller
                                                .jobs!
                                                .viewData! //
                                                .data![index]
                                                .items!
                                                .first
                                                .address!
                                                .length
                                            : 0,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Amount",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff8F9BB3),
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            "\$${controller.jobs!.viewData!.data!.elementAt(index).budget}",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5D5D5D),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                        // hetpatel5509@gmail.com
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
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
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: controller.jobs!.viewData!.data!.length,
                  ),
                );
              }
              return const SizedBox();
            })
          : Consumer<HomeProvider>(builder: (context, controller, child) {
              if (controller.latitude == null) {
                return const SizedBox();
              } else if (controller.latitude != null) {
                for (var e in controller.jobs!.viewData!.data!) {
                  for (var i in e.items!) {
                    addmarker(
                        lat: i.address!.first.lat!,
                        long: i.address!.first.long!);
                  }
                }
                return Stack(
                  children: [
                    GoogleMap(
                      buildingsEnabled: false,
                      mapType: MapType.terrain,
                      markers: markers,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
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
                          controller.latitude!,
                          controller.longitude!,
                        ),
                        zoom: 15.0,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.21,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      theme: TimelineThemeData(
                                          indicatorTheme: IndicatorThemeData(
                                              size: 18.r, color: maincolor),
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
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Color(
                                                                    0xff5D5D5D),
                                                                BlendMode
                                                                    .saturation),
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
                                        connectorBuilder:
                                            (context, index, type) {
                                          return const DashedLineConnector(
                                            color: Color(0xffBDBDBD),
                                            thickness: 1.2,
                                            space: 3,
                                            dash: 4,
                                            gap: 3,
                                          );
                                        },
                                        contentsBuilder: (context, _index) =>
                                            Padding(
                                          padding: EdgeInsets.only(
                                            left: 8.w,
                                            bottom: 10.h,
                                          ),
                                          child: Text(
                                            controller.jobs!.viewData!.data!
                                                        .elementAt(index)
                                                        .items !=
                                                    null
                                                ? controller
                                                    .jobs!
                                                    .viewData!
                                                    .data![index]
                                                    .items!
                                                    .first
                                                    .address!
                                                    .elementAt(_index)
                                                    .address!
                                                : "",
                                            style: GoogleFonts.inter(
                                              color: const Color(0xff5D5D5D),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        itemCount: controller
                                                .jobs!.viewData!.data!
                                                .elementAt(index)
                                                .items!
                                                .isNotEmpty
                                            ? controller
                                                .jobs!
                                                .viewData! //
                                                .data![index]
                                                .items!
                                                .first
                                                .address!
                                                .length
                                            : 0,
                                      ),
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
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
                                              "${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.length}",
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
                                          mainAxisSize: MainAxisSize.min,
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
                                              "${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.width}",
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
                                          mainAxisSize: MainAxisSize.min,
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
                                              "${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.height}",
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
                                          mainAxisSize: MainAxisSize.min,
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
                                              "${controller.jobs!.viewData!.data!.elementAt(index).items!.first.product!.quantity}",
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JobDetailScreen(
                                                  data: controller
                                                      .jobs!.viewData!.data!
                                                      .elementAt(index),
                                                ),
                                              ),
                                            );
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             JobDetailScreen(
                                            //            )));
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: const Color(
                                                              0xff000000)
                                                          .withOpacity(0.225),
                                                      spreadRadius: 0,
                                                      blurRadius: 8,
                                                      offset:
                                                          const Offset(0, 4))
                                                ],
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xffFF7A00),
                                                      Color(0xffFFAC61),
                                                    ])),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.jobs!.viewData!.data!.length),
                      ),
                    )
                  ],
                );
              }
              return const SizedBox();
            }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                jobtype = "list";
              });
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  begin: Alignment.topCenter,
                  colors: jobtype == "list"
                      ? [
                          const Color(0xffFF7A00),
                          const Color(0xffFFA95A),
                        ]
                      : [
                          Colors.white,
                          Colors.white,
                        ],
                ),
                color: jobtype == "list" ? Colors.white : Colors.white,
              ),
              child: Icon(
                Icons.menu,
                color: jobtype == "list" ? Colors.white : maincolor,
              ),
            ),
          ),
          SizedBox(
            width: 15.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                jobtype = "map";
              });
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  begin: Alignment.topCenter,
                  colors: jobtype == "map"
                      ? [
                          const Color(0xffFF7A00),
                          const Color(0xffFFA95A),
                        ]
                      : [Colors.white, Colors.white],
                ),
                color: jobtype == "map" ? Colors.white : Colors.white,
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: jobtype == "map" ? Colors.white : maincolor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

final markericon = const AppImage(
  "assets/images/markericon.svg",
  height: 300,
  width: 300,
).toBitmapDescriptor(
  logicalSize: const Size(300, 300),
  imageSize: const Size(300, 300),
);
