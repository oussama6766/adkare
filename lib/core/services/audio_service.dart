import 'dart:async';
import 'package:just_audio/just_audio.dart';

import '../constants/app_constants.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  Timer? _gradualVolumeTimer;
  double _currentVolume = 0;

  bool get isPlaying => _player.playing;

  Future<void> playAlarm({
    required String audioUrl,
    int volume = 70,
    bool gradualVolume = true,
    bool loop = true,
  }) async {
    try {
      await _player.setUrl(audioUrl);
      
      if (loop) {
        await _player.setLoopMode(LoopMode.one);
      }

      if (gradualVolume) {
        await _startGradualVolume(volume);
      } else {
        await _player.setVolume(volume / 100);
      }

      await _player.play();
    } catch (e) {
      // Handle error - maybe play default sound
      print('Error playing audio: $e');
    }
  }

  Future<void> _startGradualVolume(int targetVolume) async {
    _currentVolume = 0;
    await _player.setVolume(0);

    final steps = AppConstants.gradualVolumeSteps;
    final duration = AppConstants.gradualVolumeDuration;
    final stepDuration = duration.inMilliseconds ~/ steps;
    final volumeStep = (targetVolume / 100) / steps;

    _gradualVolumeTimer = Timer.periodic(
      Duration(milliseconds: stepDuration),
      (timer) async {
        _currentVolume += volumeStep;
        if (_currentVolume >= targetVolume / 100) {
          _currentVolume = targetVolume / 100;
          timer.cancel();
        }
        await _player.setVolume(_currentVolume);
      },
    );
  }

  Future<void> playPreview(String audioUrl) async {
    try {
      await _player.setUrl(audioUrl);
      await _player.setVolume(0.5);
      await _player.play();
      
      // Stop after 10 seconds
      Future.delayed(const Duration(seconds: 10), () {
        if (isPlaying) stop();
      });
    } catch (e) {
      print('Error playing preview: $e');
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> stop() async {
    _gradualVolumeTimer?.cancel();
    await _player.stop();
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  void dispose() {
    _gradualVolumeTimer?.cancel();
    _player.dispose();
  }

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
}
