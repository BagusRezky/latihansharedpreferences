//Latihan 1
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _score = 2.0;
  XFile? _image;
  DateTime? _selectedDate;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSelectedDate(); // Load tanggal yang disimpan di SharedPreferences
  }

  // Memuat tanggal yang disimpan di SharedPreferences
  Future<void> _loadSelectedDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedDate = prefs.getString('selectedDate');

    if (savedDate != null) {
      setState(() {
        _selectedDate = DateTime.parse(savedDate);
      });
    }
  }

  // Simpan tanggal ke SharedPreferences
  Future<void> _saveSelectedDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedDate', date.toIso8601String());
  }

  // Memilih gambar dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  // Memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _saveSelectedDate(picked); // Simpan tanggal yang dipilih
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
                ? Image.file(File(_image!.path), height: 200)
                : Container(
                    height: 200,
                    color: Colors.pinkAccent,
                    child: const Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Take Image'),
            ),
            const SizedBox(height: 20),
            SpinBox(
              min: 0,
              max: 100,
              value: _score,
              onChanged: (value) {
                setState(() {
                  _score = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 10),
            Text(
              _selectedDate == null
                  ? 'No date selected'
                  : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
            ),
          ],
        ),
      ),
    );
  }
}



//Latihan 2
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart'; // Import untuk format tanggal
// import 'package:provider/provider.dart'; // Import provider

// import 'app_state.dart'; // Import file untuk state management

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => AppState(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final ImagePicker _picker = ImagePicker();

//   MyHomePage({super.key});

//   Future<void> _pickImage(BuildContext context) async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     Provider.of<AppState>(context, listen: false).setImage(pickedFile);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       Provider.of<AppState>(context, listen: false).setSelectedDate(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('My Bio')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             appState.image != null
//                 ? Image.file(File(appState.image!.path), height: 200)
//                 : Container(
//                     height: 200,
//                     color: Colors.pinkAccent,
//                     child: const Center(
//                       child: Text(
//                         'No image selected',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _pickImage(context),
//               child: const Text('Take Image'),
//             ),
//             const SizedBox(height: 20),
//             SpinBox(
//               min: 0,
//               max: 100,
//               value: appState.score,
//               onChanged: (value) {
//                 appState.setScore(value);
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: const Text('Select Date'),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               appState.selectedDate == null
//                   ? 'No date selected'
//                   : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(appState.selectedDate!)}',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
