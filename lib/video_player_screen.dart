import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Future<File?> file;

  const VideoPlayerScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool initialized = false;

  _initVideo() async {
    final video = await widget.file;
    _controller = VideoPlayerController.file(video!);

    _controller!.addListener(
      () {
        setState(
          () {},
        );
      },
    );
    _controller!.initialize().then((value) => setState(() {}));
    _controller!.play();
  }

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
