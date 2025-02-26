import 'package:flutter/material.dart';

// HandSign model
class HandSign {
  final String name;
  final String imagePath;

  HandSign({required this.name, required this.imagePath});
}

// Number hand signs
final List<HandSign> numberImages = List.generate(
  10,
      (index) => HandSign(
    name: '$index',
    imagePath: 'assets/dataset/$index.JPG',
  ),
);

// Alphabet hand signs (A-Z)
final List<HandSign> alphabetImages = List.generate(
  26,
      (index) => HandSign(
    name: String.fromCharCode(65 + index),
    imagePath: 'assets/dataset/${String.fromCharCode(65 + index)}.JPG',
  ),
);

class LanguageToHandSignScreen extends StatefulWidget {

  final String title;

  const LanguageToHandSignScreen({super.key, required this.title});

  @override
  _LanguageToHandSignScreenState createState() => _LanguageToHandSignScreenState();
}

class _LanguageToHandSignScreenState extends State<LanguageToHandSignScreen> {
  final TextEditingController _textController = TextEditingController();
  List<HandSign> _convertedSigns = [];

  void _convertTextToSigns(String text) {
    List<HandSign> signs = [];
    for (var char in text.toUpperCase().characters) {
      if (RegExp(r'[A-Z]').hasMatch(char)) {
        signs.add(alphabetImages.firstWhere((sign) => sign.name == char));
      } else if (RegExp(r'[0-9]').hasMatch(char)) {
        signs.add(numberImages.firstWhere((sign) => sign.name == char));
      }
    }

    setState(() {
      _convertedSigns = signs;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language to Hand Sign'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Typing box
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text (A-Z, 0-9)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                    setState(() => _convertedSigns = []);
                  },
                ),
              ),
              onChanged: _convertTextToSigns,
            ),
            const SizedBox(height: 20),

            // Hand sign display
            _convertedSigns.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _convertedSigns.length,
                itemBuilder: (context, index) {
                  final sign = _convertedSigns[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          sign.imagePath,
                          width: 80,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                        ),
                        const SizedBox(height: 4),
                        Text(sign.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            )
                : const Expanded(
              child: Center(
                child: Text(
                  "Type text above to see hand signs.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
