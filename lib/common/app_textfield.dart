import 'package:click_send/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final String hinttext;
  final TextEditingController controller;
  final double? imagepadding;
  final String imagepath;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.controller,
    this.imagepadding,
    required this.keyboardType,
    required this.hinttext,
    required this.imagepath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: GoogleFonts.inter(
                color: const Color(0xffC8C8C8),
                fontSize: 15.sp,
                fontWeight: FontWeight.w400),
            prefixIcon: Padding(
              padding: EdgeInsets.all(imagepadding ?? 12.0.r),
              child: AppImage(
                imagepath,
              ),
            ),
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
    );
  }
}
