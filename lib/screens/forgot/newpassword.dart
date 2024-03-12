import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_image.dart';
import 'package:click_send/common/app_textfield.dart';
import 'package:click_send/common/image_string.dart';
import 'package:click_send/screens/forgot/logic/forgotpasswordprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
          child: SingleChildScrollView(
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
                    "Reset Password?",
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
                    "Set your new password to login into\nyour account!",
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  AppTextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: provider.passwordController,
                    hinttext: "●●●●●●●●●",
                    imagepath: ImageStrings.lockicon,
                    title: 'Enter New Password',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (provider.passwordController.text.isEmpty) {
                        MotionToast(
                          icon: Icons.error,
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 60.h,
                          primaryColor: maincolor,
                          description: const Text("Please Enter Password"),
                        ).show(context);
                      } else if (provider.passwordController.text.length < 8) {
                        MotionToast(
                          icon: Icons.error,
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 60.h,
                          primaryColor: maincolor,
                          description: const Text(
                              "Password Length Should Be 8 Characters Long"),
                        ).show(context);
                      } else {
                        provider.resetpassword(context: context);
                      }
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
                          "Confirm",
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
            ),
          ),
        );
      }),
    );
  }
}
