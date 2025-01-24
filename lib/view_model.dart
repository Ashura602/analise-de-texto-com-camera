import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MainNotifier extends ChangeNotifier {
  List<XFile> imagens = [];

  void addImage(XFile picture) {
    imagens.add(picture);
    notifyListeners();
  }

  void removeImage(XFile picture) {
    imagens.removeWhere((item) => item == picture);
    notifyListeners();
  }
}
