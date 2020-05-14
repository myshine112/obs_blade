import 'package:flutter/material.dart';
import 'package:obs_station/views/info/info.dart';
import 'package:obs_station/views/dashboard/dashboard.dart';
import 'package:obs_station/views/home/home.dart';
import 'package:obs_station/views/settings/settings.dart';

import '../tab_base.dart';

enum AppRoutingKeys { TABS }

enum HomeTabRoutingKeys {
  LANDING,
  DASHBOARD,
}

enum InfoTabRoutingKeys {
  LANDING,
}

enum SettingsTabRoutingKeys {
  LANDING,
}

extension AppRoutingKeysFunctions on AppRoutingKeys {
  String get route => const {
        AppRoutingKeys.TABS: '/tabs',
      }[this];
}

extension HomeTabRoutingKeysFunctions on HomeTabRoutingKeys {
  String get route => {
        HomeTabRoutingKeys.LANDING: AppRoutingKeys.TABS.route + '/home',
        HomeTabRoutingKeys.DASHBOARD:
            AppRoutingKeys.TABS.route + '/home/dashboard',
      }[this];
}

extension InfoTabRoutingKeysFunctions on InfoTabRoutingKeys {
  String get route => {
        InfoTabRoutingKeys.LANDING: AppRoutingKeys.TABS.route + '/info',
      }[this];
}

extension SettingsTabRoutingKeysFunctions on SettingsTabRoutingKeys {
  String get route => {
        SettingsTabRoutingKeys.LANDING: AppRoutingKeys.TABS.route + '/settings',
      }[this];
}

/// Used to summarize routing tasks and information at one point
class RoutingHelper {
  static String currentHomeTabRoute = HomeTabRoutingKeys.LANDING.route;
  static String currentSettingsTabRoute = SettingsTabRoutingKeys.LANDING.route;
  static String currentLibraryTabRoute = InfoTabRoutingKeys.LANDING.route;

  static Map<String, Widget Function(BuildContext)> homeTabRoutes = {
    HomeTabRoutingKeys.LANDING.route: (_) => HomeView(),
    HomeTabRoutingKeys.DASHBOARD.route: (_) => DashboardView(),
  };

  static Map<String, Widget Function(BuildContext)> infoTabRoutes = {
    InfoTabRoutingKeys.LANDING.route: (_) => InfoView(),
  };

  static Map<String, Widget Function(BuildContext)> settingsTabRoutes = {
    SettingsTabRoutingKeys.LANDING.route: (_) => SettingsView(),
  };

  static Map<String, Widget Function(BuildContext)> appRoutes = {
    AppRoutingKeys.TABS.route: (_) => TabBase(),
  };
}
