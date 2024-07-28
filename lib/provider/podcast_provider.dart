import 'dart:io';
import 'package:flutter/material.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:podcasts/repository/firebase_service.dart';

class PodcastProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Podcast> _podcasts = [];
  double _uploadProgress = 0;

  List<Podcast> get podcasts => _podcasts;
  double get uploadProgress => _uploadProgress;

  void loadPodcasts() async {
    _podcasts = await _firebaseService.retrievePodcasts();
    notifyListeners();
  }

  Future<void> addPodcast(Podcast podcast, String filePath) async {
    File file = File(filePath);
    UploadTask uploadTask = await _firebaseService.addPodcast(podcast, file);

    uploadTask.snapshotEvents.listen((event) {
      _uploadProgress = event.bytesTransferred / event.totalBytes;
      notifyListeners();
    });

    await uploadTask.whenComplete(() {
      loadPodcasts();
    });
  }
}
