import 'package:flutter/material.dart';

import '../app/app_router.dart';

class AdhkarCategoriesScreen extends StatelessWidget {
  const AdhkarCategoriesScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {'id': 'morning', 'nameAr': 'أذكار الصباح', 'icon': Icons.wb_sunny, 'color': Colors.orange},
    {'id': 'evening', 'nameAr': 'أذكار المساء', 'icon': Icons.nights_stay, 'color': Colors.indigo},
    {'id': 'sleep', 'nameAr': 'أذكار النوم', 'icon': Icons.bedtime, 'color': Colors.purple},
    {'id': 'wake', 'nameAr': 'أذكار الاستيقاظ', 'icon': Icons.alarm, 'color': Colors.teal},
    {'id': 'prayer', 'nameAr': 'أذكار الصلاة', 'icon': Icons.mosque, 'color': Colors.green},
    {'id': 'general', 'nameAr': 'أذكار عامة', 'icon': Icons.book, 'color': Colors.blue},
    {'id': 'food', 'nameAr': 'أذكار الطعام', 'icon': Icons.restaurant, 'color': Colors.amber},
    {'id': 'travel', 'nameAr': 'أذكار السفر', 'icon': Icons.flight, 'color': Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأذكار'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _CategoryCard(
            id: category['id'],
            name: category['nameAr'],
            icon: category['icon'],
            color: category['color'],
            onTap: () => Navigator.pushNamed(
              context,
              AppRouter.adhkarDetails,
              arguments: {
                'category': category['id'],
                'categoryName': category['nameAr'],
              },
            ),
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
