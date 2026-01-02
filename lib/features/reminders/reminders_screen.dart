import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التذكيرات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Morning Reminder Card
          _ReminderCard(
            title: 'أذكار الصباح',
            time: '06:00',
            isActive: true,
            icon: Icons.wb_sunny,
            color: Colors.orange,
            onToggle: (value) {},
          ),
          
          // Evening Reminder Card
          _ReminderCard(
            title: 'أذكار المساء',
            time: '18:00',
            isActive: true,
            icon: Icons.nights_stay,
            color: Colors.indigo,
            onToggle: (value) {},
          ),
          
          // Sleep Reminder Card
          _ReminderCard(
            title: 'أذكار النوم',
            time: '22:00',
            isActive: false,
            icon: Icons.bedtime,
            color: Colors.purple,
            onToggle: (value) {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddReminderDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _AddReminderSheet(),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final String title;
  final String time;
  final bool isActive;
  final IconData icon;
  final Color color;
  final ValueChanged<bool> onToggle;

  const _ReminderCard({
    required this.title,
    required this.time,
    required this.isActive,
    required this.icon,
    required this.color,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(time),
        trailing: Switch(
          value: isActive,
          onChanged: onToggle,
        ),
      ),
    );
  }
}

class _AddReminderSheet extends StatefulWidget {
  const _AddReminderSheet();

  @override
  State<_AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<_AddReminderSheet> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedType = 'custom';
  final _labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'تذكير جديد',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          // Time
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('الوقت'),
            trailing: Text(_selectedTime.format(context)),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
              );
              if (time != null) {
                setState(() => _selectedTime = time);
              }
            },
          ),
          
          // Type
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('النوع'),
            trailing: DropdownButton<String>(
              value: _selectedType,
              items: const [
                DropdownMenuItem(value: 'morning', child: Text('صباحي')),
                DropdownMenuItem(value: 'evening', child: Text('مسائي')),
                DropdownMenuItem(value: 'custom', child: Text('مخصص')),
              ],
              onChanged: (value) => setState(() => _selectedType = value!),
            ),
          ),
          
          // Label
          TextField(
            controller: _labelController,
            decoration: const InputDecoration(
              labelText: 'العنوان',
              hintText: 'مثال: تذكير الظهر',
            ),
          ),
          const SizedBox(height: 24),
          
          ElevatedButton(
            onPressed: () {
              // TODO: Save reminder
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }
}
