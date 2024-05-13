import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camerashot.dart';

void main() async {
  // 初始化相机
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(Camerapage(camera: firstCamera));
}

class Camerapage extends StatefulWidget {
  const Camerapage({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  _CamerapageState createState() => _CamerapageState();
}

class _CamerapageState extends State<Camerapage> {
  late CameraDescription camera;

  @override
  void initState() {
    super.initState();
    camera = widget.camera;
  }

  @override
  Widget build(BuildContext context) {
    // String imagePath = 'images/logo.jpg';
    String imageUrl = 'https://1.bp.blogspot.com/-ENudW9msm88/UKel5BlSyjI/AAAAAAAAB-I/IX8X_db5yLg/s1600/IMG_4167.JPG';

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('極致智能旅遊APP'),
          centerTitle: true,
          elevation: 2,
        ),
        body: Center(
          child: camerashot(
            camera: camera,
          ),
        ),
      ),
    );
  }
}
