import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/forgot/logic/forgotpasswordprovider.dart';
import 'package:click_send/screens/login/loginscreen.dart';
import 'package:click_send/screens/signup/logic/signupprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class OtpVerification extends StatefulWidget {
  final String message;
  final String mobile;
  const OtpVerification({
    super.key,
    required this.message,
    required this.mobile,
  });

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      MotionToast(
        icon: Icons.error,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60.h,
        primaryColor: maincolor,
        description: Text(widget.message),
      ).show(context);
      context.read<SignupProvider>().sendOtp(
          context: context, type: "mobile", mobilenumber: widget.mobile);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String firstFourCharacters =
        widget.mobile.substring(0, 4); // Extract first 4 characters
    return Scaffold(
      body: SafeArea(
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
            Text(
              "OTP Verification",
              style: GoogleFonts.inter(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                color: maincolor,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "We have sent a verification OTP code on your\nMobile number $firstFourCharacters****",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 30.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verification Code",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: "EX: 123456",
                    hintStyle: GoogleFonts.inter(
                        color: const Color(0xffC8C8C8),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                      borderSide: BorderSide(
                        color: maincolor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                      borderSide: BorderSide(
                        color: maincolor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                      borderSide: BorderSide(
                        color: maincolor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  color: maincolor,
                ),
                child: Center(
                  child: Text(
                    "Register",
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
      )),
    );
  }
}
