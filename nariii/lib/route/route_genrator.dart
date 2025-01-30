
import 'package:flutter/material.dart';
import 'package:nariii/pages/chat_screen.dart';
import 'package:nariii/pages/getstartedscreen.dart';
import 'package:nariii/pages/homescreen.dart';
import 'package:nariii/pages/loginscreen.dart';
import 'package:nariii/pages/profilescreen.dart';
import 'package:nariii/route/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;

    switch (settings.name) {
      case Routes.getstarted:
        widgetScreen = const GetStartedScreen();
        break;
      case Routes.login:
        widgetScreen = const LoginScreen();
        break;  
      case Routes.home:
        widgetScreen = const HomeScreen();
        break;
      case Routes.profile:
        widgetScreen =  ProfileScreen();
        break;
      case Routes.chatscreen:
        widgetScreen = ChatScreen(userName: '', userImage: '', isOnline: false);
        break;    

      default:
        widgetScreen = _errorRoute();
    }

    return PageRouteBuilder(
        settings: settings, pageBuilder: (_, __, ___) => widgetScreen);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text(
          'No such screen found in route generator',
        ),
      ),
    );
  }
}