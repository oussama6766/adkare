import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import '../../data/models/alarm_model.dart';
import 'notification_service.dart';
import 'audio_service.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  final NotificationService _notificationService = NotificationService();
  final AudioService _audioService = AudioService();

  Future<void> initialize() async {
    await AndroidAlarmManager.initialize();
  }

  Future<void> scheduleAlarm(AlarmModel alarm) async {
    if (!alarm.isActive) return;

    final alarmTime = alarm.getNextAlarmTime();
    final alarmId = alarm.id.hashCode;

    await AndroidAlarmManager.oneShotAt(
      alarmTime,
      alarmId,
      _alarmCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
      alarmClock: true,
    );
  }

  Future<void> cancelAlarm(String alarmId) async {
    await AndroidAlarmManager.cancel(alarmId.hashCode);
    await _notificationService.cancelNotification(alarmId.hashCode);
    await _audioService.stop();
  }

  Future<void> rescheduleAlarm(AlarmModel alarm) async {
    await cancelAlarm(alarm.id);
    if (alarm.isActive && alarm.repeatDays.isNotEmpty) {
      await scheduleAlarm(alarm);
    }
  }

  Future<void> snoozeAlarm(AlarmModel alarm) async {
    final snoozeTime = DateTime.now().add(Duration(minutes: alarm.snoozeMinutes));
    final alarmId = alarm.id.hashCode + 1000; // Different ID for snooze

    await AndroidAlarmManager.oneShotAt(
      snoozeTime,
      alarmId,
      _alarmCallback,
      exact: true,
      wakeup: true,
      alarmClock: true,
    );

    await _audioService.stop();
    await _notificationService.cancelNotification(alarm.id.hashCode);
  }

  @pragma('vm:entry-point')
  static Future<void> _alarmCallback(int id) async {
    // This runs in isolate
    final notificationService = NotificationService();
    await notificationService.initialize();
    
    await notificationService.showAlarmNotification(
      id: id,
      title: '⏰ منبه الأناشيد',
      body: 'حان وقت المنبه',
      payload: id.toString(),
    );
  }
}
