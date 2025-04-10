import 'package:get/get.dart';
import 'package:laundryku/favorite/bindings/favorite_binding.dart';
import 'package:laundryku/favorite/pages/favorite_page.dart';
import 'package:laundryku/login/bindings/login_binding.dart';
import 'package:laundryku/login/pages/login_page.dart';
import 'package:laundryku/navbar/bottom_nav_bar_page.dart';
import 'package:laundryku/navbar/navbar_binding.dart';
import 'package:laundryku/order/order/pages/order_page.dart';
import 'package:laundryku/profile/bindings/profile_binding.dart';
import 'package:laundryku/profile/pages/edit_page.dart';
import 'package:laundryku/order/orderhistory/pages/order_history_page.dart';
import 'package:laundryku/profile/pages/profile_page.dart';
import 'package:laundryku/profile/pages/setting_page.dart';
import 'package:laundryku/register/bindings/register_binding.dart';
import 'package:laundryku/register/pages/register_page.dart';
import 'package:laundryku/splashScreen/splash_screen.dart';

class MyappRoute {
  static const splashScreen = '/splash';
  static const loginPage = '/login';
  static const registerPage = '/register';
  static const navbar = '/navbar';
  static const favoritePage = '/favorite';
  static const profilePage = '/profile';
  static const settingProfilePage = '/settingProfile';
  static const editProfilePage = '/editProfile';
  static const orderhistoryPage = '/orderHistory';
  static const orderPage = '/order';

  static final page = [
    GetPage(name: MyappRoute.splashScreen, page: () => SplashScreen()),

    //Login
    GetPage(
        name: MyappRoute.loginPage,
        page: () => LoginPage(),
        binding: LoginBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),
    GetPage(
        name: MyappRoute.registerPage,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),
    GetPage(
        name: MyappRoute.navbar,
        page: () => BottomNavBarPage(),
        binding: NavbarBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),

    //favorite
    GetPage(
        name: MyappRoute.favoritePage,
        page: () => FavoritePage(),
        binding: FavoriteBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),

    //profile
    GetPage(
        name: MyappRoute.profilePage,
        page: () => ProfilePage(),
        binding: ProfileBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),
    GetPage(
        name: MyappRoute.settingProfilePage,
        page: () => SettingProfilePage(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),
    GetPage(
        name: MyappRoute.editProfilePage,
        page: () => EditProfilePage(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),

    //order
    GetPage(
        name: MyappRoute.orderPage,
        page: () => OrderPage(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),
    GetPage(
        name: MyappRoute.orderhistoryPage,
        page: () => OrderHistoryPage(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),
  ];
}
