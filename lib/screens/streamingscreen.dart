import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({Key? key}) : super(key: key);

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  late String videoTitle;
  // Url List
  final List<String> _videoUrlList = [
    'https://youtu.be/llmUG-2hgTA',
    'https://youtu.be/jz9DWsZu0aE',
    'https://youtu.be/7LbfM18SwCw',
    'https://youtu.be/S3npWREXr8s',
  ];

  List<YoutubePlayerController> lStreamScreenC = [];

  Map<String, dynamic> cStates = {};

  @override
  void initState() {
    super.initState();
    fillStreamScreenlists();
  }

  fillStreamScreenlists() {
    for (var element in _videoUrlList) {
      String _id = YoutubePlayer.convertUrlToId(element)!;
      YoutubePlayerController _StreamScreenController = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          captionLanguage: 'en',
        ),
      );

      _StreamScreenController.addListener(() {
        print(
            'for $_id got isPlaying state ${_StreamScreenController.value.isPlaying}');
        if (cStates[_id] != _StreamScreenController.value.isPlaying) {
          if (mounted) {
            setState(() {
              cStates[_id] = _StreamScreenController.value.isPlaying;
            });
          }
        }
      });

      lStreamScreenC.add(_StreamScreenController);
    }
  }

  @override
  void dispose() {
    for (var element in lStreamScreenC) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaming'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _videoUrlList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            YoutubePlayerController _StreamScreenController =
                lStreamScreenC[index];
            String _id = YoutubePlayer.convertUrlToId(_videoUrlList[index])!;
            String curState = 'undefined';
            if (cStates[_id] != null) {
              curState = cStates[_id] ? 'playing' : 'paused';
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 220.0,
                    decoration: const BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: YoutubePlayer(
                        controller: _StreamScreenController,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.lightBlueAccent,
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(isExpanded: true),
                          FullScreenButton(),
                        ],
                        onReady: () {
                          print('onReady for $index');
                        },
                        onEnded: (YoutubeMetaData _md) {
                          _StreamScreenController.seekTo(
                              const Duration(seconds: 0));
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      curState,
                      textScaleFactor: 1.5,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
