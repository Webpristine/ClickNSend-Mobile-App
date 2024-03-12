import 'dart:io';

import 'package:click_send/common/app_colors.dart';
import 'package:click_send/screens/bids/logic/bidsprovider.dart';
import 'package:click_send/screens/companyinfo/logic/companyinfoprovider.dart';
import 'package:click_send/screens/delivery/logic/deliveryprovider.dart';
import 'package:click_send/screens/driver/logic/adddriverprovider.dart';
import 'package:click_send/screens/driverinfo/logic/driverinfoprovider.dart';
import 'package:click_send/screens/forgot/logic/forgotpasswordprovider.dart';
import 'package:click_send/screens/home/logic/homeprovider.dart';
import 'package:click_send/screens/calendar/logic/calendarprovider.dart';
import 'package:click_send/screens/invoice/logic/invoiceprovider.dart';
import 'package:click_send/screens/job/logic/jobprovider.dart';

import 'package:click_send/screens/login/logic/loginprovider.dart';
import 'package:click_send/screens/notification/logic/notificationprovider.dart';
import 'package:click_send/screens/profile/logic/profileprovider.dart';
import 'package:click_send/screens/search/logic/searchprovider.dart';
import 'package:click_send/screens/signup/logic/signupprovider.dart';
import 'package:click_send/screens/splash/splashscreen.dart';
import 'package:click_send/screens/subscription/logic/subscriptionprovider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51OA4eWEJAEZGamkUJF6j9NmyvMCQAdnhMsNwkJIxerHfisIRxRoPTzsxSdzQzkhGQWBybDiTkjBTQaGgKriMpA1c00N1k3EldL";
  preferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();

  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((value) {
    print("token is $value");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the notification message when the app is in the foreground
    print('Message clicked: ${message.notification!.body}');
  });

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeliveryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InvoiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompanyInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubscriptionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DriverInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddDriverProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BidsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalendarProvider(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(
                  useMaterial3: true,
                ),
                home: const SplashScreen(),
              ),
            );
          }),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  message.data;

  print(
    "Handling a background message: ${message.notification}",
  );
}
