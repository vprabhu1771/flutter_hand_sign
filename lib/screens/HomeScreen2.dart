import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hand_sign/screens/HandSignDictionaryScreen.dart';
import 'package:flutter_hand_sign/screens/RecordHandSign.dart';
import 'package:flutter_hand_sign/screens/SettingScreen.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/CustomDrawer.dart';
import 'LanguageToHandSignScreen.dart';

class HomeScreen2 extends StatefulWidget {
  final String title;

  const HomeScreen2({super.key, required this.title});

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  File? _selectedImage;
  String _result = "";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/ml/model_unquant.tflite",
        labels: "assets/ml/labels.txt",
      );
      print("Model loaded: $res");
    } catch (e) {
      print("Failed to load model: $e");
    }
  }

  Future<void> classifyImage(File image) async {

    await Tflite.close(); // Close previous instance
    await loadModel(); // Reload the model

    try {
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.5,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        setState(() {
          _result = recognitions.first["label"] ?? "Unknown";
        });
      } else {
        setState(() {
          _result = "No result found.";
        });
      }
    } catch (e) {
      print("Error in classification: $e");
      setState(() {
        _result = "Error in classification.";
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        // _result = "Recognized Hand Sign: Hello"; // Example result
        _result = ""; // Reset result
      });
      await classifyImage(_selectedImage!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _selectedImage == null
            ? _buildMenuUI() // Show menu if no image is selected
            : _buildResultUI(), // Show result UI if image is selected
      ),
    );
  }

  /// **Menu UI - Shows when no image is selected**
  Widget _buildMenuUI() {
    return Column(
      children: [
        Expanded(
          child: Center(child: Image.asset("assets/splash_logo.jpg")),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard("Gallery", Icons.photo, () => pickImage(ImageSource.gallery)),
            _buildCard("Camera", Icons.camera, () => pickImage(ImageSource.camera)),
            _buildCard("Settings", Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen(title: "Settings")),
              );
            }),
            _buildCard("Hand Sign Dictionary", Icons.menu_book, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HandSignDictionaryScreen(title: "Hand Sign Dictionary"),
                ),
              );
            }),
            _buildCard("Language to Hand Sign", Icons.menu_book, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageToHandSignScreen(title: "Language to Hand Sign"),
                ),
              );
            }),
            _buildCard("Live Translation", Icons.translate, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordHandSignScreen(title: "Live")),
              );
            }),
          ],
        ),
      ],
    );
  }

  /// **Result UI - Shows when an image is selected**
  Widget _buildResultUI() {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(_selectedImage!, fit: BoxFit.cover, width: 100, height: 100,),
              const SizedBox(height: 20),
              Text(
                _result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _selectedImage = null; // Reset image and return to menu
            });
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text("Back to Menu"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  /// **Reusable Card Widget**
  Widget _buildCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
