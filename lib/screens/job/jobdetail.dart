import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/model/jobs.dart';
import 'package:click_send/screens/job/afterjobview.dart';
import 'package:click_send/screens/job/appliedjobs.dart';
import 'package:click_send/screens/job/logic/jobprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;

class JobDetailScreen extends StatefulWidget {
  final Data data;
  const JobDetailScreen({super.key, required this.data});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  JobProvider? jobProvider;
  @override
  initState() {
    jobProvider = context.read<JobProvider>();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              jobProvider!.resetform();
            },
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          widget.data.name!,
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
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: const BoxDecoration(
                color: Color(0xffFEE6BB),
                shape: BoxShape.circle,
              ),
              child: Text(
                "MA",
                style: GoogleFonts.inter(
                  color: maincolor,
                  fontSize: 37.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.data.createdBy!,
            style: GoogleFonts.inter(
              color: const Color(0xff222B45),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemSize: 25.sp,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
              Icons.star_rate_rounded,
              color: maincolor,
              size: 10.sp,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          const Divider(),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 88.h,
            width: 99.w,
            child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return Container(
                    height: 88.h,
                    width: 99.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            widget.data.items![index].product!.baseUrl! +
                                widget.data.items![index].product!.image!,
                          )),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // child: FittedBox(
                    //   fit: BoxFit.fill,
                    //   child: const AppImage(
                    //     "https://rukminim2.flixcart.com/image/612/612/xif0q/shoe/c/e/5/-original-imagg7t2qvzg6jjy.jpeg?q=70",
                    //   ),
                    // ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
                itemCount: widget.data.items!.length),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.data.name!,
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
                    "  ${widget.data.items!.first.product!.material}",
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
                    "  ${widget.data.items!.first.product!.length}x${widget.data.items!.first.product!.width}x${widget.data.items!.first.product!.height}",
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
                    "  ${widget.data.items!.first.product!.quantity} Qty",
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
                if (widget.data.items!.first.address!.elementAt(index).type ==
                    "pickup") {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "  ${widget.data.items!.first.address![index].address}",
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
                } else if (widget.data.items!.first.address!
                        .elementAt(index)
                        .type ==
                    "drop") {
                  return Text(
                    "  ${widget.data.items!.first.address![index].address}",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return SizedBox();
                // return Text(
                //   "  ${widget.data.items!.first.address![index].address}",
                //   style: GoogleFonts.inter(
                //     color: Colors.black,
                //     fontSize: 14.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                // );
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
              indicatorBuilder: (_, index) {
                switch (widget.data.items!.first.address![index].type) {
                  case "pickup":
                    return DotIndicator(
                        color: maincolor,
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/rectangle.png"))),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 8.sp,
                          ),
                        ));

                  case "drop":
                  default:
                    return DotIndicator(
                        color: const Color(0xff5D5D5D),
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  colorFilter: const ColorFilter.mode(
                                      Color(0xff5D5D5D), BlendMode.saturation),
                                  image: AssetImage(
                                      "assets/images/rectangle.png"))),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 9.sp,
                          ),
                        ));
                }
              },
              itemExtentBuilder: (_, __) => kTileHeight,
              itemCount: widget.data.items!.first.address!.length,
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
            padding: EdgeInsets.symmetric(horizontal: 16.w) +
                EdgeInsets.only(right: 28.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getdatetimewidget(
                    content: widget.data.items!.first.product!.pickupDate == ""
                        ? "N/A"
                        : widget.data.items!.first.product!.pickupDate!,
                    icon: Icons.calendar_today,
                    title: "Pick up Date"),
                getdatetimewidget(
                    content: widget.data.items!.first.product!.dropDate == ""
                        ? "N/A"
                        : widget.data.items!.first.product!.dropDate!,
                    icon: Icons.calendar_today,
                    title: "Drop out Date")
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w) +
                EdgeInsets.only(right: 0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getdatetimewidget(
                    content: widget.data.items!.first.product!.pickupTime == ""
                        ? "N/A"
                        : widget.data.items!.first.product!.pickupTime!,
                    icon: Icons.access_time_outlined,
                    title: "Pick up Time"),
                Padding(
                  padding: EdgeInsets.only(right: 28.w),
                  child: getdatetimewidget(
                      content: widget.data.items!.first.product!.dropTime == ""
                          ? "N/A"
                          : widget.data.items!.first.product!.dropTime!,
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
          Center(
            child: Text(
              "Place your Bid",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 19.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "￡",
                  style: GoogleFonts.inter(
                    color: const Color(0xffC1C1C1),
                    fontSize: 37.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 100.w,
                  child: TextFormField(
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 37.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    controller: jobProvider!.bidamount,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        counterText: "",
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2)),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2)),
                        hintText: "0",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 37.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  ".00",
                  style: GoogleFonts.inter(
                    color: const Color(0xffC1C1C1),
                    fontSize: 37.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: TextFormField(
              maxLines: 3,
              controller: jobProvider!.bidcomment,
              decoration: InputDecoration(
                  hintText: "Note to customer",
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
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        width: 1.5,
                        color: Color(0xffDADADA),
                      )),
                  border: OutlineInputBorder(
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
              if (jobProvider!.bidamount.text.isEmpty) {
                return MotionToast(
                  icon: Icons.error,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 60.h,
                  primaryColor: maincolor,
                  description: Text("Please Add Bid"),
                ).show(context);
              } else if (jobProvider!.bidcomment.text.isEmpty) {
                return MotionToast(
                  icon: Icons.error,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 60.h,
                  primaryColor: maincolor,
                  description: Text("Please Add Note"),
                ).show(context);
              } else {
                jobProvider!.applybid(
                  jobid: widget.data.id.toString(),
                  context: context,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const AppliendJobScreen(),
                //   ),
                // );
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
        ]),
      ),
    );
  }
}

Widget getdatetimewidget({
  required String title,
  required String content,
  required IconData icon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xffFEE6BB),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: maincolor, size: 15.sp),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            content,
            style: GoogleFonts.inter(
              color: const Color(0xff5D5D5D),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      )
    ],
  );
}

// enum TimelineStatus {
//   done,
//   sync,
//   inProgress,
//   todo,
// }

// extension on TimelineStatus {
//   bool get isInProgress => this == TimelineStatus.inProgress;
// }
