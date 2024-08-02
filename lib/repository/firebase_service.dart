import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;
import 'package:podcasts/models/podcast.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UploadTask> addPodcast(Podcast podcast, File file) async {
    String fileName = path.basename(file.path);
    var fileRef = _storage.ref('podcasts/$fileName');
    UploadTask uploadTask = fileRef.putFile(file);

    // A completion listener to update Firestore once the upload completes
    uploadTask.whenComplete(() async {
      String audioUrl = await fileRef.getDownloadURL();
      var podcastData = podcast.toJson();
      podcastData['audioUrl'] = audioUrl;
      podcastData['timestamp'] = FieldValue.serverTimestamp();
      await _firestore.collection('podcasts').add(podcastData);
    });

    return uploadTask;
  }

  Future<List<Podcast>> retrievePodcasts() async {
    var querySnapshot = await _firestore
        .collection('podcasts')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs.map((doc) {
      var data = doc.data();
      data['id'] = doc.id;
      return Podcast.fromJson(data);
    }).toList();
  }
}
