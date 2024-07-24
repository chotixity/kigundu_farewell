import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import './custom_recording_button.dart';
import './custom_recording_wave_widget.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _transcriptController = TextEditingController();
  final List _recordedPodcasts = [];
  bool isRecording = false;
  late final AudioRecorder _audioRecorder;
  String? _audioPath;

  @override
  void initState() {
    _audioRecorder = AudioRecorder();
    super.initState();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  String _generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(
      10,
      (index) => chars[random.nextInt(chars.length)],
      growable: false,
    ).join();
  }

  Future<void> _startRecording() async {
    try {
      debugPrint(
          '=========>>>>>>>>>>> RECORDING!!!!!!!!!!!!!!! <<<<<<===========');

      String filePath = await getApplicationDocumentsDirectory()
          .then((value) => '${value.path}/${_generateRandomId()}.wav');

      await _audioRecorder.start(
        const RecordConfig(
          // specify the codec to be `.wav`
          encoder: AudioEncoder.wav,
        ),
        path: filePath,
      );
    } catch (e) {
      debugPrint('ERROR WHILE RECORDING: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      String? path = await _audioRecorder.stop();

      setState(() {
        _audioPath = path!;
      });
      _recordedPodcasts.add(_audioPath);
      debugPrint('=========>>>>>> PATH: $_audioPath <<<<<<===========');
    } catch (e) {
      debugPrint('ERROR WHILE STOP RECORDING: $e');
    }
  }

  void _record() async {
    if (isRecording == false) {
      final status = await Permission.microphone.request();

      if (status == PermissionStatus.granted) {
        setState(() {
          isRecording = true;
        });
        await _startRecording();
      } else if (status == PermissionStatus.permanentlyDenied) {
        debugPrint('Permission permanently denied');
        // TODO: handle this case
      }
    } else {
      await _stopRecording();

      setState(() {
        isRecording = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: const Text('New Podcast'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Title';
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text("Title")),
              ),
              TextFormField(
                //scrollController: ,
                maxLines: 10,
                minLines: 1,
                controller: _transcriptController,
                decoration:
                    const InputDecoration(label: Text("Type transcript here")),
              ),
              DropdownButtonFormField(
                items: const [],
                onChanged: (value) {},
                decoration: const InputDecoration(label: Text('Pick Category')),
              ),
              if (isRecording) const CustomRecordingWaveWidget(),
              const SizedBox(height: 16),
              if (_recordedPodcasts.isNotEmpty)
                ListTile(
                  title: Text(_recordedPodcasts.last),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    CustomRecordingButton(
                      isRecording: isRecording,
                      onPressed: () => _record(),
                    ),
                    const Text('Tap to record'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll<Size>(
                          Size(MediaQuery.sizeOf(context).width * .9, 50))),
                  onPressed: () {},
                  child: const Text("Upload Devotion"))
            ],
          ),
        ),
      ),
    );
  }
}
