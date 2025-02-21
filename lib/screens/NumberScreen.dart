import 'package:flutter/material.dart';
import 'package:flutter_hand_sign/models/HandSign.dart';
import 'package:flutter_hand_sign/screens/NumberDetailScreen.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final List<HandSign> numberImages = [
    HandSign(name: '0', image_path: 'assets/dataset/0.JPG'),
    HandSign(name: '1', image_path: 'assets/dataset/1.JPG'),
    HandSign(name: '2', image_path: 'assets/dataset/2.JPG'),
    HandSign(name: '3', image_path: 'assets/dataset/3.JPG'),
    HandSign(name: '4', image_path: 'assets/dataset/4.JPG'),
    HandSign(name: '5', image_path: 'assets/dataset/5.JPG'),
    HandSign(name: '6', image_path: 'assets/dataset/6.JPG'),
    HandSign(name: '7', image_path: 'assets/dataset/7.JPG'),
    HandSign(name: '8', image_path: 'assets/dataset/8.JPG'),
    HandSign(name: '9', image_path: 'assets/dataset/9.JPG'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: numberImages.length,
        itemBuilder: (context, index) {
          final handSign = numberImages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  handSign.image_path,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 60),
                ),
              ),
              title: Text(
                'Number ${handSign.name}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: const Text('Hand sign representation'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NumberDetailScreen(
                      title: 'Number ${handSign.name}',
                      handSign: handSign,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
