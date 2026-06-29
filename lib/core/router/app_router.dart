import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/features/auth/login_screen.dart';
import 'package:fast_courier_app/features/auth/sign_up_screen.dart';
import 'package:fast_courier_app/features/history/history_screen.dart';
import 'package:fast_courier_app/features/home/home_screen.dart';
import 'package:fast_courier_app/features/nearby_courier/nearby_courier_screen.dart';
import 'package:fast_courier_app/features/calculate_parcel/calculate_parcel_screen.dart';
import 'package:fast_courier_app/features/calculate_parcel/calculate_result_screen.dart';
import 'package:fast_courier_app/features/track_order/track_order_screen.dart';
import 'package:fast_courier_app/features/services/services_menu_screen.dart';
import 'package:fast_courier_app/features/services/services_screen.dart';
import 'package:fast_courier_app/features/onboarding/onboarding_screen.dart';
import 'package:fast_courier_app/features/splash/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.servicesMenu,
        builder: (context, state) => const ServicesMenuScreen(),
      ),
      GoRoute(
        path: AppRoutes.services,
        builder: (context, state) => const ServicesScreen(),
      ),
      GoRoute(
        path: AppRoutes.nearbyCourier,
        builder: (context, state) => const NearbyCourierScreen(),
      ),
      GoRoute(
        path: AppRoutes.trackOrder,
        builder: (context, state) => const TrackOrderScreen(),
      ),
      GoRoute(
        path: AppRoutes.calculateParcel,
        builder: (context, state) => const CalculateParcelScreen(),
      ),
      GoRoute(
        path: AppRoutes.calculateResult,
        builder: (context, state) => const CalculateResultScreen(),
      ),
    ],
  );
}