import 'dart:io';

import 'package:click_send/common/app_drawer_job.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/bottomnavigationbar.dart';
import 'package:click_send/screens/delivery/logic/deliveryprovider.dart';
import 'package:click_send/screens/delivery/takeimagedrop.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';

class FeedBackScreen extends StatefulWidget {
  final String id;
  const FeedBackScreen({super.key, required this.id});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  List<File> selectedimage = [];
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
      endDrawer: AppDrawerJob(
        onDrawerItemTap: (v) {},
        scaffoldkey: _scaffoldKey,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Feedback",
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
            ),
          )
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Consumer<DeliveryProvider>(builder: (context, controller, child) {
        if (controller.isloading) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            OverlayLoadingProgress.start(
              context,
              color: maincolor,
            );
          });
        } else if (controller.iserror) {
          OverlayLoadingProgress.stop();
        } else if (controller.isloading == false) {
          OverlayLoadingProgress.stop();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppImage(
                "assets/images/feedback.jpeg",
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xffECECEC),
                    )),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 12.w,
                ),
                margin: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please rate your experience",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RatingBar.builder(
                      initialRating: controller.rating.toDouble(),
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 13.w),
                      wrapAlignment: WrapAlignment.spaceEvenly,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                        return const Icon(Icons.abc);
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          rating = controller.rating.toDouble();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Additional comments",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.04),
                                blurRadius: 5,
                                spreadRadius: 0,
                                offset: const Offset(0, 4))
                          ],
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffDADADA),
                          )),
                      child: TextFormField(
                        controller: controller.reviewController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "   Write something here",
                            hintStyle: GoogleFonts.inter(
                              color: const Color(0xffDEDEDE),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xffECECEC),
                    )),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 12.w,
                ),
                margin: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Media",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pickImageFromGallery(context: context)
                                .then((value) {
                              setState(() {
                                selectedimage.add(File(value.path));
                              });
                            });
                          },
                          child: Text(
                            "Gallery",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                                color: maincolor),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromCamera(context: context).then((value) {
                          setState(() {
                            selectedimage.add(File(value.path));
                          });
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(25) +
                                EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                                color: const Color(0xffF4F4F4),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xffDADADA),
                                )),
                            child: const AppImage(
                              "assets/images/bi_camera.svg",
                              color: Color(0xffDADADA),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 77.h,
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return badges.Badge(
                                    position: badges.BadgePosition.topStart(
                                      top: -5,
                                      start: 57,
                                    ),
                                    badgeStyle: const badges.BadgeStyle(
                                        badgeColor: Colors.transparent),
                                    badgeContent: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedimage.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  spreadRadius: 0,
                                                  blurRadius: 3)
                                            ],
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 70.h,
                                        width: 70.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            selectedimage[index],
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20.w,
                                  );
                                },
                                itemCount: selectedimage.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
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
              InkWell(
                onTap: () {
                  if (controller.reviewController.text.isEmpty) {
                    return MotionToast(
                      icon: Icons.error,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60.h,
                      primaryColor: maincolor,
                      description: const Text("Please Enter Your Review"),
                    ).show(context);
                  } else if (selectedimage.isEmpty) {
                    return MotionToast(
                      icon: Icons.error,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60.h,
                      primaryColor: maincolor,
                      description: const Text("Please Select Image"),
                    ).show(context);
                  } else {
                    controller.itemfeedback(
                      context: context,
                      image: selectedimage.first,
                      id: widget.id,
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                        bottom: 40.h,
                      ) +
                      EdgeInsets.symmetric(
                        horizontal: 26.w,
                      ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
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
            ],
          ),
        );
      }),
    );
  }
}
