import 'package:firebase_core/firebase_core.dart';
import 'package:firefighter/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';

import 'views/auth/login_screen.dart';
import 'views/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  var storage = GetStorage();
  var uType = storage.read('uType');
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Fighters',
      defaultTransition: Transition.fade,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
      home: uType == null ? Login() : HomeScreen(uType: uType),
    ),
  );
}
