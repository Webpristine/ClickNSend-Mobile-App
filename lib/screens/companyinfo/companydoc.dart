import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/companyinfo/logic/companyinfoprovider.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class CompanyDocument extends StatefulWidget {
  const CompanyDocument({super.key});

  @override
  State<CompanyDocument> createState() => _CompanyDocumentState();
}

class _CompanyDocumentState extends State<CompanyDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CompanyInfoProvider>(builder: (context, provider, child) {
        if (provider.isloading) {
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              OverlayLoadingProgress.start(
                context,
                color: maincolor,
              );
            },
          );
        } else if (provider.iserror) {
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
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Upload Documents",
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: maincolor,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Please upload the required documents\nbelow to start earning",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: DottedBorder(
                  dashPattern: const [
                    8,
                    6,
                  ],
                  color: const Color(0xff979797),
                  child: InkWell(
                    onTap: () {
                      provider.changeselectedImage(context: context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 60.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F9FD),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          AppImage(ImageStrings.uploadicon),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Browse to upload",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffA3A3A3),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  provider.changeuploadindex(0);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.selectedindex == 0
                            ? const Color(
                                0xff71BD5E,
                              )
                            : const Color(0xffC4C4C4),
                      ),
                      color: provider.certi == null
                          ? Colors.transparent
                          : const Color(
                              0xffEEF8EB,
                            ),
                      borderRadius: BorderRadius.circular(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          provider.certi == null
                              ? "Company Certificate"
                              : getFileName(provider.certi!),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: provider.certi == null
                                ? const Color(0xffA9A9A9)
                                : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      provider.certi != null
                          ? AppImage(ImageStrings.tickicon)
                          : const Icon(
                              Icons.circle,
                              size: 20,
                              color: Color(
                                0xffC4C4C4,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  provider.changeuploadindex(1);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.selectedindex == 1
                            ? const Color(
                                0xff71BD5E,
                              )
                            : const Color(0xffC4C4C4),
                      ),
                      // color: const Color(
                      //   0xffEEF8EB,
                      // ),
                      color: provider.vat == null
                          ? Colors.transparent
                          : const Color(
                              0xffEEF8EB,
                            ),
                      borderRadius: BorderRadius.circular(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          provider.vat == null
                              ? "Vat Certificate(optional)"
                              : getFileName(provider.vat!),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: provider.vat == null
                                ? const Color(0xffA9A9A9)
                                : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      provider.vat != null
                          ? AppImage(ImageStrings.tickicon)
                          : const Icon(
                              Icons.circle,
                              size: 20,
                              color: Color(
                                0xffC4C4C4,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (provider.certi == null) {
                    MotionToast(
                      icon: Icons.error,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60.h,
                      primaryColor: maincolor,
                      description: const Text("Upload certificate"),
                    ).show(context);
                  } else {
                    provider.adddocument(context: context);
                  }
                },
                child: Container(
                  width: double.infinity,
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
