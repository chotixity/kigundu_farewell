import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../features/podcasts/models/podcast.dart';

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  final AudioPlayer _player = AudioPlayer();

  factory AudioPlayerManager() => _instance;

  AudioPlayerManager._internal();

  Podcast? _currentPodcast;

  Future<void> setupAudioPlayer(Podcast podcast) async {
    // Pause the current audio if a different podcast is playing
    if (_player.playing && _currentPodcast?.id != podcast.id) {
      await _player.pause();
    }

    // If no audio is playing or a different podcast is selected, set the new audio source
    if (_currentPodcast?.id != podcast.id) {
      await _setAudioSource(podcast);
    }
  }

  Future<void> play() async {
    // Simply resume playing if the player is paused
    if (!_player.playing) {
      await _player.play();
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> seek(Duration duration) async {
    await _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Duration? get duration => _player.duration;
  double get speed => _player.speed;
  double get volume => _player.volume;

  void dispose() {
    _player.dispose();
  }

  // Private helper method to set the audio source
  Future<void> _setAudioSource(Podcast podcast) async {
    _currentPodcast = podcast;
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(podcast.audioUrl),
          tag: MediaItem(id: podcast.id!, title: podcast.title),
        ),
        preload: true,
      );
    } catch (e) {
      print("Unable to load audio: ${e.toString()}");
      throw Exception("Unable to load Audio from Url");
    }
  }
}
