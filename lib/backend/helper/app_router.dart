


import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../modules/history/history_binding.dart';
import '../../modules/history/history_view.dart';
import '../../modules/home_page/home_page_binding.dart';
import '../../modules/home_page/home_page_view.dart';
import '../../modules/login/login_binding.dart';
import '../../modules/login/login_view.dart';
import '../../modules/splash/splash_binding.dart';
import '../../modules/splash/splash_view.dart';
import '../../modules/ticket_status/ticket_status_binding.dart';
import '../../modules/ticket_status/ticket_status_view.dart';



class AppRouter {
  static const String splash = '/splash';
  static const String login = '/login_view';
  static const String home = '/home_page_view';
  static const String history = '/history_view';
  static const String ticket_status = '/ticket_status_view';


  static String getSplashRoute() => splash;
  static String getLoginRoute() => login;
  static String getHomeRoute() => home;
  static String getHistory() => history;
  static String getTicket_status() => ticket_status;


  static List<GetPage> routes = [

    GetPage(name: splash, page: () => SplashPage(), binding: SplashBinding()),
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: home, page: () => Home_pagePage(), binding: Home_pageBinding()),
    GetPage(name: history, page: () => HistoryPage(), binding: HistoryBinding()),
    GetPage(name: history, page: () => HistoryPage(), binding: HistoryBinding()),
    GetPage(name: ticket_status, page: () => Ticket_statusPage(), binding: Ticket_statusBinding()),

  ];
}
