import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  // Sample data - replace with actual data from API
  static const List<Map<String, dynamic>> _nasheeds = [
    {
      'id': '1',
      'title': 'طلع البدر علينا',
      'artist': 'تراثي',
      'duration': '3:45',
      'category': 'general',
    },
    {
      'id': '2',
      'title': 'يا طيبة',
      'artist': 'أناشيد إسلامية',
      'duration': '4:20',
      'category': 'general',
    },
    {
      'id': '3',
      'title': 'اللهم صل على محمد',
      'artist': 'تلاوة',
      'duration': '2:15',
      'category': 'quran',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مكتبة الأناشيد'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _nasheeds.length,
        itemBuilder: (context, index) {
          final nasheed = _nasheeds[index];
          return _NasheedCard(
            title: nasheed['title'],
            artist: nasheed['artist'],
            duration: nasheed['duration'],
            onTap: () => _playPreview(context, nasheed),
            onSelect: () => _selectNasheed(context, nasheed),
          );
        },
      ),
    );
  }

  void _playPreview(BuildContext context, Map<String, dynamic> nasheed) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تشغيل معاينة: ${nasheed['title']}')),
    );
  }

  void _selectNasheed(BuildContext context, Map<String, dynamic> nasheed) {
    Navigator.pop(context, nasheed);
  }
}

class _NasheedCard extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;
  final VoidCallback onTap;
  final VoidCallback onSelect;

  const _NasheedCard({
    required this.title,
    required this.artist,
    required this.duration,
    required this.onTap,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.music_note,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(title),
        subtitle: Text('$artist • $duration'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.play_circle_outline),
              onPressed: onTap,
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: onSelect,
            ),
          ],
        ),
      ),
    );
  }
}
