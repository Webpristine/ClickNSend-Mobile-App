// import 'package:click_send/common/app_colors.dart';
// import 'package:click_send/common/app_image.dart';
// import 'package:click_send/common/image_string.dart';
// import 'package:click_send/screens/driverinfo/driver_upload_doc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ComapnyDriverScreen extends StatefulWidget {
//   const ComapnyDriverScreen({super.key});

//   @override
//   State<ComapnyDriverScreen> createState() => _ComapnyDriverScreenState();
// }

// class _ComapnyDriverScreenState extends State<ComapnyDriverScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.all(16.0.r),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: AppImage(
//                 ImageStrings.arrowbackicon,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Center(
//               child: Text(
//                 "Welcome to Click & Send",
//                 style: GoogleFonts.inter(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w700,
//                   color: maincolor,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Center(
//               child: Text(
//                 "Please fill the details below to\nstart earning",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.inter(
//                     color: Colors.black,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.w400),
//               ),
//             ),
//             SizedBox(
//               height: 30.h,
//             ),
//             DriverTextField(
//               text: "Name",
//               // imagepath: ImageStrings.contacticon,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             DriverTextField(
//               text: "Email",
//               //   imagepath: ImageStrings.contacticon,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             const DriverTextField(
//               text: "Phone",
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             DriverTextField(
//               text: "Driver License",
//               imagepath: ImageStrings.upload_icon,
//               padding: 14.r,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             DriverTextField(
//               text: "Expiry Date",
//               imagepath: ImageStrings.calendaricon,
//               padding: 14.r,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xffF8F8F8),
//                 borderRadius: BorderRadius.circular(
//                   15,
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(
//                 vertical: 3.h,
//               ),
//               child: DropdownButton<String>(
//                 //   value: controller.securitytype,
//                 hint: Text(
//                   "Vehicle Type",
//                   style: GoogleFonts.inter(
//                     color: const Color(
//                       0xffA9A9A9,
//                     ),
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),

//                 icon: Icon(
//                   Icons.keyboard_arrow_down_outlined,
//                   size: 30.h,
//                   color: const Color(0xff979797),
//                 ),
//                 isExpanded: true,

//                 dropdownColor: Colors.white,
//                 underline: const SizedBox(),
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 items: ['driver', 'company', 'customer'].map((String items) {
//                   return DropdownMenuItem(
//                     alignment: Alignment.center,
//                     value: items,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Text(
//                           items,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   //  controller.assignSecuerityType(securityType: newValue!);
//                 },
//               ),
//             ),
//             Spacer(),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const DriverUploadDocs(),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(
//                     15,
//                   ),
//                   color: maincolor,
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Proceed",
//                     style: GoogleFonts.inter(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

// class DriverTextField extends StatelessWidget {
//   final String text;
//   final String? imagepath;
//   final double? padding;
//   const DriverTextField({
//     super.key,
//     required this.text,
//     this.padding,
//     this.imagepath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xffF8F8F8),
//         borderRadius: BorderRadius.circular(
//           15,
//         ),
//       ),
//       child: TextFormField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(
//             left: 20.w,
//             top: 10.h,
//             bottom: 10.h,
//           ),
//           suffixIcon: imagepath != null
//               ? Padding(
//                   padding: EdgeInsets.all(padding ?? 10),
//                   child: AppImage(
//                     imagepath!,
//                   ),
//                 )
//               : null,
//           hintText: text,
//           hintStyle: GoogleFonts.inter(
//             color: const Color(0xffA9A9A9),
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w400,
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
