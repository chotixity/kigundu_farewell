import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:podcasts/features/share/share.dart';
import 'package:just_audio/just_audio.dart';
import './features/podcasts/models/podcast.dart';
import './services/audio_player.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String title;
  final String url;
  final String id;
  final PodCastCategory category;

  const AudioPlayerWidget({
    required this.category,
    required this.url,
    required this.title,
    required this.id,
    super.key,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _showSpeedSlider = false, _showVolumeSlider = false;
  late AudioPlayerManager _audioManager;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _audioManager = AudioPlayerManager(); // Use the singleton instance
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupAudioPlayer());
  }

  void shareAudioFromUrl(String audioUrl) async {
    try {
      final filePath = await downloadAndRenameAudio(audioUrl);
      print(filePath);
      shareAudio(filePath);
    } catch (e) {
      print('Error sharing audio: $e');
    }
  }

  Future<void> _setupAudioPlayer() async {
    await _audioManager.setupAudioPlayer(Podcast(
      category: widget.category,
      id: widget.id,
      title: widget.title,
      audioUrl: widget.url,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
      stream: _audioManager.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildControls(processingState, playing),
        );
      },
    );
  }

  List<Widget> _buildControls(ProcessingState? processingState, bool? playing) {
    List<Widget> controls = [
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering)
        const CircularProgressIndicator(),
      if (playing != true)
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: _audioManager.play,
        ),
      if (playing == true && processingState != ProcessingState.completed)
        IconButton(
          icon: const Icon(Icons.pause),
          onPressed: _audioManager.pause,
        ),
      if (processingState == ProcessingState.completed)
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => _audioManager.seek(Duration.zero),
        ),
      _speedVolumeControls(),
    ];
    return controls;
  }

  Widget _speedVolumeControls() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.speed),
          onPressed: () {
            setState(() {
              _showSpeedSlider = !_showSpeedSlider;
              _showVolumeSlider = false;
            });
          },
        ),
        if (_showSpeedSlider) _speedSlider(),
        IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              setState(() {
                _showVolumeSlider = !_showVolumeSlider;
                _showSpeedSlider = false;
              });
            }),
        if (_showVolumeSlider) _volumeSlider(),
        IconButton(
            onPressed: () {
              shareAudioFromUrl(widget.url);
            },
            icon: const Icon(Icons.share))
      ],
    );
  }

  Widget _progressBar() {
    return StreamBuilder<Duration>(
      stream: _audioManager.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final total = _audioManager.duration ?? Duration.zero;
        return ProgressBar(
          progress: position,
          total: total,
          onSeek: _audioManager.seek,
        );
      },
    );
  }

  Widget _speedSlider() {
    return Slider(
      min: 0.5,
      max: 1.5,
      divisions: 4,
      label: "${_audioManager.speed.toStringAsFixed(1)}x",
      value: _audioManager.speed,
      onChanged: _audioManager.setSpeed,
    );
  }

  Widget _volumeSlider() {
    return Slider(
      min: 0.0,
      max: 1.0,
      divisions: 10,
      value: _audioManager.volume,
      onChanged: _audioManager.setVolume,
    );
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }
}
