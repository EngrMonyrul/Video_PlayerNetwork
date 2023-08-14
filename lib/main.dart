// ignore_for_file: deprecated_member_use, unused_field, prefer_final_fields
import 'package:downloaderproject/others/landscapepage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideoScreen(),
    );
  }
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  int _currentIndex = 0;

  void _playVideo({int index = 0, bool init = false}) {
    if (index < 0 || index >= videos.length) return;

    if(!init){
      _controller.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    _controller = VideoPlayerController.network(videos[index].url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _playVideo(init: true);
    super.initState();
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.41,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.withOpacity(0.5),
                child: _controller.value.isInitialized
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: VideoPlayer(_controller),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreenPage(controller: _controller,))),
                                  icon: const Icon(Icons.fullscreen, color: Colors.white, size: 40,),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Row(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: _controller,
                                builder:
                                    (context, VideoPlayerValue value, child) {
                                  return Text(
                                    _videoDuration(value.position),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                              Text(
                                _videoDuration(_controller.value.duration),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                _controller.value.isPlaying?
                                _controller.pause():
                                _controller.play();
                              });
                            },
                            icon: Icon(
                              _controller.value.isPlaying?
                              Icons.pause:
                              Icons.play_arrow
                            ),
                            color: Colors.white,
                            iconSize: 30,
                          )
                        ],
                      )
                    : const CircularProgressIndicator(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()=> _playVideo(index: index),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  videos[index].thum,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(videos[index].name),
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Video {
  final String name;
  final String url;
  final String thum;

  const Video({
    required this.name,
    required this.url,
    required this.thum,
  });
}

const videos = [
  Video(
    name: 'Big Buck Bunny',
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    thum: 'assets/images/download.png',
  ),
  Video(
    name: 'Elephant Dream',
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    thum: 'assets/images/download2.png',
  ),
  Video(
    name: 'For Bigger Blazes',
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    thum: 'assets/images/download3.png',
  ),
];
