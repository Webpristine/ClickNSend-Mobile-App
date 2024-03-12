import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/delivery/takingimage.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class AppliendJobScreen extends StatefulWidget {
  const AppliendJobScreen({super.key});

  @override
  State<AppliendJobScreen> createState() => _AppliendJobScreenState();
}

class _AppliendJobScreenState extends State<AppliendJobScreen> {
  List<Products> allproducts = [
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
    Products(
      bids: "500",
      image:
          "https://m.media-amazon.com/images/I/318sWJq8bgL._SY445_SX342_QL70_FMwebp_.jpg",
      name: "Vegetable Box",
      remaining: "5 Days Remaining",
      status: "Completed",
    ),
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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _handlerDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
        ],
        title: Text(
          "Applied Jobs",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leadingWidth: 43.w,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            top: 13.h,
          ),
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(),
            badgeStyle: badges.BadgeStyle(badgeColor: maincolor),
            badgeContent: Text(
              '0',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            child: const Icon(
              Icons.notifications_none,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      //  bottomNavigationBar: CommonBottomBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(
          16.0.r,
        ),
        child: Column(
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
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: maincolor),
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
                  "Today",
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
            ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TakingImagePickup(
                          jobid: "147",
                          itemid: "",
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppImage(
                            allproducts.elementAt(index).image,
                            height: 64.h,
                            width: 74.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allproducts.elementAt(index).name,
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/bid.svg",
                                                color: maincolor,
                                                height: 10.h,
                                                width: 13.w,
                                              ),
                                              Text(
                                                "  ${allproducts.elementAt(index).bids} Bids",
                                                style: GoogleFonts.inter(
                                                  color:
                                                      const Color(0xff8F9BB3),
                                                  fontSize: 8.sp,
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
                                                "assets/images/wait.svg",
                                                color: maincolor,
                                                height: 10.h,
                                                width: 13.w,
                                              ),
                                              Text(
                                                "  ${allproducts.elementAt(index).remaining}",
                                                style: GoogleFonts.inter(
                                                  color:
                                                      const Color(0xff8F9BB3),
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 100.w,
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffD8F2D0),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Text(
                                  allproducts.elementAt(index).status,
                                  style: GoogleFonts.inter(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff71BD5E),
                                  ),
                                ),
                              ),
                            ],
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
              itemCount: allproducts.length,
            ),
          ],
        ),
      ),
    );
  }
}
