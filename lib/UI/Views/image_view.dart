import 'dart:io';

import 'package:analise_camera_app/UI/Widgets/description_widget.dart';
import 'package:analise_camera_app/UI/Widgets/drawer_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.image, required this.imageIndex});

  final XFile image;
  final int imageIndex;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  var _textoExtraido = '';

  Future<void> _extracTextFormImage(XFile? image) async {
    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);
      setState(() {
        _textoExtraido = recognizedText.text;
      });
    } else {
      setState(() {
        _textoExtraido = 'Imagem invaldia';
      });
    }
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagem '),
        actions: [
          IconButton(
            onPressed: () async {
              await _extracTextFormImage(widget.image);
              showModalBottomSheet(
                context: context,
                builder: (context) => DescriptionWidget(
                  extratedText: _textoExtraido,
                  image: widget.image,
                ),
              );
            },
            icon: Icon(Icons.more_vert_sharp),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Image.file(
        File(widget.image.path),
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
