import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/forgot/logic/forgotpasswordprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class ForgotPasswordOTP extends StatefulWidget {
  final String type;
  final String message;

  const ForgotPasswordOTP({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  State<ForgotPasswordOTP> createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<ForgotPasswordProvider>(builder: (context, provider, child) {
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
                "Forgot Password?",
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
                "Please enter the verification code we\nsent you earlier",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                provider.sendOtpResponse != null
                    ? provider.sendOtpResponse!.verificationCode.toString()
                    : "",
                style: GoogleFonts.inter(
                  color: maincolor,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 60.w,
                obscureText: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  provider.changeotp(value);
                },
                otpFieldStyle: OtpFieldStyle(
                  //backgroundColor: Colors.black,
                  borderColor: Colors.black,
                  focusBorderColor: Colors.black,
                  disabledBorderColor: Colors.black,
                  enabledBorderColor: Colors.black,
                ),
                style: GoogleFonts.inter(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  provider.reSendOtp(
                    context: context,
                    type: widget.type,
                  );
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: Text(
                      "Resend OTP ?",
                      style: GoogleFonts.inter(
                        color: maincolor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              InkWell(
                onTap: () {
                  if (provider.otp.length < 4) {
                    MotionToast(
                      icon: Icons.error,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60.h,
                      primaryColor: maincolor,
                      description: const Text("Please Enter Valid OTP"),
                    ).show(context);
                  } else {
                    provider.validateOTP(context: context);
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const NewPasswordScreen(),
                  //   ),
                  // );
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
