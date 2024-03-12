import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_job.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/delivery/logic/deliveryprovider.dart';
import 'package:click_send/screens/feedback/feedback.dart';
import 'package:click_send/screens/notification/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_signature/signature.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class SignFromReceiver extends StatefulWidget {
  final String jobid;
  final String itemid;
  const SignFromReceiver({
    super.key,
    required this.jobid,
    required this.itemid,
  });

  @override
  State<SignFromReceiver> createState() => _SignFromReceiverState();
}

class _SignFromReceiverState extends State<SignFromReceiver> {
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
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          "Add Proof of Delivery",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: AppImage(
              ImageStrings.arrowbackicon,
            ),
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
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xffDADADA),
                            width: 1,
                          )),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xffDADADA),
                            width: 1,
                          )),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xffDADADA),
                            width: 1,
                          )),
                          hintText: "Ex. Saul Ramirez",
                          hintStyle: GoogleFonts.inter(
                            color: const Color(
                              0xffC8C8C8,
                            ),
                            fontSize: 15.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Signature",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check_circle,
                            size: 20.sp,
                            color: const Color(
                              0xff71BD5E,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffDADADA))),
                      child: HandSignature(
                        control: controller.control,
                        color: Colors.blueGrey,

                        // width: ,
                        width: 1.0,
                        maxWidth: 10.0,
                        type: SignatureDrawType.shape,
                      ),
                    ),
                    //

                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.control.clear();
                          },
                          child: Text(
                            "Clear Signature",
                            style: GoogleFonts.inter(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // const Spacer(),
                SizedBox(
                  height: 100.h,
                ),
                InkWell(
                  onTap: () {
                    if (controller.nameController.text.isEmpty) {
                      return MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: Text("Please Enter Receiver's Name"),
                      ).show(context);
                    } else if (controller.control.isFilled == false) {
                      return MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Please Draw Signature"),
                      ).show(context);
                    } else {
                      controller.convertSignintoImage(
                        context: context,
                        id: widget.jobid,
                        itemid: widget.itemid,
                        type: "drop",
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const FeedBackScreen(),
                      //   ),
                      // );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: 20.h,
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
          ),
        );
      }),
    );
  }
}
