import 'dart:io';

import 'package:analise_camera_app/view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';

class ImageView extends StatefulWidget {
  const ImageView(
      {super.key,
      required this.image,
      required this.imageIndex});

  final XFile image;
  final int imageIndex;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  var _textoExtraido = '';

  Future<String> _extracTextFormImage(XFile? image) async {
    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);
      setState(() {
        _textoExtraido = recognizedText.text;
      });
      return recognizedText.text;
    } else {
      setState(() {
        _textoExtraido = 'Imagem invaldia';
      });
      return 'Imagem invalida';
    }
  }

  @override
  void dispose() { 
    _textRecognizer.close();
    super.dispose();
    
  }


  @override
  Widget build(BuildContext context) {
    var mainNotifier = context.watch<MainNotifier>();
    return Column(
      children: [
        Container(
          child: Image.file(
            File(widget.image.path),
          ),
        ),
        Container(
          child: FutureBuilder(
            future:
                _extracTextFormImage(mainNotifier.imagens[widget.imageIndex]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data!);
              } else if( snapshot.connectionState == ConnectionState.active) {
                return LinearProgressIndicator();
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }
}
