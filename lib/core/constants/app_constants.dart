class AppConstants {
  // API
  static const String baseUrl = 'http://localhost:3000/api';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String settingsKey = 'app_settings';
  static const String themeKey = 'theme_mode';
  static const String localeKey = 'app_locale';
  static const String lastSyncKey = 'last_sync';
  
  // Hive Boxes
  static const String alarmsBox = 'alarms_box';
  static const String remindersBox = 'reminders_box';
  static const String adhkarBox = 'adhkar_box';
  static const String nasheedsBox = 'nasheeds_box';
  
  // Alarm Settings
  static const int defaultVolume = 70;
  static const int defaultSnoozeDuration = 5; // minutes
  static const int maxSnoozeTimes = 3;
  static const int gradualVolumeSteps = 10;
  static const Duration gradualVolumeDuration = Duration(seconds: 30);
  
  // Notification Channels
  static const String alarmChannelId = 'alarm_channel';
  static const String alarmChannelName = 'المنبهات';
  static const String alarmChannelDescription = 'إشعارات المنبهات';
  
  static const String reminderChannelId = 'reminder_channel';
  static const String reminderChannelName = 'التذكيرات';
  static const String reminderChannelDescription = 'تذكيرات الأذكار';
  
  // Adhkar Categories
  static const List<String> adhkarCategories = [
    'morning',
    'evening',
    'sleep',
    'wake',
    'prayer',
    'general',
    'food',
    'travel',
  ];
  
  // Days of Week (Arabic)
  static const List<String> daysAr = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];
  
  // Days of Week (English)
  static const List<String> daysEn = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
}
