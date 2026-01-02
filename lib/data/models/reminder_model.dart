import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 3)
class ReminderModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String? adhkarId;
  
  @HiveField(2)
  final String type; // 'morning', 'evening', 'custom'
  
  @HiveField(3)
  final String? label;
  
  @HiveField(4)
  final String time; // HH:mm format
  
  @HiveField(5)
  final List<int> repeatDays;
  
  @HiveField(6)
  final bool isActive;
  
  @HiveField(7)
  final String notificationTitle;
  
  @HiveField(8)
  final String? notificationBody;
  
  @HiveField(9)
  final DateTime? lastTriggeredAt;
  
  @HiveField(10)
  final DateTime createdAt;
  
  @HiveField(11)
  final DateTime updatedAt;

  const ReminderModel({
    required this.id,
    this.adhkarId,
    this.type = 'custom',
    this.label,
    required this.time,
    this.repeatDays = const [0, 1, 2, 3, 4, 5, 6],
    this.isActive = true,
    this.notificationTitle = 'تذكير الأذكار',
    this.notificationBody,
    this.lastTriggeredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  ReminderModel copyWith({
    String? id,
    String? adhkarId,
    String? type,
    String? label,
    String? time,
    List<int>? repeatDays,
    bool? isActive,
    String? notificationTitle,
    String? notificationBody,
    DateTime? lastTriggeredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      adhkarId: adhkarId ?? this.adhkarId,
      type: type ?? this.type,
      label: label ?? this.label,
      time: time ?? this.time,
      repeatDays: repeatDays ?? this.repeatDays,
      isActive: isActive ?? this.isActive,
      notificationTitle: notificationTitle ?? this.notificationTitle,
      notificationBody: notificationBody ?? this.notificationBody,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      adhkarId: json['adhkarId'],
      type: json['type'] ?? 'custom',
      label: json['label'],
      time: json['time'],
      repeatDays: (json['repeatDays'] as List?)?.cast<int>() ?? [0, 1, 2, 3, 4, 5, 6],
      isActive: json['isActive'] ?? true,
      notificationTitle: json['notificationTitle'] ?? 'تذكير الأذكار',
      notificationBody: json['notificationBody'],
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
      'adhkarId': adhkarId,
      'type': type,
      'label': label,
      'time': time,
      'repeatDays': repeatDays,
      'isActive': isActive,
      'notificationTitle': notificationTitle,
      'notificationBody': notificationBody,
    };
  }

  @override
  List<Object?> get props => [
    id, adhkarId, type, label, time, repeatDays,
    isActive, notificationTitle, notificationBody,
    lastTriggeredAt, createdAt, updatedAt,
  ];
}
