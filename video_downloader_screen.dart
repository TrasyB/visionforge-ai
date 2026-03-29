import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../services/api_service.dart';

class VideoDownloaderScreen extends StatefulWidget {
  const VideoDownloaderScreen({Key? key}) : super(key: key);

  @override
  State<VideoDownloaderScreen> createState() => _VideoDownloaderScreenState();
}

class _VideoDownloaderScreenState extends State<VideoDownloaderScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;

  Future<void> _download() async {
    if (_urlController.text.isEmpty) return;
    setState(() => _isLoading = true);
    final success = await ApiService.downloadVideo(_urlController.text);
    setState(() => _isLoading = false);
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video saved to Gallery successfully!')),
      );
      _urlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download Creations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Paste video URL here...',
              controller: _urlController,
              prefixIcon: Icons.link,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Download Video',
              onPressed: _download,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
