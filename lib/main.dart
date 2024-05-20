import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projects/core/app_theme.dart';
import 'package:projects/constants/constants.dart';
import 'package:projects/views/bottom_nav.dart';

void main() async{
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ScreenUtilInit(
            designSize: const Size(390.0, 844.0),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    fontFamily: FONT_FAMILY,
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
                    useMaterial3: true,
                    scaffoldBackgroundColor: AppColors.backgroundColor),
                home: const BottomNavBar(),
              );
            }));
  }
}

