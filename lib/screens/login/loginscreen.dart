import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/helpers/strings_extentation.dart';
import 'package:click_send/screens/forgot/forgotpassword.dart';
import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:click_send/screens/registeras/registeras.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Consumer<LoginProvider>(builder: (context, provider, child) {
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

          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //     Navigator.pop(context, true);
                        SystemNavigator.pop();
                      },
                      child: AppImage(
                        ImageStrings.arrowbackicon,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Login",
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
                      "Login now to send and receive all\nyour parcel in one place!",
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
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
                          keyboardType: TextInputType.emailAddress,
                          controller: provider.emailcontroller,
                          decoration: InputDecoration(
                            hintText: "Ex: abc@example.com",
                            hintStyle: GoogleFonts.inter(
                                color: const Color(0xffC8C8C8),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: AppImage(ImageStrings.emaillogo),
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
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Password",
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
                          controller: provider.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "●●●●●●●●●",
                            hintStyle: GoogleFonts.inter(
                                color: const Color(0xffC8C8C8),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: AppImage(ImageStrings.lockicon),
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
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.inter(
                          color: maincolor,
                          fontSize: 11.sp,
                          decorationColor: maincolor,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (!provider.emailcontroller.text.isValidEmail()) {
                          MotionToast(
                            icon: Icons.error,
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: Text("Please Enter Valid Email"),
                          ).show(context);
                        } else if (provider.passwordController.text.isEmpty) {
                          MotionToast(
                            icon: Icons.error,
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 60.h,
                            primaryColor: maincolor,
                            description: Text("Please Enter Password"),
                          ).show(context);
                        } else {
                          provider.douserlogin(context: context);
                        }
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(
                        //       builder: (context) => const DriverInfo()),
                        //   (route) => false,
                        // );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          color: maincolor,
                        ),
                        child: Center(
                          child: Text(
                            "Login",
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
                      height: 25.h,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1.5.sp,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    InkWell(
                      onTap: () async {
                        await provider.handleSignIn(context: context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.black,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImage(ImageStrings.googlelogo),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Continue with Google",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterAs(),
                            ),
                          );
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Don’t have an account? ",
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
                                      builder: (context) => const RegisterAs(),
                                    ),
                                  );
                                },
                              text: "Register",
                              style: GoogleFonts.inter(
                                color: maincolor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ))
                        ])),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
