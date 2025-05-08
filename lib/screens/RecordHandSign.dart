import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class RecordHandSignScreen extends StatefulWidget {

  final String title;

  const RecordHandSignScreen({super.key, required this.title});

  @override
  _RecordHandSignScreenState createState() => _RecordHandSignScreenState();
}

class _RecordHandSignScreenState extends State<RecordHandSignScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isDetecting = false;
  String _prediction = "Detecting...";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0], // Use the first available camera
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});

      // Start streaming frames for detection
      _controller!.startImageStream((CameraImage image) {
        if (!_isDetecting) {
          _isDetecting = true;
          _runModelOnFrame(image).then((_) {
            _isDetecting = false;
          });
        }
      });
    }
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite", // Your trained model
      labels: "assets/labels.txt",
    );
  }

  Future<void> _runModelOnFrame(CameraImage image) async {
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((plane) => plane.bytes).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 2, // Number of top results
      threshold: 0.5,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      setState(() {
        _prediction = recognitions[0]['label']; // Get top prediction
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Real-time Hand Sign Detection")),
      body: Column(
        children: [
          _controller == null || !_controller!.value.isInitialized
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: CameraPreview(_controller!),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
            child: Text(
              "Prediction: $_prediction",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
