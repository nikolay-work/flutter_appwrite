import 'package:appwrite_realtime_test/video_player/widgets/comments.dart';
import 'package:appwrite_realtime_test/video_player/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: const [
                VideoPlayerWidget(),
                Comments(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
