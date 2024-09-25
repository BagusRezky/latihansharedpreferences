import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppState extends ChangeNotifier {
  double _score = 2.0;
  XFile? _image;
  DateTime? _selectedDate;

  double get score => _score;
  XFile? get image => _image;
  DateTime? get selectedDate => _selectedDate;

  void setScore(double value) {
    _score = value;
    notifyListeners();
  }

  void setImage(XFile? imageFile) {
    _image = imageFile;
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }
}
