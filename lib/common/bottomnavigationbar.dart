// ignore_for_file: deprecated_member_use

import 'package:click_send/common/app_colors.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/calendar/calendar.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:click_send/screens/job/appliedjobs.dart';
import 'package:click_send/screens/job/upcomingjob/listview.dart';
import 'package:click_send/screens/profile/myprofile.dart';
import 'package:click_send/screens/search/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class PagesWidget extends StatefulWidget {
  PagesWidget({
    super.key,
    // this.currentTab,
  });

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  PersistentTabController controller = PersistentTabController(
    initialIndex: 0,
  );
  int selectedindex = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, //
      confineInSafeArea: true,

      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,

      backgroundColor: Colors.white, // Default is Colors.white.

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style15,

      items: [
        PersistentBottomNavBarItem(
          //   activeColorPrimary: maincolor,
          contentPadding: 0,
          activeColorPrimary: maincolor,

          title: "Home",
          textStyle: GoogleFonts.inter(
            fontSize: 11.91.sp,
            fontWeight: FontWeight.w500,
            color: selectedindex == 0 ? maincolor : const Color(0xff8F9BB3),
          ),
          icon: SvgPicture.asset(
            "assets/images/home.svg",
            color: selectedindex == 0 ? maincolor : const Color(0xff8F9BB3),
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: maincolor,
          title: "Calendar",
          textStyle: GoogleFonts.inter(
            fontSize: 11.91.sp,
            fontWeight: FontWeight.w500,
            color: selectedindex == 1 ? maincolor : const Color(0xff8F9BB3),
          ),
          icon: SvgPicture.asset(
            "assets/images/calendar_icon.svg",
            color: selectedindex == 1 ? maincolor : const Color(0xff8F9BB3),
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: maincolor,
          activeColorSecondary: maincolor,
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: maincolor,
          title: "Bidding",
          textStyle: GoogleFonts.inter(
            fontSize: 11.91.sp,
            fontWeight: FontWeight.w500,
            color: selectedindex == 3 ? maincolor : const Color(0xff8F9BB3),
          ),
          icon: SvgPicture.asset(
            "assets/images/bid.svg",
            color: selectedindex == 3 ? maincolor : const Color(0xff8F9BB3),
          ),
        ),
        //integrate api
        PersistentBottomNavBarItem(
          activeColorPrimary: maincolor,
          title: "Profile",
          textStyle: GoogleFonts.inter(
            fontSize: 11.91.sp,
            fontWeight: FontWeight.w500,
            color: selectedindex == 4
                ? maincolor
                : const Color(
                    0xff8F9BB3,
                  ),
          ),
          icon: SvgPicture.asset(
            "assets/images/profile.svg",
            color: selectedindex == 4
                ? maincolor
                : const Color(
                    0xff8F9BB3,
                  ),
          ),
        )
      ],
      controller: controller,
      screens: [
        const HomeScreen(),
        const CalendarScreen(),
        const SearchScreen(),
        preferences!.getString("usertype") == "company"
            ? const AppliendJobScreen()
            : const JobListViewScreen(),
        const MyProfileScreen(),
      ],
      onItemSelected: (int i) {
        setState(() {
          selectedindex = i;
        });
        // _selectTab(
        //   i,
        // );
      },
    );
  }
}
