import 'dart:io';

import 'package:analise_camera_app/UI/Widgets/drawer_widget.dart';
import 'package:analise_camera_app/view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initControllerFuture;
  late XFile image;

  Future<XFile?> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    return pickedFile;
  } else {
    print('No image selected.');
    return null;
  }
}

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mainNotifier = context.watch<MainNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
      ),
      drawer: DrawerWidget(),
      body: FutureBuilder(
        future: _initControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final pickedImage = await _pickImage();
            // await _initControllerFuture;
            // final image = await _controller.takePicture();
            mainNotifier.addImage(pickedImage!);

            if (!context.mounted) return;
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}