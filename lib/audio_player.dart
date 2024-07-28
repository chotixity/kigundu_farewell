import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  const AudioPlayerWidget({required this.url, super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final _player = AudioPlayer();
  final GlobalKey _hoverKey = GlobalKey();
  bool _isHovering = false;

  Future _setupAudioPlayer() async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.url)));
    } catch (e) {
      print('Error loading audio source: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupAudioPlayer());
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      key: _hoverKey,
      onEnter: (event) => _setHovering(true),
      onExit: (event) => _setHovering(false),
      child: Column(
        children: [
          _playbackControlButton(),
          _progressBar(),
        ],
      ),
    );
  }

  void _setHovering(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  Widget _playbackControlButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        List<Widget> controls = [
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering)
            const CircularProgressIndicator(),
          if (playing != true)
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: _player.play,
            ),
          if (playing == true && processingState != ProcessingState.completed)
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: _player.pause,
            ),
          if (processingState == ProcessingState.completed)
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () => _player.seek(Duration.zero),
            ),
        ];

        if (_isHovering) {
          controls.add(_speedSlider());
          controls.add(_volumeSlider());
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: controls,
        );
      },
    );
  }

  Widget _progressBar() {
    return StreamBuilder<Duration>(
      stream: _player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final total = _player.duration ?? Duration.zero;
        return ProgressBar(
          progress: position,
          total: total,
          onSeek: _player.seek,
        );
      },
    );
  }

  Widget _speedSlider() {
    return StreamBuilder<double>(
      stream: _player.speedStream,
      builder: (context, snapshot) {
        final speed = snapshot.data ?? 1.0;
        return Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.speed),
          Slider(
            min: 0.5,
            max: 1.5,
            divisions: 4,
            label: "${speed.toStringAsFixed(1)}x",
            value: speed,
            onChanged: _player.setSpeed,
          ),
        ]);
      },
    );
  }

  Widget _volumeSlider() {
    return StreamBuilder<double>(
      stream: _player.volumeStream,
      builder: (context, snapshot) {
        final volume = snapshot.data ?? 1.0;
        return Row(
          children: [
            const Icon(Icons.volume_up),
            Slider(
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: volume,
              onChanged: _player.setVolume,
            ),
          ],
        );
      },
    );
  }
}
