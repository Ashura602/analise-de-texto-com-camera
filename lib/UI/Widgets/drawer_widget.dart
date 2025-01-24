import 'package:analise_camera_app/UI/Views/camera_view.dart';
import 'package:analise_camera_app/UI/Views/gallery_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key, required this.camera});

  final CameraDescription camera;
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {


  @override
  Widget build(BuildContext context) { 
    return Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text('Camera'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TakePictureScreen(camera: widget.camera),
              )),
            ),
            ListTile(
              title: Text('Galeria'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(),
              )),
            )
          ],
        ),
      );
  }
}
