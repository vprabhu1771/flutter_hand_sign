import 'package:flutter/material.dart';

class NumberScreen extends StatefulWidget {

  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {

  final List<String> numberImages = [
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
    'https://bezzyxfbmfykhwqqioys.supabase.co/storage/v1/object/public/assets//no_image_available.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: // Numbers Tab Content
      ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  numberImages[index],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Number ${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: const Text('Hand sign representation'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation or image enlargement action here.
              },
            ),
          );
        },
      ),
    );
  }
}
