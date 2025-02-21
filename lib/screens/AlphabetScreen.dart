import 'package:flutter/material.dart';
import '../models/HandSign.dart';
import 'AlphabetDetailScreen.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  final List<HandSign> alphabetImages = List.generate(
    26,
        (index) => HandSign(
      name: String.fromCharCode(65 + index), // Generates letters A-Z
      image_path: 'assets/dataset/${String.fromCharCode(65 + index)}.JPG', // Reusing images for demo
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Alphabet Hand Signs"),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 columns
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.8,
          ),
          itemCount: alphabetImages.length,
          itemBuilder: (context, index) {
            final handSign = alphabetImages[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Add navigation or functionality on tap if needed

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlphabetDetailScreen(
                        title: 'Number ${handSign.name}',
                        handSign: handSign,
                      ),
                    ),
                  );
                  //
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Selected: ${handSign.name}')),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          handSign.image_path,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      handSign.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
