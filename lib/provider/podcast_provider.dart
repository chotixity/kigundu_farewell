import 'package:flutter/material.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/repository/api_service.dart';

class PodcastProvider with ChangeNotifier {
  final _apiService = ApiService();
  final List<Podcast> _podcasts = [];
  List<Podcast> get podcasts => _podcasts;

  Future uploadPodcast() async {
    _apiService.postReq('/api/v1/podcasts');
  }

  Future getPodcasts() async {
    final response = await _apiService.getReq('/posts');
    // _podcasts =
    //     response.map<Podcast>((json) => Podcast.fromJson(json)).toList();
    print(response);
    notifyListeners();
  }
}
