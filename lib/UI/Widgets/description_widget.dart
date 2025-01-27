import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  DescriptionWidget({super.key, required this.extratedText, required this.image});

  final extratedText;
  XFile image;

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Description of image:\n ${widget.image.name} \n'),
            Text('Texto extraído:\n ${widget.extratedText}')
          ],
        ),
      ),
    );
  }
}
