import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenMessageScreen extends StatefulWidget {
  const OpenMessageScreen({super.key});

  @override
  State<OpenMessageScreen> createState() => _OpenMessageScreenState();
}

class _OpenMessageScreenState extends State<OpenMessageScreen> {
  List<String> messges = [
    "hi",
    "hello",
    "how are you?",
    "i am fine. and you?",
    "not well"
  ];
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          "Sender Name",
          style: GoogleFonts.inter(
              color: const Color(0xff222B45),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _handlerDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 80.h,
              left: 16.w,
              right: 16.w,
            ),
            child: ListView.builder(
              itemCount: messges.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              //    reverse: true,

              itemBuilder: (context, index) {
                if (index.isEven) {
                  return ChatBubble(
                    elevation: 0,
                    clipper: ChatBubbleClipper5(
                      type: BubbleType.receiverBubble,
                    ),
                    backGroundColor: const Color(0xffF5F5F5),
                    margin: const EdgeInsets.only(top: 20),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        messges.elementAt(index),
                        style: GoogleFonts.inter(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h) +
                  EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: AppImage(
                            "assets/images/gallery.svg",
                            color: Colors.black,
                            height: 10.h,
                            width: 10.w,
                          ),
                        ),
                        isDense: true,
                        hintText: "Message...",
                        hintStyle: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 132, 131, 131),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffFAFAFA))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffFAFAFA))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffFAFAFA))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffFAFAFA))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffFAFAFA))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffFAFAFA))),
                        fillColor: const Color(0xffFAFAFA),
                        filled: true),
                  )),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FeedBackScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: maincolor,
                        shape: BoxShape.circle,
                      ),
                      child: const AppImage("assets/images/mic.svg"),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
