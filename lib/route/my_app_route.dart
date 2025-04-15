import 'package:get/get.dart';
import 'package:laundryku/favorite/bindings/favorite_binding.dart';
import 'package:laundryku/favorite/pages/favorite_page.dart';
import 'package:laundryku/home/bindings/home_binding.dart';
import 'package:laundryku/home/pages/home_page.dart';
import 'package:laundryku/laundry/laundryList/bindings/laundry_list_binding.dart';
import 'package:laundryku/laundry/laundryList/pages/laundry_list_page.dart';
import 'package:laundryku/login/bindings/login_binding.dart';
import 'package:laundryku/login/pages/login_page.dart';
import 'package:laundryku/navbar/bottom_nav_bar_page.dart';
import 'package:laundryku/navbar/bottom_nav_binding.dart';
import 'package:laundryku/order/order/pages/order_page.dart';
import 'package:laundryku/order/orderHistory/pages/order_history_page.dart';
import 'package:laundryku/pesan/bindings/pesan_binding.dart';
import 'package:laundryku/pesan/pages/pesan_page.dart';
import 'package:laundryku/profile/bindings/profile_binding.dart';
import 'package:laundryku/profile/pages/edit_page.dart';
import 'package:laundryku/profile/pages/profile_page.dart';
import 'package:laundryku/profile/pages/setting_page.dart';
import 'package:laundryku/register/bindings/register_binding.dart';
import 'package:laundryku/register/pages/register_page.dart';
import 'package:laundryku/splashScreen/splash_screen.dart';
import 'package:laundryku/tagihan/bindings/tagihan_binding.dart';
import 'package:laundryku/tagihan/pages/tagihan_page.dart';

class MyappRoute {
  //Login
  static const splashScreen = '/splash';
  static const loginPage = '/login';
  static const registerPage = '/register';
  static const navbar = '/navbar';

  //home
  static const homePage = '/home';

  //laundry
  static const laundryListPage = '/laundryList';
  static const laundryDetailPage = '/laundryDetail';

  //tagihan
  static const tagihanPage = '/tagihan';

  //favorite
  static const favoritePage = '/favorite';

  //pesan
  static const pesanPage = '/pesan';

  //profile
  static const profilePage = '/profile';
  static const profileSettingPage = '/profileSetting';
  static const profileEditPage = '/profileEdit';

  //order
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
    //home
    GetPage(
        name: MyappRoute.homePage,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),

    //laundry
    GetPage(
        name: MyappRoute.laundryListPage,
        page: () => LaundryListPage(),
        binding: LaundryListBinding(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),

    //tagihan
    GetPage(
        name: MyappRoute.tagihanPage,
        page: () => TagihanPage(),
        binding: TagihanBinding(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),

    //favorite
    GetPage(
        name: MyappRoute.favoritePage,
        page: () => FavoritePage(),
        binding: FavoriteBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 450)),

    //pesan
    GetPage(
        name: MyappRoute.pesanPage,
        page: () => PesanPage(),
        binding: PesanBinding(),
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
        name: MyappRoute.profileSettingPage,
        page: () => ProfileSettingPage(),
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 450)),
    GetPage(
        name: MyappRoute.profileEditPage,
        page: () => ProfileEditPage(),
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
