import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nariii/controllers/theme_controller.dart';
import 'package:nariii/route/route_genrator.dart';
import 'package:nariii/route/routes.dart';
import 'package:nariii/theme/app_theme.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nariii',
      initialRoute: Routes.getstarted,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.find<ThemeController>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}


