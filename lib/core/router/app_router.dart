import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/features/auth/login_screen.dart';
import 'package:fast_courier_app/features/auth/sign_up_screen.dart';
import 'package:fast_courier_app/features/history/history_screen.dart';
import 'package:fast_courier_app/features/home/home_screen.dart';
import 'package:fast_courier_app/features/nearby_courier/nearby_courier_screen.dart';
import 'package:fast_courier_app/features/calculate_parcel/calculate_parcel_screen.dart';
import 'package:fast_courier_app/features/ship_parcel/ship_parcel_details_screen.dart';
import 'package:fast_courier_app/features/ship_parcel/ship_parcel_screen.dart';
import 'package:fast_courier_app/features/faq/faq_screen.dart';
import 'package:fast_courier_app/features/chat/chat_detail_screen.dart';
import 'package:fast_courier_app/features/chat/chat_screen.dart';
import 'package:fast_courier_app/features/help/help_screen.dart';
import 'package:fast_courier_app/features/notification/notification_screen.dart';
import 'package:fast_courier_app/features/payment/payment_screen.dart';
import 'package:fast_courier_app/features/security/security_screen.dart';
import 'package:fast_courier_app/features/settings/settings_screen.dart';
import 'package:fast_courier_app/features/menu/menu_screen.dart';
import 'package:fast_courier_app/features/profile/profile_screen.dart';
import 'package:fast_courier_app/features/ship_parcel/ship_payment_screen.dart';
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
      GoRoute(
        path: AppRoutes.shipParcel,
        builder: (context, state) => const ShipParcelScreen(),
      ),
      GoRoute(
        path: AppRoutes.shipParcelDetails,
        builder: (context, state) => const ShipParcelDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.shipPayment,
        builder: (context, state) => const ShipPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.menu,
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.faq,
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        path: AppRoutes.help,
        builder: (context, state) => const HelpScreen(),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) => const ChatScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ChatDetailScreen(conversationId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.notification,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.payment,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.security,
        builder: (context, state) => const SecurityScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}