import 'package:click_send/common/bottomnavigationbar.dart';
import 'package:click_send/screens/home/homescreen.dart';
import 'package:click_send/screens/search/logic/searchprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: const Icon(Icons.arrow_back)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child:
              Consumer<SearchProvider>(builder: (context, controller, child) {
            return Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: TextFormField(
                onChanged: (p0) {
                  if (p0.length > 2) {
                    controller.fetchSuggestions(p0);
                  }
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search location...",
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xffC8C8C8),
                    fontStyle: FontStyle.italic,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: const Color(0xffB9C0C9),
                    size: 23.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: const Color(0xffB9C0C9),
                    size: 23.sp,
                  ),
                  filled: true,
                  fillColor: const Color(0xffF8F9FD),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffB9C0C9),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffB9C0C9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffB9C0C9),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffB9C0C9),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffB9C0C9),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffB9C0C9),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Consumer<SearchProvider>(builder: (context, controller, child) {
          if (controller.locationSuggestion != null) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffEDEDED),
                            width: 1,
                          )),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: const Color(0xff626A7E),
                            size: 18.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.locationSuggestion!.predictions
                                      .elementAt(index)
                                      .structuredFormatting
                                      .mainText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff626A7E),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  controller.locationSuggestion!.predictions
                                      .elementAt(index)
                                      .structuredFormatting
                                      .secondaryText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff9B9B9B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemCount: controller.locationSuggestion!.predictions.length);
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
