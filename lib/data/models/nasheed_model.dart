import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'nasheed_model.g.dart';

@HiveType(typeId: 4)
class NasheedModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String? titleEn;
  
  @HiveField(3)
  final String? artist;
  
  @HiveField(4)
  final int? duration; // in seconds
  
  @HiveField(5)
  final String fileUrl;
  
  @HiveField(6)
  final String? thumbnailUrl;
  
  @HiveField(7)
  final String category;
  
  @HiveField(8)
  final bool isDefault;
  
  @HiveField(9)
  final int playCount;

  const NasheedModel({
    required this.id,
    required this.title,
    this.titleEn,
    this.artist,
    this.duration,
    required this.fileUrl,
    this.thumbnailUrl,
    this.category = 'general',
    this.isDefault = false,
    this.playCount = 0,
  });

  factory NasheedModel.fromJson(Map<String, dynamic> json) {
    return NasheedModel(
      id: json['id'],
      title: json['title'],
      titleEn: json['titleEn'],
      artist: json['artist'],
      duration: json['duration'],
      fileUrl: json['fileUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      category: json['category'] ?? 'general',
      isDefault: json['isDefault'] ?? false,
      playCount: json['playCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'titleEn': titleEn,
      'artist': artist,
      'duration': duration,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'isDefault': isDefault,
      'playCount': playCount,
    };
  }

  String get formattedDuration {
    if (duration == null) return '--:--';
    final minutes = duration! ~/ 60;
    final seconds = duration! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [
    id, title, titleEn, artist, duration, fileUrl,
    thumbnailUrl, category, isDefault, playCount,
  ];
}
