import 'package:flutter/material.dart';
import 'package:podcasts/Viewer.dart';
import 'package:podcasts/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:podcasts/provider/podcast_provider.dart';
import 'package:provider/provider.dart';
import './util.dart';
import './theme.dart';
import 'adminPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Roboto", "Open Sans");
    MaterialTheme theme = MaterialTheme(textTheme);
    return ChangeNotifierProvider(
      create: (_) => PodcastProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const RecordingScreen(),
      ),
    );
  }
}
