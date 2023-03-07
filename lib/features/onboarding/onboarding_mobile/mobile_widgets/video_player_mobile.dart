import 'package:flutter/widgets.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final _controller = YoutubePlayerController.fromVideoId(
    videoId: '2_uX7GxPzDI',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('VideoPlayerKey'),
      height: 186.0,
      width: double.infinity,
      child: YoutubePlayer(
        aspectRatio: 16 / 9,
        controller: _controller,
      ),
    );
  }
}
