import 'package:flutter/material.dart';
import 'package:flutter_hand_sign/models/HandSign.dart';

class NumberDetailScreen extends StatefulWidget {

  final String title;

  final HandSign handSign;

  const NumberDetailScreen({super.key, required this.title ,required this.handSign});

  @override
  State<NumberDetailScreen> createState() => _NumberDetailScreenState();
}

class _NumberDetailScreenState extends State<NumberDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Title
          // Text(
          //   widget.title,
          //   style: const TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          const SizedBox(height: 16),

          // Image placeholder (replace with actual asset or network image)
          SizedBox(
            height: 400,
            width: 400,
            child: Image.asset(
              widget.handSign.image_path, // Replace with your asset path
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
