import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/invoice/logic/invoiceprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
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
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<InvoiceProvider>().getsubscriptions(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/invoice_background.png",
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: preferences!.getString("usertype") == "company"
            ? AppDrawer(
                onDrawerItemTap: (v) {},
                scaffoldkey: _scaffoldKey,
              )
            : AppDrawerDriver(
                scaffoldkey: _scaffoldKey,
              ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          title: const Text(
            "Invoice",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _handlerDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 40.h,
          ),
          padding: EdgeInsets.only(
            left: 16.w,
          ),
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<InvoiceProvider>(
                builder: (context, controller, child) {
              if (controller.isloading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: maincolor,
                ));
              } else if (controller.invoice != null) {
                return DataTable(
                  columnSpacing: 0,
                  horizontalMargin: 0,
                  columns: [
                    DataColumn(
                      label: Container(
                        color: maincolor, // Background color for title row
                        padding: const EdgeInsets.all(8.0) +
                            EdgeInsets.only(right: 15.w),
                        child: Center(
                          child: Text(
                            'INVOICE 1',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        color: maincolor, // Background color for title row
                        padding: const EdgeInsets.all(8.0) +
                            EdgeInsets.only(right: 15.w),
                        child: Center(
                          child: Text(
                            'PAY TO 2',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        color: maincolor, // Background color for title row
                        padding: const EdgeInsets.all(8.0) +
                            EdgeInsets.only(right: 30.w),
                        child: Center(
                          child: Text(
                            'DATE',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        color: maincolor, // Background color for title row
                        padding: const EdgeInsets.all(8.0) +
                            EdgeInsets.only(right: 30.w),
                        child: Center(
                          child: Text(
                            'DATE',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        color: maincolor, // Background color for title row
                        padding: const EdgeInsets.all(8.0) +
                            EdgeInsets.only(right: 15.w),
                        child: Center(
                          child: Text(
                            'TOTLA\n￡',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        color: maincolor, // Background color for title row
                        padding: const EdgeInsets.all(8.0) +
                            EdgeInsets.only(right: 15.w),
                        child: Center(
                          child: Text(
                            'ACTION',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    controller.invoice!.viewData!.data!.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            controller.invoice!.viewData!.data!
                                .elementAt(index)
                                .job!
                                .name!,
                            style: GoogleFonts.inter(
                              color: maincolor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DataCell(Text(
                          controller.invoice!.viewData!.data!
                              .elementAt(index)
                              .billedToUser
                              .toString(),
                          style: GoogleFonts.inter(
                            color: maincolor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                        DataCell(Text(
                          DateFormat('dd-MM-yyyy').format(DateTime.parse(
                              controller.invoice!.viewData!.data!
                                  .elementAt(index)
                                  .billedByUser!
                                  .createdAt!)),
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                        DataCell(Text(
                          DateFormat('dd-MM-yyyy').format(DateTime.parse(
                              controller.invoice!.viewData!.data!
                                  .elementAt(index)
                                  .job!
                                  .createdAt!)),
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                        DataCell(Text(
                          '￡ ${controller.invoice!.viewData!.data!.elementAt(index).amount}',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                        DataCell(Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.edit,
                            //   color: Colors.black,
                            //   size: 16.sp,
                            // ),
                            // SizedBox(
                            //   width: 10.w,
                            // ),
                            Icon(
                              Icons.remove_red_eye,
                              color: maincolor,
                              size: 16.sp,
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                  // [

                  // ],
                );
              }
              return SizedBox();
            }),
          ),
          // child: SingleChildScrollView(
          //   child: Table(
          //     border: TableBorder.all(),
          //     children: [
          //       TableRow(
          //         children: [
          //           TableCell(
          //             child:
          // Container(
          //               color: maincolor, // Background color for title row
          //               padding: EdgeInsets.all(8.0),
          //               child: Center(
          //                 child: Text(
          //                   'INVOICE 1',
          //                   style: GoogleFonts.inter(
          //                     color: Colors.white,
          //                     fontSize: 12.sp,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           TableCell(
          //             child: Container(
          //               color: maincolor, // Background color for title row
          //               padding: EdgeInsets.all(8.0),
          //               child: Center(
          //                 child: Text(
          //                   'PAY TO 2',
          //                   style: GoogleFonts.inter(
          //                     color: Colors.white,
          //                     fontSize: 12.sp,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           TableCell(
          //             child: Container(
          //               color: maincolor, // Background color for title row
          //               padding: EdgeInsets.all(8.0),
          //               child: Center(
          //                 child: Text(
          //                   'DATE',
          //                   style: GoogleFonts.inter(
          //                     color: Colors.white,
          //                     fontSize: 12.sp,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           TableCell(
          //             child: Container(
          //               color: maincolor, // Background color for title row
          //               padding: EdgeInsets.all(8.0),
          //               child: Center(
          //                 child: Text(
          //                   'DATE',
          //                   style: GoogleFonts.inter(
          //                     color: Colors.white,
          //                     fontSize: 12.sp,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           TableCell(
          //             child: Container(
          //               width: 200.w,
          //               color: maincolor, // Background color for title row
          //               padding: EdgeInsets.all(8.0),
          //               child: Center(
          //                 child: Text(
          //                   'TOTLA\n￡',
          //                   textAlign: TextAlign.center,
          //                   style: GoogleFonts.inter(
          //                     color: Colors.white,
          //                     fontSize: 12.sp,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           TableCell(
          //             child: Container(
          //               color: maincolor, // Background color for title row
          //               padding: EdgeInsets.all(8.0),
          //               child: Center(
          //                 child: Text(
          //                   'Actions',
          //                   style: GoogleFonts.inter(
          //                     color: Colors.white,
          //                     fontSize: 12.sp,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       TableRow(
          //         children: [
          //           TableCell(
          //             child: Center(
          //               child: Text('Cell 1'),
          //             ),
          //           ),
          //           TableCell(
          //             child: Center(
          //               child: Text('Cell 1'),
          //             ),
          //           ),
          //           TableCell(
          //             child: Center(
          //               child: Text('Cell 2'),
          //             ),
          //           ),
          //           TableCell(
          //             child: Center(
          //               child: Text('Cell 3'),
          //             ),
          //           ),
          //           TableCell(
          //             child: Center(
          //               child: Text('Cell 3'),
          //             ),
          //           ),
          //           TableCell(
          //             child: Center(
          //               child: Text('Cell 3'),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
