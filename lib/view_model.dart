import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MainNotifier extends ChangeNotifier {
  List<XFile> imagens = [];

  Future<CameraDescription> getCamera() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

  void addImage(XFile picture) {
    imagens.add(picture);
    notifyListeners();
  }

  void removeImage(XFile picture) {
    imagens.removeWhere((item) => item == picture);
    notifyListeners();
  }
}
