import 'dart:io';

import 'package:analise_camera_app/UI/Views/image_view.dart';
import 'package:analise_camera_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayPictureScreen extends StatefulWidget {
  DisplayPictureScreen({super.key});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {

  @override
  Widget build(BuildContext context) {
    var mainNotifier = context.watch<MainNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
      ),
      body: GridView.builder(
        itemCount: mainNotifier.imagens.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
            

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImageView(
                  image: mainNotifier.imagens[index],
                  imageIndex: index,
                ),
              ));
            },
            child: Image.file(
              File(mainNotifier.imagens[index].path),
            ),
          );
        },
      ),
    );
  }
}
