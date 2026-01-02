import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  String? _accessToken;

  void initialize() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, try to refresh
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the request
            final retryRequest = await _dio.fetch(error.requestOptions);
            return handler.resolve(retryRequest);
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<void> setToken(String token) async {
    _accessToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString(AppConstants.tokenKey);
  }

  Future<void> clearToken() async {
    _accessToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.refreshTokenKey);
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString(AppConstants.refreshTokenKey);
      
      if (refreshToken == null) return false;

      final response = await _dio.post('/auth/refresh', data: {
        'refreshToken': refreshToken,
      });

      if (response.statusCode == 200) {
        await setToken(response.data['data']['accessToken']);
        await prefs.setString(
          AppConstants.refreshTokenKey,
          response.data['data']['refreshToken'],
        );
        return true;
      }
    } catch (e) {
      // Refresh failed
    }
    return false;
  }

  // Auth
  Future<Response> register(String email, String password, String? name) async {
    return _dio.post('/auth/register', data: {
      'email': email,
      'password': password,
      if (name != null) 'name': name,
    });
  }

  Future<Response> login(String email, String password) async {
    return _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }

  // Alarms
  Future<Response> getAlarms() async {
    return _dio.get('/alarms');
  }

  Future<Response> createAlarm(Map<String, dynamic> data) async {
    return _dio.post('/alarms', data: data);
  }

  Future<Response> updateAlarm(String id, Map<String, dynamic> data) async {
    return _dio.put('/alarms/$id', data: data);
  }

  Future<Response> deleteAlarm(String id) async {
    return _dio.delete('/alarms/$id');
  }

  Future<Response> toggleAlarm(String id) async {
    return _dio.patch('/alarms/$id/toggle');
  }

  // Adhkar
  Future<Response> getAdhkar({String? category}) async {
    return _dio.get('/adhkar', queryParameters: {
      if (category != null) 'category': category,
    });
  }

  Future<Response> getAdhkarCategories() async {
    return _dio.get('/adhkar/categories');
  }

  // Reminders
  Future<Response> getReminders() async {
    return _dio.get('/reminders');
  }

  Future<Response> createReminder(Map<String, dynamic> data) async {
    return _dio.post('/reminders', data: data);
  }

  Future<Response> updateReminder(String id, Map<String, dynamic> data) async {
    return _dio.put('/reminders/$id', data: data);
  }

  Future<Response> deleteReminder(String id) async {
    return _dio.delete('/reminders/$id');
  }

  // Library
  Future<Response> getNasheeds({String? category}) async {
    return _dio.get('/library', queryParameters: {
      if (category != null) 'category': category,
    });
  }

  Future<Response> getDefaultNasheeds() async {
    return _dio.get('/library/default');
  }

  // Sync
  Future<Response> syncData(Map<String, dynamic> data) async {
    return _dio.post('/sync', data: data);
  }

  Future<Response> getBackup() async {
    return _dio.get('/sync/backup');
  }
}
