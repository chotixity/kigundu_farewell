import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:podcasts/podcast_page.dart';
import 'package:podcasts/provider/podcast_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import './models/podcast.dart';
import 'package:record/record.dart';
import './custom_recording_button.dart';
import './custom_recording_wave_widget.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  PodCastCategory? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  bool _recordAudio = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _transcriptController = TextEditingController();
  final List _recordedPodcasts = [];
  bool isRecording = false;
  late final AudioRecorder _audioRecorder;
  String? _audioPath;

  @override
  void initState() {
    _audioRecorder = AudioRecorder();
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      Provider.of<PodcastProvider>(context, listen: false).loadPodcasts();
    });
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

  //TODO: Pick files from local storage
  Future<void> pickAudioFile() async {
    try {
      // Configure the file picker to pick audio files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType
            .audio, // Set to FileType.audio to filter for audio files only
        allowMultiple:
            false, // Set to true if you want to allow multiple file selection
      );

      if (result != null) {
        // Get the selected file
        PlatformFile file = result.files.first;
        _recordedPodcasts.add(file.path);
        // Use the file path or file name as needed
        print('Picked file path: ${file.path}');
        print('Picked file name: ${file.name}');
      } else {
        // User canceled the picker
        print('No file selected.');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error picking file: $e');
    }
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

  Future<void> uploadFile(String filePath) async {
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);

    // Create a Podcast object, assuming you have already set up the required fields.
    Podcast newPodcast = Podcast(
      title: _titleController
          .text, // This should be dynamically set, possibly from user input
      description: _transcriptController.text, // Same as above
      audioUrl: _recordedPodcasts
          .last, // This will be set inside the provider after file upload
      category: PodCastCategory.other, // This should be selected by the user
    );

    // Call `addPodcast` from the provider which internally handles the upload
    // and listens to the snapshot events to update progress.
    await podcastProvider.addPodcast(newPodcast, filePath);

    // Since the provider is notifying listeners, you do not need to set state here for the progress.
    // The provider itself handles notifying listeners, which will trigger a rebuild in your widget
    // where you are displaying the progress.
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PodcastProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: const Text('New Podcast'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PodcastPage()));
              },
              child: const Text('podcasts'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SwitchListTile.adaptive(
                title: const Text(
                  "Record Audio",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                subtitle: const Text(
                    "Toggle this switch to pick a recorded audio from the device"),
                value: _recordAudio,
                onChanged: (value) {
                  setState(() {
                    _recordAudio = value;
                  });
                },
              ),
              const Spacer(),
              TextFormField(
                controller: _titleController,
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
              DropdownButtonFormField<PodCastCategory>(
                value: _selectedCategory,
                items: const [
                  DropdownMenuItem(
                    value: PodCastCategory.devotion,
                    child: Text("Daily Devotion"),
                  ),
                  DropdownMenuItem(
                    value: PodCastCategory.doctrine,
                    child: Text("Doctrinal Study"),
                  ),
                  DropdownMenuItem(
                    value: PodCastCategory.sermon,
                    child: Text("Sermon"),
                  ),
                  DropdownMenuItem(
                    value: PodCastCategory.other,
                    child: Text("Other"),
                  ),
                ],
                onChanged: (PodCastCategory? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Pick Category',
                  // border: OutlineInputBorder(),
                ),
              ),
              if (isRecording) const CustomRecordingWaveWidget(),
              const SizedBox(height: 16),
              if (_recordedPodcasts.isNotEmpty)
                ListTile(
                  title: Text(_recordedPodcasts.last),
                ),
              _recordAudio
                  ? Column(
                      children: [
                        CustomRecordingButton(
                          isRecording: isRecording,
                          onPressed: () => _record(),
                        ),
                        Text(isRecording
                            ? 'Tap To Save the recording'
                            : 'Tap to record'),
                      ],
                    )
                  : TextButton(
                      onPressed: () {
                        pickAudioFile();
                      },
                      child: const Text("Pick Audio"),
                    ),
              const Spacer(),
              if (provider.uploadProgress > 0)
                Column(
                  children: [
                    LinearProgressIndicator(value: provider.uploadProgress),
                    Text(
                        '${(provider.uploadProgress * 100).toStringAsFixed(2)}% Uploaded'),
                  ],
                ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll<Size>(
                          Size(MediaQuery.sizeOf(context).width * .9, 50))),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _recordedPodcasts.isNotEmpty) {
                      uploadFile(_recordedPodcasts.last);
                    }
                  },
                  child: const Text("Upload Devotion"))
            ],
          ),
        ),
      ),
    );
  }
}
