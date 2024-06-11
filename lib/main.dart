import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ildiz/pages/sample_page.dart';
import 'package:ildiz/pages/splash_screen.dart';
import 'package:ildiz/resource/srting.dart';
import 'controllers/get_controller.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return ScreenUtilInit(
        designSize: Size(_getController.width.value, _getController.height.value),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return AdaptiveTheme(
              debugShowFloatingThemeButton: false,
              initial: AdaptiveThemeMode.dark,
              light: ThemeData.light(useMaterial3: true),
              dark: ThemeData.dark(useMaterial3: true),
              builder: (theme, darkTheme) => GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Ildiz Kitoblari',
                  theme: theme,
                  translations: LocaleString(),
                  locale: const Locale('uz', 'UZ'),
                  darkTheme: darkTheme,
                  //home: SplashScreen()
                  routes: {
                    '/': (context) => SplashScreen(),
                    '/ok': (context) => SamplePage()
                  })
          );
        });
  }
}