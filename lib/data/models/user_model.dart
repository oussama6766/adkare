import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? name;
  final UserSettings settings;
  final DateTime? lastSyncAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    required this.settings,
    this.lastSyncAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      settings: UserSettings.fromJson(json['settings'] ?? {}),
      lastSyncAt: json['lastSyncAt'] != null 
          ? DateTime.parse(json['lastSyncAt']) 
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'settings': settings.toJson(),
      'lastSyncAt': lastSyncAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    UserSettings? settings,
    DateTime? lastSyncAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      settings: settings ?? this.settings,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, email, name, settings, lastSyncAt, createdAt, updatedAt];
}

class UserSettings extends Equatable {
  final String language;
  final String theme;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final int defaultVolume;
  final bool gradualVolume;
  final int snoozeDuration;

  const UserSettings({
    this.language = 'ar',
    this.theme = 'light',
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.defaultVolume = 70,
    this.gradualVolume = true,
    this.snoozeDuration = 5,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      language: json['language'] ?? 'ar',
      theme: json['theme'] ?? 'light',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      soundEnabled: json['soundEnabled'] ?? true,
      vibrationEnabled: json['vibrationEnabled'] ?? true,
      defaultVolume: json['defaultVolume'] ?? 70,
      gradualVolume: json['gradualVolume'] ?? true,
      snoozeDuration: json['snoozeDuration'] ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'theme': theme,
      'notificationsEnabled': notificationsEnabled,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'defaultVolume': defaultVolume,
      'gradualVolume': gradualVolume,
      'snoozeDuration': snoozeDuration,
    };
  }

  UserSettings copyWith({
    String? language,
    String? theme,
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    int? defaultVolume,
    bool? gradualVolume,
    int? snoozeDuration,
  }) {
    return UserSettings(
      language: language ?? this.language,
      theme: theme ?? this.theme,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      defaultVolume: defaultVolume ?? this.defaultVolume,
      gradualVolume: gradualVolume ?? this.gradualVolume,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
    );
  }

  @override
  List<Object?> get props => [
    language, theme, notificationsEnabled, soundEnabled,
    vibrationEnabled, defaultVolume, gradualVolume, snoozeDuration,
  ];
}
