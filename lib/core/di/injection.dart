import 'package:get_it/get_it.dart';

import '../services/notification_service.dart';
import '../services/alarm_service.dart';
import '../services/audio_service.dart';
import '../services/api_service.dart';
import '../../features/app/app_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<AlarmService>(() => AlarmService());
  getIt.registerLazySingleton<AudioService>(() => AudioService());
  getIt.registerLazySingleton<ApiService>(() {
    final service = ApiService();
    service.initialize();
    return service;
  });

  // BLoCs
  getIt.registerFactory<AppBloc>(() => AppBloc());
}
