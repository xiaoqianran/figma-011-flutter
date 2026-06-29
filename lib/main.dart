import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fast_courier_app/app.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.black1,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(FastCourierApp());
}