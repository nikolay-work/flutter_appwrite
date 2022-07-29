import 'package:appwrite_realtime_test/video_list/video_list_page.dart';
import 'package:appwrite_realtime_test/video_player/video_player_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: VideoPlayerPage(),
      home: VideoListPage(),
    );
  }
}





