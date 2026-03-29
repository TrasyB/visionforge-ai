import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';
import '../services/api_service.dart';

class ImageToVideoScreen extends StatefulWidget {
  const ImageToVideoScreen({Key? key}) : super(key: key);

  @override
  State<ImageToVideoScreen> createState() => _ImageToVideoScreenState();
}

class _ImageToVideoScreenState extends State<ImageToVideoScreen> {
  bool _isLoading = false;
  String? _videoUrl;

  Future<void> _generate() async {
    setState(() {
      _isLoading = true;
      _videoUrl = null;
    });

    final result = await ApiService.imageToVideo("dummy_path");

    setState(() {
      _isLoading = false;
      _videoUrl = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image to Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.upload_file, size: 48, color: Colors.white54),
                  SizedBox(height: 8),
                  Text("Tap to upload starting image", style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Animate Image',
              onPressed: _generate,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: _videoUrl == null
                  ? const Center(child: Text("Video result will appear here"))
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white70),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
