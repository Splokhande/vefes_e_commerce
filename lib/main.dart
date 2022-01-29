import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vefes_e_commerce/constant.dart';
import 'package:vefes_e_commerce/screen/product_list.dart';
import 'package:vefes_e_commerce/sqflite/helper.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final dbHelper = MyCartHelper.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorCodes = {
      50: kPrimaryColor.withOpacity(0.1),
      100: kPrimaryColor.withOpacity(0.2),
      200: kPrimaryColor.withOpacity(0.3),
      300: kPrimaryColor.withOpacity(0.4),
      400: kPrimaryColor.withOpacity(0.5),
      500: kPrimaryColor.withOpacity(0.6),
      600: kPrimaryColor.withOpacity(0.7),
      700: kPrimaryColor.withOpacity(0.8),
      800: kPrimaryColor.withOpacity(0.9),
      900: kPrimaryColor.withOpacity(1),
    };

    MaterialColor primaryColor = MaterialColor(0xffF67280, colorCodes);
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        builder: () => GetMaterialApp(
              supportedLocales: [
                Locale('en'),
              ],
              title: 'VEFES E-COM',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: primaryColor,
                  backgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
                  fontFamily: 'SEGOEUI'),
              builder: (context, widget) {
                ScreenUtil.setContext(context);
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!);
              },
              home: ProductList(),
            ));
  }
}
