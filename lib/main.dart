import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ildiz/pages/splash_screen.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:ildiz/resource/srting.dart';

/*
void main() {
  runApp(const MyApp());
}
*/

main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),


      home: SplashScreen()
    );


  }*/

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        debugShowFloatingThemeButton: true,
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
              '/': (context) => SplashScreen()
            }));
  }
}
