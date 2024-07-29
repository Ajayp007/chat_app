import 'package:chat_app/screen/auth/view/signin_screen.dart';
import 'package:chat_app/screen/auth/view/signup_screen.dart';
import 'package:chat_app/screen/chat/view/chat_screen.dart';
import 'package:chat_app/screen/personal/view/personal_screen.dart';
import 'package:chat_app/screen/home/view/home_screen.dart';
import 'package:chat_app/screen/user/view/users_screen.dart';
import 'package:flutter/material.dart';

import '../screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder> appRoutes ={
  '/' :(c1) => const SplashScreen(),
  'signIn' :(c1) => const SigninScreen(),
  'signUp' :(c1) => const SignupScreen(),
  'home' :(c1) => const HomeScreen(),
  'user' :(c1) => const PersonalDetailScreen(),
  'all' :(c1) => const UsersScreen(),
  'chat' :(c1) => const ChatScreen(),
};