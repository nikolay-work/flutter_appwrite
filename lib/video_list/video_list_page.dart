import 'package:appwrite_realtime_test/video_list/widgets/video_list.dart';
import 'package:flutter/material.dart';

class VideoListPage extends StatelessWidget {
  const VideoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VideoList(),
    );
  }
}