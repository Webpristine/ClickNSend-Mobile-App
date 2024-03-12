import 'package:click_send/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PayMentThankYou extends StatefulWidget {
  const PayMentThankYou({super.key});

  @override
  State<PayMentThankYou> createState() => _PayMentThankYouState();
}

class _PayMentThankYouState extends State<PayMentThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppImage(
            "assets/images/arrowback.svg",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thank you",
              style: GoogleFonts.inter(
                color: Color(0xffFF7A00),
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Thank you  for the payment. You can start bidding now",
              style: GoogleFonts.inter(
                color: Color(0xff212B36).withOpacity(0.5),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(child: AppImage("assets/images/thankyou.png"))
          ],
        ),
      ),
    );
  }
}
