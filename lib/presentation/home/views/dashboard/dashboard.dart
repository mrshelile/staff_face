
import 'package:flutter/material.dart';

// import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
// import 'package:media_kit_video/media_kit_video.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // late final player = Player();
  // // Create a [VideoController] to
  // late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Pla *  History restored list].
    // player.open(Media(
    //     'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.01,
          right: 10,
          top: size.height * 0.17,
          bottom: 20),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: size.width * 1,
            // height: size.height * 0.45,
            child: Wrap(
              direction: Axis.horizontal,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                SizedBox(
                  width: size.width * 0.05,
                ),
                Container(
                  width: size.width * 0.212,
                  height: size.height * 0.45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 209, 209, 209),
                            spreadRadius: 0.01,
                            blurRadius: 0.7,
                            offset: Offset(6, 6))
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(""),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
