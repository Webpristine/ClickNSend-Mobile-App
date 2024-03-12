import 'dart:developer';

import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/app_textfield.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/helpers/strings_extentation.dart';
import 'package:click_send/screens/login/loginscreen.dart';
import 'package:click_send/screens/otp/otpverification.dart';
import 'package:click_send/screens/signup/logic/signupprovider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';

class SignupScreen extends StatefulWidget {
  final String registerType;

  const SignupScreen({
    super.key,
    required this.registerType,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Country country = Country(
    phoneCode: "1",
    countryCode: "US",
    e164Sc: 1,
    geographic: false,
    level: 1,
    name: "USA",
    example: "",
    displayName: "Usa",
    displayNameNoCountryCode: "",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignupProvider>(builder: (
        context,
        provider,
        child,
      ) {
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
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            provider.emailcontroller.clear();
            provider.nameController.clear();
            provider.mobileController.clear();
            // provider.registeras = "";
            provider.passwordController.clear();
            provider.cPasswordController.clear();
            return false;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        provider.emailcontroller.clear();
                        provider.nameController.clear();
                        provider.mobileController.clear();
                        // provider.registeras = "";
                        provider.passwordController.clear();
                        provider.cPasswordController.clear();
                      },
                      child: AppImage(
                        ImageStrings.arrowbackicon,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: maincolor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Create an ",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              )),
                          TextSpan(
                              text: "account ",
                              style: GoogleFonts.inter(
                                color: maincolor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              )),
                          TextSpan(
                              text: "to access all the\nfeatures of ",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              )),
                          TextSpan(
                              text: "ClickandSend!",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              )),
                          //              )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: provider.emailcontroller,
                      hinttext: "Ex: abc@example.com",
                      imagepath: ImageStrings.emaillogo,
                      title: 'Email',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextField(
                      keyboardType: TextInputType.name,
                      imagepadding: 15.r,
                      controller: provider.nameController,
                      hinttext: "Ex. Saul Ramirez",
                      title: 'Full Name',
                      imagepath: ImageStrings.personicon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Mobile",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryFilter: ["IN", "US"],

                                  showPhoneCode:
                                      true, // optional. Shows phone code before the country name.
                                  onSelect: (Country scountry) {
                                    setState(() {
                                      country = scountry;
                                      log(scountry.name + scountry.countryCode);
                                    });
                                  },
                                );
                              },
                              child: Container(
                                width: 65.w,
                                margin: EdgeInsets.only(top: 0.h),
                                height: 48.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.sp),
                                    color: Colors.transparent,
                                    border: Border.all(color: maincolor)),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      country.flagEmoji,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Flexible(
                          child: AppTextField(
                            keyboardType: TextInputType.phone,
                            imagepadding: 16.r,
                            controller: provider.mobileController,
                            hinttext: "Ex. Saul Ramirez",
                            imagepath: ImageStrings.phoneicon,
                            title: '',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: provider.passwordController,
                      hinttext: "●●●●●●●●●",
                      imagepath: ImageStrings.lockicon,
                      title: 'Your Password',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: provider.cPasswordController,
                      hinttext: "●●●●●●●●●",
                      imagepath: ImageStrings.lockicon,
                      title: 'Confirm Password',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    "By clicking “sign in” you certify that you agree with our\n",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text: "Privacy Policy ",
                                style: GoogleFonts.inter(
                                  color: maincolor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            TextSpan(
                                text: "and",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text: " Terms & Conditions ",
                                style: GoogleFonts.inter(
                                  color: maincolor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (!provider.emailcontroller.text.isValidEmail()) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please Enter Valid E-mail"),
                          ).show(context);
                        } else if (provider.nameController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please Enter Your Full Name"),
                          ).show(context);
                        } else if (provider.mobileController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description:
                                const Text("Please Enter Your Mobile Number"),
                          ).show(context);
                        } else if (provider.passwordController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text("Please Enter Password"),
                          ).show(context);
                        } else if (provider.passwordController.text.length <
                            8) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text(
                                "Password Length Should Be 8 Characters Long"),
                          ).show(context);
                        } else if (provider.passwordController.text !=
                            provider.cPasswordController.text) {
                          MotionToast(
                            icon: Icons.error,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: const Text("Password Not Match"),
                          ).show(context);
                        } else {
                          provider.douserlogin(
                            context: context,
                            mobile: provider.mobileController.text,
                            dialcode: "+${country.phoneCode}",
                            registerType: widget.registerType,
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: maincolor,
                        ),
                        child: Center(
                          child: Text(
                            "Signup",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Already have an account? ",
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                text: "Login",
                                style: GoogleFonts.inter(
                                  decoration: TextDecoration.underline,
                                  color: maincolor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
