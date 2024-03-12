import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class DriverUploadDocs extends StatefulWidget {
  const DriverUploadDocs({super.key});

  @override
  State<DriverUploadDocs> createState() => _DriverUploadDocsState();
}

class _DriverUploadDocsState extends State<DriverUploadDocs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<DriverInfoProvider>(builder: (context, provider, child) {
        if (provider.isloading) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            OverlayLoadingProgress.start(
              context,
              color: maincolor,
            );
          });
        } else if (provider.iserror) {
          OverlayLoadingProgress.stop();
        }
        OverlayLoadingProgress.stop();
        return SafeArea(
            child: SingleChildScrollView(
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
                        color: provider.licencefile == null
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
                            provider.licencefile == null
                                ? "License"
                                : getFileName(provider.licencefile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.licencefile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.licencefile != null
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
                        color: provider.addressfile == null
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
                            provider.addressfile == null
                                ? "Address Proof"
                                : getFileName(provider.addressfile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.addressfile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.addressfile != null
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
                    provider.changeuploadindex(2);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 2
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.insurancwfile == null
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
                            provider.insurancwfile == null
                                ? "Insurance Certificate"
                                : getFileName(provider.insurancwfile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.insurancwfile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.insurancwfile != null
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
                    provider.changeuploadindex(3);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 3
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.gitfile == null
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
                            provider.gitfile == null
                                ? "Good in Transit Certificate"
                                : getFileName(provider.gitfile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.gitfile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.gitfile != null
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
                    provider.changeuploadindex(4);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 4
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.liabilityfile == null
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
                            provider.liabilityfile == null
                                ? "Public Liability Certificate"
                                : getFileName(provider.liabilityfile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.liabilityfile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.liabilityfile != null
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
                    provider.changeuploadindex(5);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 5
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.vehilefile == null
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
                            provider.vehilefile == null
                                ? "Vehicle Image"
                                : getFileName(provider.vehilefile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.vehilefile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.vehilefile != null
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
                    provider.changeuploadindex(6);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 6
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.dvlafile == null
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
                            provider.dvlafile == null
                                ? "Dvla Check Code"
                                : getFileName(provider.dvlafile!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.dvlafile == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.dvlafile != null
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
                    provider.changeuploadindex(7);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 7
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.vehiclecertificate == null
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
                            provider.vehiclecertificate == null
                                ? "Vehicle Certificate"
                                : getFileName(provider.vehiclecertificate!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.vehiclecertificate == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.vehiclecertificate != null
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
                    provider.changeuploadindex(8);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedindex == 8
                              ? const Color(
                                  0xff71BD5E,
                                )
                              : const Color(0xffC4C4C4),
                        ),
                        // color: const Color(
                        //   0xffEEF8EB,
                        // ),

                        color: provider.nationalitycerti == null
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
                            provider.nationalitycerti == null
                                ? "Nationality Certificate"
                                : getFileName(provider.nationalitycerti!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: provider.nationalitycerti == null
                                  ? const Color(0xffA9A9A9)
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        provider.nationalitycerti != null
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
                  height: 40.h,
                ),
                InkWell(
                  onTap: () {
                    if (provider.licencefile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload licence"),
                      ).show(context);
                    } else if (provider.addressfile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload address proof"),
                      ).show(context);
                    } else if (provider.insurancwfile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload insurance certificate"),
                      ).show(context);
                    } else if (provider.gitfile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload Transit certificate"),
                      ).show(context);
                    } else if (provider.liabilityfile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload liablity certificate"),
                      ).show(context);
                    } else if (provider.vehilefile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload vehicle image"),
                      ).show(context);
                    } else if (provider.dvlafile == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload dvla certificate"),
                      ).show(context);
                    } else if (provider.vehiclecertificate == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload vehicle certificate"),
                      ).show(context);
                    } else if (provider.nationalitycerti == null) {
                      MotionToast(
                        icon: Icons.error,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60.h,
                        primaryColor: maincolor,
                        description: const Text("Upload natiolity certificate"),
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
          ),
        ));
      }),
    );
  }
}
