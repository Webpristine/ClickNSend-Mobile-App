import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/forgot/forgotpasswordbyemail.dart';
import 'package:click_send/screens/forgot/forgotpasswordbyphone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String selectedtype = "sms";
  @override
  Widget build(BuildContext context) {
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
                "Make Selection",
                style: GoogleFonts.inter(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: maincolor,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Select witch contact detail should we\nuse to reset your password?",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordByPhone(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 35.h,
                    horizontal: 35.w,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: selectedtype == "sms"
                            ? maincolor
                            : Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.06),
                          spreadRadius: 0,
                          blurRadius: 11,
                          offset: const Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      AppImage(
                        ImageStrings.mobileicon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "via sms:",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "+91 8766553678",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordByEmailScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 38.h,
                    horizontal: 35.w,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: selectedtype == "mail"
                            ? maincolor
                            : Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.06),
                          spreadRadius: 0,
                          blurRadius: 11,
                          offset: const Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      AppImage(
                        ImageStrings.mailicon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "via mail:",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "support@gmail.com",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
