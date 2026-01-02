import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String? label;
  
  @HiveField(2)
  final String time; // HH:mm format
  
  @HiveField(3)
  final List<int> repeatDays; // 0-6 (Sunday-Saturday)
  
  @HiveField(4)
  final String? nasheedId;
  
  @HiveField(5)
  final String? nasheedTitle;
  
  @HiveField(6)
  final String? nasheedUrl;
  
  @HiveField(7)
  final String? customAudioPath;
  
  @HiveField(8)
  final int volume;
  
  @HiveField(9)
  final bool gradualVolume;
  
  @HiveField(10)
  final bool vibrate;
  
  @HiveField(11)
  final int snoozeMinutes;
  
  @HiveField(12)
  final int maxSnoozeCount;
  
  @HiveField(13)
  final bool isActive;
  
  @HiveField(14)
  final DateTime? lastTriggeredAt;
  
  @HiveField(15)
  final DateTime createdAt;
  
  @HiveField(16)
  final DateTime updatedAt;

  const AlarmModel({
    required this.id,
    this.label,
    required this.time,
    this.repeatDays = const [],
    this.nasheedId,
    this.nasheedTitle,
    this.nasheedUrl,
    this.customAudioPath,
    this.volume = 70,
    this.gradualVolume = true,
    this.vibrate = true,
    this.snoozeMinutes = 5,
    this.maxSnoozeCount = 3,
    this.isActive = true,
    this.lastTriggeredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  AlarmModel copyWith({
    String? id,
    String? label,
    String? time,
    List<int>? repeatDays,
    String? nasheedId,
    String? nasheedTitle,
    String? nasheedUrl,
    String? customAudioPath,
    int? volume,
    bool? gradualVolume,
    bool? vibrate,
    int? snoozeMinutes,
    int? maxSnoozeCount,
    bool? isActive,
    DateTime? lastTriggeredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      label: label ?? this.label,
      time: time ?? this.time,
      repeatDays: repeatDays ?? this.repeatDays,
      nasheedId: nasheedId ?? this.nasheedId,
      nasheedTitle: nasheedTitle ?? this.nasheedTitle,
      nasheedUrl: nasheedUrl ?? this.nasheedUrl,
      customAudioPath: customAudioPath ?? this.customAudioPath,
      volume: volume ?? this.volume,
      gradualVolume: gradualVolume ?? this.gradualVolume,
      vibrate: vibrate ?? this.vibrate,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      maxSnoozeCount: maxSnoozeCount ?? this.maxSnoozeCount,
      isActive: isActive ?? this.isActive,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      label: json['label'],
      time: json['time'],
      repeatDays: (json['repeatDays'] as List?)?.cast<int>() ?? [],
      nasheedId: json['nasheedId'],
      nasheedTitle: json['nasheed']?['title'],
      nasheedUrl: json['nasheed']?['fileUrl'],
      customAudioPath: json['customAudioPath'],
      volume: json['volume'] ?? 70,
      gradualVolume: json['gradualVolume'] ?? true,
      vibrate: json['vibrate'] ?? true,
      snoozeMinutes: json['snoozeMinutes'] ?? 5,
      maxSnoozeCount: json['maxSnoozeCount'] ?? 3,
      isActive: json['isActive'] ?? true,
      lastTriggeredAt: json['lastTriggeredAt'] != null 
          ? DateTime.parse(json['lastTriggeredAt']) 
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'time': time,
      'repeatDays': repeatDays,
      'nasheedId': nasheedId,
      'customAudioPath': customAudioPath,
      'volume': volume,
      'gradualVolume': gradualVolume,
      'vibrate': vibrate,
      'snoozeMinutes': snoozeMinutes,
      'maxSnoozeCount': maxSnoozeCount,
      'isActive': isActive,
    };
  }

  // Get next alarm DateTime
  DateTime getNextAlarmTime() {
    final now = DateTime.now();
    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    
    var alarmTime = DateTime(now.year, now.month, now.day, hour, minute);
    
    if (repeatDays.isEmpty) {
      // One-time alarm
      if (alarmTime.isBefore(now)) {
        alarmTime = alarmTime.add(const Duration(days: 1));
      }
    } else {
      // Repeating alarm
      while (!repeatDays.contains(alarmTime.weekday % 7) || alarmTime.isBefore(now)) {
        alarmTime = alarmTime.add(const Duration(days: 1));
      }
    }
    
    return alarmTime;
  }

  @override
  List<Object?> get props => [
    id, label, time, repeatDays, nasheedId, customAudioPath,
    volume, gradualVolume, vibrate, snoozeMinutes, maxSnoozeCount,
    isActive, lastTriggeredAt, createdAt, updatedAt,
  ];
}
