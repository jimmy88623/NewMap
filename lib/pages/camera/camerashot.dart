import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'textrecognition.dart';
import 'dart:io';
import 'package:camera/camera.dart';

// Take picture page
class camerashot extends StatefulWidget {
  const camerashot({
    Key? key,
    required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() => _camerashot();
}


// Take picture page state
class _camerashot extends State<camerashot> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {          //當 StatefulWidget 被插入到樹中，會立即調用此方法
    super.initState();        //調用了父類(State類)中的 initState() 方法，以執行父類中的初始化操作。

    _controller = CameraController(
      widget.camera,          // CameraDescription
      ResolutionPreset.max,   // resolutionPreset
    );

    // Initialize the controller
    _initializeControllerFuture = _controller.initialize();
  }

  // Dispose of the controller when the widget is disposed
  @override
  void dispose() {             //當 StatefulWidget 從樹中移除時，會立即調用此方法
    _controller.dispose();
    super.dispose();           //調用了父類(State類)中的 dispose() 方法，以執行父類中的清理操作。
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Take a picture demo")
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.black,
              ),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextRecognition(
                        imagePath: image.path,
                      ),
                    ),
                  );

                  print("My Image Path: ${image.path}");  //${image.path} 表示將變量 {image.path} 的值插入到字符串中

                }
                catch (error) {
                  print(error);
                }
              }
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
