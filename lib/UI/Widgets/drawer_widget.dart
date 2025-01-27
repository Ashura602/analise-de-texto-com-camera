import 'package:analise_camera_app/UI/Views/camera_view.dart';
import 'package:analise_camera_app/UI/Views/gallery_view.dart';
import 'package:analise_camera_app/view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var mainProvider = context.watch<MainNotifier>();
    return Drawer(
      child: Column(
        children: [
          ListTile(
              title: Text('Camera'),
              onTap: () async {
                final camera = await mainProvider.getCamera();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                    camera: camera,
                  ),
                ));
              }),
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
