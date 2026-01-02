import 'package:flutter/material.dart';

class AdhkarDetailsScreen extends StatefulWidget {
  final String category;
  final String categoryName;

  const AdhkarDetailsScreen({
    super.key,
    required this.category,
    required this.categoryName,
  });

  @override
  State<AdhkarDetailsScreen> createState() => _AdhkarDetailsScreenState();
}

class _AdhkarDetailsScreenState extends State<AdhkarDetailsScreen> {
  final Map<int, int> _counters = {};

  // Sample data - replace with actual data from API
  final List<Map<String, dynamic>> _adhkarList = [
    {
      'id': '1',
      'textAr': 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ',
      'reference': 'مسلم',
      'count': 1,
    },
    {
      'id': '2',
      'textAr': 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
      'reference': 'الترمذي',
      'count': 1,
    },
    {
      'id': '3',
      'textAr': 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
      'reference': 'البخاري ومسلم',
      'count': 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounters,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _adhkarList.length,
        itemBuilder: (context, index) {
          final dhikr = _adhkarList[index];
          final currentCount = _counters[index] ?? dhikr['count'];
          
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: currentCount > 0 ? () => _decrementCounter(index) : null,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Dhikr Text
                    Text(
                      dhikr['textAr'],
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 16),
                    
                    // Reference
                    if (dhikr['reference'] != null)
                      Text(
                        '📖 ${dhikr['reference']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 12),
                    
                    // Counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: currentCount > 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            currentCount > 0 ? '$currentCount' : '✓',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _decrementCounter(int index) {
    setState(() {
      final currentCount = _counters[index] ?? _adhkarList[index]['count'];
      if (currentCount > 0) {
        _counters[index] = currentCount - 1;
      }
    });
  }

  void _resetCounters() {
    setState(() => _counters.clear());
  }
}
