import 'package:chat_app/utils/app_routes.dart';
import 'package:chat_app/utils/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationServices.notify.initNotification();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    ),
  );
}
