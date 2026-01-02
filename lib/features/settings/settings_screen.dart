import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/app_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListView(
            children: [
              _SettingsSection(
                title: 'المظهر',
                children: [
                  ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('وضع العرض'),
                    trailing: DropdownButton<ThemeMode>(
                      value: state.themeMode,
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('تلقائي'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('فاتح'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('داكن'),
                        ),
                      ],
                      onChanged: (mode) {
                        context.read<AppBloc>().add(ThemeChanged(mode!));
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('اللغة'),
                    trailing: DropdownButton<Locale>(
                      value: state.locale,
                      items: const [
                        DropdownMenuItem(
                          value: Locale('ar'),
                          child: Text('العربية'),
                        ),
                        DropdownMenuItem(
                          value: Locale('en'),
                          child: Text('English'),
                        ),
                      ],
                      onChanged: (locale) {
                        context.read<AppBloc>().add(LocaleChanged(locale!));
                      },
                    ),
                  ),
                ],
              ),
              _SettingsSection(
                title: 'الإشعارات',
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications),
                    title: const Text('تفعيل الإشعارات'),
                    value: true,
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.vibration),
                    title: const Text('الاهتزاز'),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'الصوت',
                children: [
                  ListTile(
                    leading: const Icon(Icons.volume_up),
                    title: const Text('مستوى الصوت الافتراضي'),
                    trailing: const Text('70%'),
                    onTap: () {},
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.trending_up),
                    title: const Text('تدرج الصوت'),
                    subtitle: const Text('زيادة الصوت تدريجياً'),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'الحساب',
                children: [
                  ListTile(
                    leading: const Icon(Icons.cloud_sync),
                    title: const Text('المزامنة'),
                    subtitle: const Text('آخر مزامنة: لم تتم المزامنة'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.backup),
                    title: const Text('النسخ الاحتياطي'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'حول التطبيق',
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('الإصدار'),
                    trailing: const Text('1.0.0'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text('سياسة الخصوصية'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail_outline),
                    title: const Text('تواصل معنا'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}
