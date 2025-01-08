import 'package:contact/applications/bindings/detail.dart';
import 'package:contact/applications/bindings/home.dart';
import 'package:contact/applications/bindings/login.dart';
import 'package:contact/applications/bindings/register.dart';
import 'package:contact/applications/bindings/splash.dart';
import 'package:contact/data/models/contact.dart';
import 'package:contact/presentations/auth/views/login.dart';
import 'package:contact/presentations/auth/views/register.dart';
import 'package:contact/presentations/detail/views/detail.dart';
import 'package:contact/presentations/home/views/home.dart';
import 'package:contact/presentations/splash/views/splash.dart';
import 'package:contact/routes/routename.dart';
import 'package:get/get.dart';

class PagesRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: RoutesName.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutesName.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RoutesName.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesName.detail,
      page: () => const ContactDetail(),
      binding: DetailBinding(),
      arguments: Contact,
    ),
  ];
}
