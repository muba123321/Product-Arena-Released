import 'package:delta_team/features/homepage/provider/youtube_link_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    final ytProvider = Provider.of<YoutubeLinkProvider>(context);

    _controller = YoutubePlayerController.fromVideoId(
      videoId: ytProvider.link,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    return Container(
      width: 300,
      height: 300,
      child: YoutubePlayer(
        controller: _controller,
      ),
    );
  }
}
