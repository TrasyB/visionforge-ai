import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../services/api_service.dart';

class TextToVideoScreen extends StatefulWidget {
  const TextToVideoScreen({Key? key}) : super(key: key);

  @override
  State<TextToVideoScreen> createState() => _TextToVideoScreenState();
}

class _TextToVideoScreenState extends State<TextToVideoScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _videoUrl;

  Future<void> _generate() async {
    if (_promptController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _videoUrl = null;
    });

    final resultUrl = await ApiService.textToVideo(_promptController.text);

    setState(() {
      _isLoading = false;
      _videoUrl = resultUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text to Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Describe the video scene you want...',
              controller: _promptController,
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Generate Video',
              onPressed: _generate,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: _videoUrl == null
                  ? const Center(child: Text("Generated video will play here"))
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
