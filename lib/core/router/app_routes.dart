abstract final class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String history = '/history';
  static const String servicesMenu = '/services-menu';
  static const String services = '/services';
  static const String nearbyCourier = '/nearby-courier';
  static const String trackOrder = '/track-order';
  static const String calculateParcel = '/calculate-parcel';
  static const String calculateResult = '/calculate-result';
  static const String shipParcel = '/ship-parcel';
  static const String shipParcelDetails = '/ship-parcel/details';
  static const String shipPayment = '/ship-parcel/payment';
  static const String menu = '/menu';
  static const String profile = '/profile';
  static const String faq = '/faq';
  static const String help = '/help';
  static const String chat = '/chat';
  static const String notification = '/notification';
  static const String payment = '/payment';
  static const String security = '/security';
  static const String settings = '/settings';

  static String chatDetail(String id) => '$chat/$id';
}