import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'adhkar_model.g.dart';

@HiveType(typeId: 1)
class AdhkarModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String category;
  
  @HiveField(2)
  final String textAr;
  
  @HiveField(3)
  final String? textEn;
  
  @HiveField(4)
  final String? reference;
  
  @HiveField(5)
  final int defaultCount;
  
  @HiveField(6)
  final String? audioUrl;
  
  @HiveField(7)
  final int orderNum;
  
  @HiveField(8)
  final String? reward;

  const AdhkarModel({
    required this.id,
    required this.category,
    required this.textAr,
    this.textEn,
    this.reference,
    this.defaultCount = 1,
    this.audioUrl,
    this.orderNum = 0,
    this.reward,
  });

  factory AdhkarModel.fromJson(Map<String, dynamic> json) {
    return AdhkarModel(
      id: json['id'],
      category: json['category'],
      textAr: json['textAr'],
      textEn: json['textEn'],
      reference: json['reference'],
      defaultCount: json['defaultCount'] ?? 1,
      audioUrl: json['audioUrl'],
      orderNum: json['orderNum'] ?? 0,
      reward: json['reward'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'textAr': textAr,
      'textEn': textEn,
      'reference': reference,
      'defaultCount': defaultCount,
      'audioUrl': audioUrl,
      'orderNum': orderNum,
      'reward': reward,
    };
  }

  @override
  List<Object?> get props => [
    id, category, textAr, textEn, reference,
    defaultCount, audioUrl, orderNum, reward,
  ];
}

@HiveType(typeId: 2)
class AdhkarCategoryModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String nameAr;
  
  @HiveField(2)
  final String nameEn;
  
  @HiveField(3)
  final String icon;
  
  @HiveField(4)
  final int count;

  const AdhkarCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.icon,
    this.count = 0,
  });

  factory AdhkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AdhkarCategoryModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      icon: json['icon'],
      count: json['count'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, nameAr, nameEn, icon, count];
}
