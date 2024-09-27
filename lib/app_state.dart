import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  double _score = 2.0;
  XFile? _image;
  DateTime? _selectedDate;

  double get score => _score;
  XFile? get image => _image;
  DateTime? get selectedDate => _selectedDate;

  AppState() {
    _loadData(); // Panggil fungsi untuk memuat data dari SharedPreferences saat AppState diinisialisasi
  }

  // Memuat data dari SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load score
    _score = prefs.getDouble('score') ?? 2.0;

    // Load image path
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      _image = XFile(imagePath);
    }

    // Load selected date
    String? selectedDateString = prefs.getString('selectedDate');
    if (selectedDateString != null) {
      _selectedDate = DateTime.parse(selectedDateString);
    }

    notifyListeners(); // Update UI setelah data dimuat
  }

  // Menyimpan score ke SharedPreferences
  void setScore(double value) async {
    _score = value;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('score', _score);
  }

  // Menyimpan image path ke SharedPreferences
  void setImage(XFile? imageFile) async {
    _image = imageFile;
    notifyListeners();
    if (_image != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', _image!.path);
    }
  }

  // Menyimpan selected date ke SharedPreferences
  void setSelectedDate(DateTime? date) async {
    _selectedDate = date;
    notifyListeners();
    if (_selectedDate != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('selectedDate', _selectedDate!.toIso8601String());
    }
  }
}
