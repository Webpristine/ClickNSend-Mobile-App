import 'dart:io';

import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_job.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/screens/delivery/deliverypin.dart';
import 'package:click_send/screens/delivery/logic/deliveryprovider.dart';
import 'package:click_send/screens/delivery/takeimagedrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class TakingImagePickup extends StatefulWidget {
  final String jobid;
  final String itemid;
  const TakingImagePickup(
      {super.key, required this.jobid, required this.itemid});

  @override
  State<TakingImagePickup> createState() => _TakingImagePickupState();
}

class _TakingImagePickupState extends State<TakingImagePickup> {
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
            Navigator.of(context).pop();
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
            children: [
              Container(
                color: const Color(0xffF8F9FD),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: controller.selectedimage.isNotEmpty ? 40.h : 50.h,
                    ),
                    const Center(
                      child: AppImage(
                        "assets/images/upload.png",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Take Photo\nat the time of Pickup",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xff222B45),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: controller.selectedimage.isNotEmpty ? 00 : 50.h,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromCamera(context: context).then((value) {
                          setState(() {
                            controller.selectedimage.add(File(value.path));
                          });
                        });
                      },
                      child: Transform.translate(
                        offset: const Offset(0, 25),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 15.h,
                            bottom: 15.h,
                            left: 24.w,
                            right: 24.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(41),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffFF7A00).withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 14,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xffFF7A00),
                                Color(0xffFFC189),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Use Camera",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Color(0xffEEEEEE),
                    )),
                    Text(
                      "  or  ",
                      style: GoogleFonts.inter(
                        color: const Color(0xff9B9B9B),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Expanded(
                        child: Divider(
                      color: Color(0xffEEEEEE),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  pickImageFromGallery(context: context).then((value) {
                    setState(() {
                      controller.selectedimage.add(File(value.path));
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.04),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(0xffE4E4E4),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImage(
                        "assets/images/gallery.svg",
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select an image from Gallery",
                            style: GoogleFonts.inter(
                              color: Color(0xff626A7E),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ".jpg .png .jpeg",
                            style: GoogleFonts.inter(
                              color: Color(0xff9B9B9B),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: controller.selectedimage.isNotEmpty,
                  child: SizedBox(
                    height: 30.h,
                  )),
              Visibility(
                visible: controller.selectedimage.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                  ),
                  child: SizedBox(
                    height: 70.h,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return badges.Badge(
                          position: badges.BadgePosition.topStart(
                            top: -12,
                            start: 47,
                          ),
                          badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.transparent),
                          badgeContent: InkWell(
                            onTap: () {
                              setState(() {
                                controller.selectedimage.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 0,
                                    blurRadius: 3)
                              ], shape: BoxShape.circle, color: Colors.white),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                              ),
                            ),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 70.h,
                              width: 60.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.selectedimage[index],
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
                      itemCount: controller.selectedimage.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (controller.selectedimage.isEmpty) {
                  } else {
                    context.read<DeliveryProvider>().itempick(
                        context: context,
                        id: widget.jobid,
                        type: "pick",
                        itemid: widget.itemid);
                  }
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => TakeImageDrop(),
                  //   ),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                        bottom: 20.h,
                        top: controller.selectedimage.isNotEmpty ? 20.h : 40.h,
                      ) +
                      EdgeInsets.symmetric(
                        horizontal: 32.w,
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
