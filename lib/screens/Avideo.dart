import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/src/chewie_player.dart';

class Avideo extends StatefulWidget {
  Map m;
  Avideo(this.m);

  @override
  State<StatefulWidget> createState() {
    return video();
  }
}

class video extends State<Avideo> {
  TargetPlatform _platform;
  VideoPlayerController controller;
  bool _isPlaying = false;
  bool _visible = true;


  @override
  void initState() {
    super.initState();
    print("___________Avideo => ${widget.m["dataOnlineURL"]}");
    controller = VideoPlayerController.network('http://osmo.mn/econtent/content/video//khovd_hunniigem.mp4')..addListener((){
      final bool isPlaying = controller.value.isPlaying;
      if(isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }

    })..initialize().then((_) {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        backgroundColor: Color(0xff624594),
      ),
      body: GestureDetector(
        onTap: () {
          if (controller.value.isPlaying) {
            setState(() {
              controller.pause();
              _visible = true;
            });
          } else {
            controller.play();
            new Future.delayed(Duration(milliseconds: 1500), () {
              setState(() {
                _visible = false;
              });
            });
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Hero(
              tag: "vid${widget.m["dataId"]}",
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(color: Color(0xff624594)),
                child: Stack(
                  children: <Widget>[
                    controller.value.initialized
                        ? Column(
                            children: <Widget>[
                              Chewie(
                                controller,
                                aspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.width * 0.6),
                                autoPlay: true,
                                looping: false,
                                showControls: true,
                                materialProgressColors: new ChewieProgressColors(
                                  playedColor: Color(0xff624594),
                                  handleColor: Color(0xff624594),
                                  backgroundColor: Color(0xff6c7a89),
                                  bufferedColor: Color(0xff624594),
                                ),
                                placeholder: new Container(
                                  color: Color(0xff624594),
                                ),
                                autoInitialize: true,
                              ),
                            ],
                          )
                        : Container(),

//                    AnimatedOpacity(
//                      opacity: _visible ? 1.0 : 0.0,
//                      duration: Duration(milliseconds: 800),
//                      child: Center(
//                        child: Container(
//                          width: 65.0,
//                          height: 65.0,
//                          child: Icon(
//                            controller.value.isPlaying
//                                ? Icons.pause
//                                : Icons.play_arrow,
//                            color: controller.value.initialized
//                                ? Color(0xff624594)
//                                : Colors.white,
//                            size: 35.0,
//                          ),
//                          decoration: BoxDecoration(
//                              color: Color(0x00624594),
//                              shape: BoxShape.circle,
//                              border: Border.all(
//                                  color: controller.value.initialized
//                                      ? Color(0xff624594)
//                                      : Colors.white,
//                                  width: 1.5)),
//                        ),
//                      ),
//                    ),


                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.m["dataName"],
              style: TextStyle(color: Color(0xff624594), fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
