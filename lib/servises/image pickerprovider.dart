import 'dart:io';
import 'package:flutter/material.dart';

class ImageProvidermodel extends ChangeNotifier {
  File? _image;

  File? get image => _image;

  void setImage(File? image) {
    _image = image;
    notifyListeners();
  }

   void clearImage() {
    _image = null;
    notifyListeners();
  }
}
