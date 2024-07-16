import 'package:chat_app/screen/auth/view/signin_screen.dart';
import 'package:chat_app/screen/auth/view/signup_screen.dart';
import 'package:chat_app/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

import '../screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder> appRoutes ={
  '/' :(c1) => const SplashScreen(),
  'signIn' :(c1) => const SigninScreen(),
  'signUp' :(c1) => const SignupScreen(),
  'home' :(c1) => const HomeScreen(),
};