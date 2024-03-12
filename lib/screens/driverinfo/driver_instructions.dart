import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/companyinfo/logic/companyinfoprovider.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class DriverInstructions extends StatefulWidget {
  final bool isfromcompany;
  const DriverInstructions({super.key, required this.isfromcompany});

  @override
  State<DriverInstructions> createState() => _DriverInstructionsState();
}

class _DriverInstructionsState extends State<DriverInstructions> {
  bool ischecked = false;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverInfoProvider>().getinstructions(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<DriverInfoProvider, CompanyInfoProvider>(
          builder: (context, provider, provider2, child) {
        if (provider.isloading) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            OverlayLoadingProgress.start(
              context,
              color: maincolor,
            );
          });
        } else if (provider.iserror) {
          OverlayLoadingProgress.stop();
        } else if (provider2.isloading) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            OverlayLoadingProgress.start(
              context,
              color: maincolor,
            );
          });
        } else if (provider2.iserror) {
          OverlayLoadingProgress.stop();
        }
        OverlayLoadingProgress.stop();
        return SafeArea(
            child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppImage(
                  ImageStrings.arrowbackicon,
                ),
              ),
              Center(
                child: AppImage(
                  ImageStrings.appimage,
                  height: 140.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  "Instructions",
                  style: GoogleFonts.inter(
                    color: maincolor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Html(
                  data: provider.instructions?.viewData ?? "",
                  style: {
                    "body": Style.fromTextStyle(
                      GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  },
                ),
                // child: Text(
                //   provider.instructions?.viewData ?? "",
                //   style: GoogleFonts.inter(
                //     color: Colors.black,
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 30.w,
                    child: Checkbox(
                      activeColor: maincolor,
                      value: ischecked,
                      onChanged: (v) {
                        setState(() {
                          ischecked = !ischecked;
                        });
                      },
                    ),
                  ),
                  Text(
                    "I hereby read all the instructions",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  if (!ischecked) {
                    MotionToast(
                      icon: Icons.error,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60.h,
                      primaryColor: maincolor,
                      description: const Text("Please accept instructions"),
                    ).show(context);
                  } else {
                    if (widget.isfromcompany) {
                      provider2.addterms(
                        context: context,
                      );
                    } else {
                      provider.addterms(
                        context: context,
                      );
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 20.h,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
        ));
      }),
    );
  }
}
