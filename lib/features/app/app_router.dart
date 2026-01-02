import 'package:flutter/material.dart';

import '../splash/splash_screen.dart';
import '../home/home_screen.dart';
import '../alarms/alarms_screen.dart';
import '../alarms/alarm_editor_screen.dart';
import '../adhkar/adhkar_categories_screen.dart';
import '../adhkar/adhkar_details_screen.dart';
import '../reminders/reminders_screen.dart';
import '../library/library_screen.dart';
import '../settings/settings_screen.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String alarms = '/alarms';
  static const String alarmEditor = '/alarms/editor';
  static const String adhkarCategories = '/adhkar';
  static const String adhkarDetails = '/adhkar/details';
  static const String reminders = '/reminders';
  static const String library = '/library';
  static const String settings = '/settings';
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen());
      
      case home:
        return _buildRoute(const HomeScreen());
      
      case alarms:
        return _buildRoute(const AlarmsScreen());
      
      case alarmEditor:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(AlarmEditorScreen(
          alarmId: args?['alarmId'],
        ));
      
      case adhkarCategories:
        return _buildRoute(const AdhkarCategoriesScreen());
      
      case adhkarDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(AdhkarDetailsScreen(
          category: args['category'],
          categoryName: args['categoryName'],
        ));
      
      case reminders:
        return _buildRoute(const RemindersScreen());
      
      case library:
        return _buildRoute(const LibraryScreen());
      
      case AppRouter.settings:
        return _buildRoute(const SettingsScreen());
      
      case login:
        return _buildRoute(const LoginScreen());
      
      case register:
        return _buildRoute(const RegisterScreen());
      
      default:
        return _buildRoute(Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }

  static MaterialPageRoute _buildRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
