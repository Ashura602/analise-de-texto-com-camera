import 'dart:async';
import 'package:analise_camera_app/UI/Views/camera_view.dart';
import 'package:analise_camera_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(
    ChangeNotifierProvider(
      create: (context) => MainNotifier(),
      child: Builder(
        builder: (context) {
        final mainProvider = context.watch<MainNotifier>();
          return MaterialApp(
            theme: ThemeData.dark(),
            home: FutureBuilder(
              future: mainProvider.getCamera(),
              builder: (context,snapshot) {
                final camera = snapshot.data;
                if (snapshot.connectionState == ConnectionState.done) {
                  return TakePictureScreen(camera: camera!); 
                }else{
                  return CircularProgressIndicator();
                }
              }
            ),
          );
        }
      ),
    ),
  );
}
