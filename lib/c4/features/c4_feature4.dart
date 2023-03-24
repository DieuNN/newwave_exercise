import 'package:bt_c3/c4/c4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class C4Feature4 extends StatefulWidget {
  const C4Feature4({Key? key}) : super(key: key);

  @override
  State<C4Feature4> createState() => _C4Feature4State();
}

class _C4Feature4State extends State<C4Feature4> {
  @override
  void initState() {
    super.initState();
  }

  // dispose the controller
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: const [
              MyVideoPlayer(),
              MyYoutubePlayer(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController? _videoPlayerController;
  late Widget _playIcon;
  late Widget _pauseIcon;
  late Widget _showingIcon;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
      C4Const.githubVideoUrl,
    )..initialize().then((_) => {setState(() {})});

    _pauseIcon = IconButton(
      key: UniqueKey(),
      onPressed: () {
        if (kDebugMode) {
          print("Video playing\n");
        }
        setState(() {
          _videoPlayerController!.pause();
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
          print("Video paused\n");
        }
        setState(() {
          _videoPlayerController!.play();
          _showingIcon = _pauseIcon;
        });
      },
      icon: const Icon(Icons.play_arrow),
      color: Colors.white,
    );

    _showingIcon = _videoPlayerController!.value.isPlaying &&
            _videoPlayerController!.value.isInitialized
        ? _pauseIcon
        : _playIcon;

    // Reset video and showing icon when reached the end
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController?.value.position ==
          _videoPlayerController?.value.duration) {
        setState(() {
          _videoPlayerController?.seekTo(Duration.zero);
          _showingIcon = _playIcon;
        });
      }
    });


    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
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
            child: _videoPlayerController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController!),
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
  const MyYoutubePlayer({super.key});

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  late YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        C4Const.youtubeVideoUrl,
      ) as String,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: true),
    );
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
          const Text("Using youtube_player_flutter"),
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
