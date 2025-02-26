import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:camera/camera.dart';

import '../widgets/CustomDrawer.dart';  // To access the camera feed

class LiveCamera extends StatefulWidget {

  final String title;

  const LiveCamera({super.key, required this.title});

  @override
  State<LiveCamera> createState() => _LiveCameraState();
}

class _LiveCameraState extends State<LiveCamera> {

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String _result = "";
  late CameraImage _cameraImage;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    loadModel();
    initializeCamera();
  }

  @override
  void dispose() {
    Tflite.close();
    _cameraController?.dispose();
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

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras![0], // Using the first camera (usually the rear one)
      ResolutionPreset.medium,
    );
    await _cameraController!.initialize();

    // Set the callback to receive frames from the camera
    _cameraController!.startImageStream((CameraImage image) {
      if (!_isProcessing) {
        _isProcessing = true;
        _cameraImage = image;
        classifyImage(image);
      }
    });
    setState(() {});
  }

  Future<void> classifyImage(CameraImage image) async {
    try {
      // Convert the image from the camera into a format suitable for Tflite
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 5,
        threshold: 0.1,
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
    } finally {
      _isProcessing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Camera Preview
            _cameraController == null
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: CameraPreview(_cameraController!),
            ),
            const SizedBox(height: 20),
            // Result Display
            Text(
              _result.isNotEmpty ? "Prediction: $_result" : "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}