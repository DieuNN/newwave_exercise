import 'package:bt_c3/c4/c4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class C4Feature4 extends StatelessWidget {
  const C4Feature4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoPlayerController playerController =
        VideoPlayerController.network(C4Const.githubVideoUrl);
    YoutubePlayerController youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        C4Const.youtubeVideoUrl,
      ) as String,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: true),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Using video_player",
                textAlign: TextAlign.center,
              ),
              MyVideoPlayer(controller: playerController),
              const Text(
                "Using youtube_player_flutter",
                textAlign: TextAlign.center,
              ),
              MyYoutubePlayer(
                controller: youtubePlayerController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late final VideoPlayerController _videoPlayerController;
  late Widget _playIcon;
  late Widget _pauseIcon;
  late Widget _showingIcon;

  @override
  void initState() {
    _videoPlayerController = widget.controller;
    _videoPlayerController.initialize().then((_) => {setState(() {})});

    _pauseIcon = IconButton(
      key: UniqueKey(),
      onPressed: () {
        if (kDebugMode) {
          print("Video paused\n");
        }
        setState(() {
          _videoPlayerController.pause();
          _showingIcon = _playIcon;
        });
      },
      icon: const Icon(Icons.pause),
      color: Colors.white,
    );

    _playIcon = IconButton(
      key: UniqueKey(),
      onPressed: () {
        if (kDebugMode) {
          print("Video is playing\n");
        }
        setState(() {
          _videoPlayerController.play();
          _showingIcon = _pauseIcon;
        });
      },
      icon: const Icon(Icons.play_arrow),
      color: Colors.white,
    );

    // Ensure that when video is playing, showing button is always _playButton
    _showingIcon = _videoPlayerController.value.isPlaying &&
            _videoPlayerController.value.isInitialized
        ? _pauseIcon
        : _playIcon;

    // Reset video and showing icon when reached the end
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isInitialized &&
          _videoPlayerController.value.isPlaying) {
        setState(() {
          _showingIcon = _pauseIcon;
        });
      }
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        if (kDebugMode) {
          print("Video ended");
        }
        setState(() {
          _videoPlayerController.seekTo(Duration.zero);
          _showingIcon = _playIcon;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: 256,
            height: 256,
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned(child: _showingIcon)
        ],
      ),
    );
  }
}

class MyYoutubePlayer extends StatefulWidget {
  const MyYoutubePlayer({super.key, required this.controller});

  final YoutubePlayerController controller;

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  late YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    _youtubePlayerController = widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          Stack(
            children: [
              SizedBox(
                width: 256,
                height: 256,
                child: YoutubePlayer(
                  controller: _youtubePlayerController!,
                  showVideoProgressIndicator: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
