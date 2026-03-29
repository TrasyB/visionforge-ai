import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../services/api_service.dart';

class ImageGenerationScreen extends StatefulWidget {
  const ImageGenerationScreen({Key? key}) : super(key: key);

  @override
  State<ImageGenerationScreen> createState() => _ImageGenerationScreenState();
}

class _ImageGenerationScreenState extends State<ImageGenerationScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _imageUrl;

  Future<void> _generate() async {
    if (_promptController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _imageUrl = null;
    });

    final resultUrl = await ApiService.generateImage(_promptController.text);

    setState(() {
      _isLoading = false;
      _imageUrl = resultUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Image Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Enter your prompt (e.g., A cyber dog on mars)...',
              controller: _promptController,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Generate Image',
              onPressed: _generate,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: _imageUrl == null
                  ? Center(child: Text("Your generated image will appear here", style: Theme.of(context).textTheme.bodyMedium))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        _imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
