import 'package:flutter/material.dart';
import '../models/tool_model.dart';
import '../widgets/feature_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ToolModel> tools = [
      ToolModel(id: '1', title: 'Image Gen AI', description: 'Create rich images from text.', icon: Icons.image, routeName: '/image_gen'),
      ToolModel(id: '2', title: 'Image to Video', description: 'Animate your still images.', icon: Icons.video_library, routeName: '/image_video'),
      ToolModel(id: '3', title: 'Text to Video', description: 'AI video from prompts.', icon: Icons.videocam, routeName: '/text_video'),
      ToolModel(id: '4', title: 'Avatar Lip Sync', description: 'Make avatars speak.', icon: Icons.record_voice_over, routeName: '/lip_sync'),
      ToolModel(id: '5', title: 'Video Downloader', description: 'Download your creations.', icon: Icons.download, routeName: '/downloader'),
      ToolModel(id: '6', title: 'External Tools', description: 'Access web AI tools.', icon: Icons.web, routeName: '/webview'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('VisionForge AI', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome back, Creator \u{1f44b}", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text("What magic are we building today?", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: tools.length,
                  itemBuilder: (context, index) {
                    final tool = tools[index];
                    return FeatureCard(
                      tool: tool,
                      onTap: () {
                        Navigator.pushNamed(context, tool.routeName);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
