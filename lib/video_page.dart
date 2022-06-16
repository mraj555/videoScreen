import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_screen/video_player_screen.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<AssetEntity> _videos = [];

  _fetchVideos() async {
    final video = await PhotoManager.getAssetPathList(type: RequestType.video);
    final all = video.first;
    print(all);

    final videoList =
        await all.getAssetListRange(start: 0, end: all.assetCount);
    print(videoList);
    setState(
      () {
        _videos = videoList;
      },
    );
  }

  @override
  void initState() {
    _fetchVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) => FutureBuilder<Uint8List?>(
          future: _videos[index].thumbnailData,
          builder: (context, snapshot) {
            final bytes = snapshot.data;
            if (bytes == null) {
              return CircularProgressIndicator();
            }
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(file: _videos[index].file),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.center,
                height: size.height * 0.12,
                width: size.width * 0.06,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.11,
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          image: MemoryImage(bytes),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: Text(
                            // assets[index].relativePath.toString(),
                            _videos[index].title!.toString(),
                            style: TextStyle(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _videos[index].orientatedSize.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
