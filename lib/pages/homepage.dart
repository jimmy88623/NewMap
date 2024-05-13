import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_map/pages/settingpage.dart';
import 'package:new_map/pages/schedulepage.dart';
import 'package:new_map/pages/camera/camera.dart';
import 'package:new_map/pages/playpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('極致智能旅遊'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: _currentPageIndex,
        onTap: (currentPageIndex) {
          print("currentPageIndex : $currentPageIndex");
          _onPageChanged(currentPageIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
      body: FutureBuilder<List<Widget>>(
        future: _buildScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return snapshot.data![_currentPageIndex];
          }
        },
      ),
    );
  }

  Future<List<Widget>> _buildScreen() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return [
      schedulePage(),
      Camerapage(camera: firstCamera),
      playpage(),
      settingpage(),
    ];
  }
}
