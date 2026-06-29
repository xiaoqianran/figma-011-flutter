import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/shared/widgets/app_bottom_nav_bar.dart';

/// Navigates to the route for a bottom-nav tab.
void navigateToAppTab(BuildContext context, AppNavTab tab) {
  switch (tab) {
    case AppNavTab.home:
      context.go(AppRoutes.home);
    case AppNavTab.history:
      context.go(AppRoutes.history);
    case AppNavTab.chat:
      break;
    case AppNavTab.menu:
      context.go(AppRoutes.menu);
  }
}

/// Maps the current route path to the active bottom-nav tab.
AppNavTab appTabFromLocation(String location) {
  if (location.startsWith(AppRoutes.history)) {
    return AppNavTab.history;
  }
  if (location.startsWith(AppRoutes.menu)) {
    return AppNavTab.menu;
  }
  return AppNavTab.home;
}