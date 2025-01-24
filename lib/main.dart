import 'dart:async';
import 'package:analise_camera_app/UI/Views/camera_view.dart';
import 'package:analise_camera_app/view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    ChangeNotifierProvider(
      create: (context) => MainNotifier(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: TakePictureScreen(camera: firstCamera),
      ),
    ),
  );
}
