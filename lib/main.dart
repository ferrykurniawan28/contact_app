import 'package:contact/applications/bindings/splash.dart';
import 'package:contact/routes/routename.dart';
import 'package:contact/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contact List',
      initialBinding: SplashBinding(),
      initialRoute: RoutesName.splash,
      getPages: PagesRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
