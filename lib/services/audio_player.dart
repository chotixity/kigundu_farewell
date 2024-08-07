import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../models/podcast.dart';

class AudioPlayerManager {
  Podcast podcast;

  final AudioPlayer _player = AudioPlayer();
  final bool _isPlaying = false;

  AudioPlayerManager({required this.podcast});

  void _setupAudioPlayer() async {
    try {
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse(podcast.audioUrl),
            tag: MediaItem(id: podcast.id!, title: podcast.title)),
      );
    } catch (e) {
      throw Exception("Unable to load Audio from Url");
    }
  }

  void playAudio() async {
    if (_isPlaying) {
      await _player.pause();
    }
    _player.play();
  }

  void pauseAudio() async {
    await _player.pause();
  }

  void seek(Duration duration) async {
    await _player.seek(duration);
  }

  void setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  void setVolume(double volume) async {
    await _player.setVolume(volume);
  }
}
