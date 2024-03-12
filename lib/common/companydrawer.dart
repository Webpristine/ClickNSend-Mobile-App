import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDrawer extends StatefulWidget {
  const CompanyDrawer({super.key});

  @override
  State<CompanyDrawer> createState() => _CompanyDrawerState();
}

class _CompanyDrawerState extends State<CompanyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(
        0.8,
      ),

      // shadowColor: Colors.transparent,
      // surfaceTintColor: Colors.black,
      width: 280.w,

      child: ClipRRect(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
