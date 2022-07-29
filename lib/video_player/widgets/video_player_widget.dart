import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _playerController;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _playerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      // autoPlay: true,
      // looping: true,
      // aspectRatio: _playerController.value.aspectRatio,
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          // print(5555555555555555);
          // print(_playerController.value.aspectRatio);
          return AspectRatio(
            aspectRatio: _playerController.value.aspectRatio,
            child: Chewie(
              controller: _chewieController,
            ),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
