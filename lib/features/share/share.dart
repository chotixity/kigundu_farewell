import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<String> downloadAndRenameAudio(String url) async {
  final dio = Dio();
  final tempDir = await getTemporaryDirectory();
  final tempPath = tempDir.path;

  // Extract file name from URL, without query parameters
  final uri = Uri.parse(url);
  final originalFileName =
      uri.pathSegments.last.split('?').first; // Remove query parameters
  final filePath = '$tempPath/$originalFileName';

  // Download the file to temporary location
  await dio.download(url, filePath);

  // Return the new file path
  return filePath;
}

void shareAudio(String filePath) {
  Share.shareXFiles([XFile(filePath)], text: 'Check out this audio!');
}
