import 'package:flutter/material.dart';

class HandSignDictionaryScreen extends StatefulWidget {

  final String title;

  const HandSignDictionaryScreen({super.key, required this.title});

  @override
  State<HandSignDictionaryScreen> createState() => _HandSignDictionaryScreenState();
}

class _HandSignDictionaryScreenState extends State<HandSignDictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
