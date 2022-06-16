import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_screen/video_page.dart';

class VideoTabBar extends StatefulWidget {
  const VideoTabBar({Key? key}) : super(key: key);

  @override
  State<VideoTabBar> createState() => _VideoTabBarState();
}

class _VideoTabBarState extends State<VideoTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<Tab> _tabs = [
    Tab(
      text: 'Video',
    ),
    Tab(
      text: 'Folder',
    ),
    Tab(
      text: 'Playlist',
    ),
  ];

  List<Widget> _tabPages = [
    VideoPage(),
    Center(
      child: Icon(
        Icons.folder,
        color: Colors.white,
        size: 150,
      ),
    ),
    Center(
      child: Icon(
        Icons.playlist_add,
        color: Colors.white,
        size: 150,
      ),
    ),
  ];

  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    requestPermission();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('PLAYit'),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
            Icon(
              Icons.download,
              color: Colors.white,
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  TabBar(
                    tabs: _tabs,
                    controller: _tabController,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _tabPages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
