import 'package:flutter/material.dart';

class AlarmEditorScreen extends StatefulWidget {
  final String? alarmId;

  const AlarmEditorScreen({super.key, this.alarmId});

  @override
  State<AlarmEditorScreen> createState() => _AlarmEditorScreenState();
}

class _AlarmEditorScreenState extends State<AlarmEditorScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<bool> _selectedDays = List.filled(7, false);
  String _label = '';
  double _volume = 70;
  bool _gradualVolume = true;
  bool _vibrate = true;
  int _snoozeDuration = 5;
  String? _selectedNasheedId;

  final List<String> _daysAr = ['أ', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];

  bool get isEditing => widget.alarmId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'تعديل المنبه' : 'منبه جديد'),
        actions: [
          TextButton(
            onPressed: _saveAlarm,
            child: const Text(
              'حفظ',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Picker
            Card(
              child: InkWell(
                onTap: _pickTime,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      _selectedTime.format(context),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Days Selection
            const Text('أيام التكرار', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedDays[index] = !_selectedDays[index]),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _selectedDays[index]
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _daysAr[index],
                        style: TextStyle(
                          color: _selectedDays[index] ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Label
            TextField(
              decoration: const InputDecoration(
                labelText: 'اسم المنبه',
                hintText: 'مثال: منبه الفجر',
                prefixIcon: Icon(Icons.label_outline),
              ),
              onChanged: (value) => _label = value,
            ),
            const SizedBox(height: 24),

            // Nasheed Selection
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.music_note),
              title: const Text('نغمة المنبه'),
              subtitle: Text(_selectedNasheedId ?? 'اختر نشيداً'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, '/library'),
            ),
            const Divider(),

            // Volume
            const Text('مستوى الصوت', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 10,
              label: '${_volume.round()}%',
              onChanged: (value) => setState(() => _volume = value),
            ),

            // Gradual Volume
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('تدرج الصوت'),
              subtitle: const Text('زيادة الصوت تدريجياً'),
              value: _gradualVolume,
              onChanged: (value) => setState(() => _gradualVolume = value),
            ),

            // Vibration
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('الاهتزاز'),
              value: _vibrate,
              onChanged: (value) => setState(() => _vibrate = value),
            ),

            // Snooze Duration
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('مدة التأجيل'),
              trailing: DropdownButton<int>(
                value: _snoozeDuration,
                items: [5, 10, 15, 20, 30].map((minutes) {
                  return DropdownMenuItem(
                    value: minutes,
                    child: Text('$minutes دقائق'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _snoozeDuration = value!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _saveAlarm() {
    // TODO: Save alarm logic
    Navigator.pop(context);
  }
}
