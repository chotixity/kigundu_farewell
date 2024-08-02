import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String title;
  final String url;
  final String id;

  const AudioPlayerWidget(
      {required this.url, required this.title, required this.id, super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _showSpeedSlider = false, _showVolumeSlider = false;
  final _player = AudioPlayer();
  final GlobalKey _hoverKey = GlobalKey();
  bool _isHovering = false;

  Future _setupAudioPlayer() async {
    try {
      await _player.setAudioSource(AudioSource.uri(
          Uri.parse(
            widget.url,
          ),
          tag: MediaItem(id: widget.id, title: widget.title)));
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

        if (kIsWeb && _isHovering) {
          controls.add(_speedSlider());
          controls.add(_volumeSlider());
        } else {
          controls.addAll([
            IconButton(
              icon: const Icon(Icons.speed),
              onPressed: () {
                setState(() {
                  _showSpeedSlider = !_showSpeedSlider;
                  if (_showSpeedSlider) {
                    _showVolumeSlider =
                        false; //Ensure that the speed and volume slider dont show same time
                  }
                });
              },
            ),
            _showSpeedSlider
                ? _speedSlider()
                : const SizedBox(), //Toggles the showing of a  speed slider
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {
                setState(() {
                  _showVolumeSlider = !_showVolumeSlider;
                  if (_showVolumeSlider) {
                    _showSpeedSlider =
                        false; //Ensure that the speed and volume slider dont show same time
                  }
                });
              },
            ),
            _showVolumeSlider
                ? _volumeSlider()
                : const SizedBox() // toggles the addition of a voulme slider
          ]);

          // controls.add(_speedSlider());
          // controls.add(_volumeSlider());
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
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //const Icon(Icons.speed),
            Slider(
              min: 0.5,
              max: 1.5,
              divisions: 4,
              label: "${speed.toStringAsFixed(1)}x",
              value: speed,
              onChanged: _player.setSpeed,
            ),
          ],
        );
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
