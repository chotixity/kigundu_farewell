import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final _player = AudioPlayer();

  Future _setupAudioPlayer() async {
    _player.playbackEventStream.listen((event) {
      // Handle playback events and errors
    }, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    try {
      // Load the audio source (from network or asset)
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          'https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav')));
    } catch (e) {
      print('Error loading audio source: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupAudioPlayer());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //_sourceSelect(),
        _playbackControlButton(),
        _progressBar(),
        _controlButtons(),
      ],
    );
  }

  Widget _playbackControlButton() {
    return StreamBuilder(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            width: 64.0,
            height: 64.0,
            margin: const EdgeInsets.all(10.0),
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow, size: 64.0),
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause, size: 64.0),
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay, size: 64.0),
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }

  Widget _progressBar() {
    return StreamBuilder(
      stream: _player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = _player.duration ?? Duration.zero;
        final bufferedPosition = _player.bufferedPosition;

        return ProgressBar(
          progress: position,
          total: duration,
          buffered: bufferedPosition,
          onSeek: (duration) {
            _player.seek(duration);
          },
        );
      },
    );
  }

  //Android 11 Audio
  Widget _controlButtons() {
    return Column(
      children: [
        _speedSlider(),
        _volumeSlider(),
      ],
    );
  }

  Widget _speedSlider() {
    return StreamBuilder(
      stream: _player.speedStream,
      builder: (context, snapshot) {
        final speed = snapshot.data ?? 1.0;
        return Row(
          children: [
            const Icon(Icons.speed),
            Expanded(
              child: Slider(
                min: 1.0,
                max: 3.0,
                divisions: 3,
                value: speed,
                onChanged: _player.setSpeed,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _volumeSlider() {
    return StreamBuilder(
      stream: _player.volumeStream,
      builder: (context, snapshot) {
        final volume = snapshot.data ?? 1.0;
        return Row(
          children: [
            const Icon(Icons.volume_up),
            Expanded(
              child: Slider(
                min: 0.0,
                max: 1.0,
                divisions: 4,
                value: volume,
                onChanged: _player.setVolume,
              ),
            ),
          ],
        );
      },
    );
  }
}
