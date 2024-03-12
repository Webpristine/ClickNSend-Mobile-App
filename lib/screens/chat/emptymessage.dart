import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/chat/messagesscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyMessage extends StatefulWidget {
  const EmptyMessage({super.key});

  @override
  State<EmptyMessage> createState() => _EmptyMessageState();
}

class _EmptyMessageState extends State<EmptyMessage> {
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
      endDrawer: preferences!.getString("usertype") == "company"
          ? AppDrawer(
              onDrawerItemTap: (v) {},
              scaffoldkey: _scaffoldKey,
            )
          : AppDrawerDriver(
              scaffoldkey: _scaffoldKey,
            ),
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          "Inbox",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _handlerDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(
              ImageStrings.emptybox,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "No Conversation",
              style: GoogleFonts.inter(
                color: Color(0xff222B45),
                fontWeight: FontWeight.w600,
                fontSize: 26.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Once you start a new conversation,\nyou’ll see it listed here.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Color(0xff5D5D5D),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MessageScreen(),
                  ),
                );
              },
              child: Text(
                "Chat People",
                style: GoogleFonts.inter(
                    color: maincolor,
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
