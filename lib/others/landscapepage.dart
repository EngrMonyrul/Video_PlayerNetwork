import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenPage extends StatefulWidget {
  final VideoPlayerController controller;
  const FullScreenPage({Key? key, required this.controller}):super(key: key);

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {

  Future landScapeMode() async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future resetAllOrientation() async{
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    landScapeMode();
    super.initState();
  }

  @override
  void dispose() {
    resetAllOrientation();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return VideoPlayer(
      widget.controller
    );
  }
}