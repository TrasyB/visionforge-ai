import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/image_generation_screen.dart';
import 'screens/image_to_video_screen.dart';
import 'screens/text_to_video_screen.dart';
import 'screens/lip_sync_screen.dart';
import 'screens/video_downloader_screen.dart';
import 'screens/webview_screen.dart';

void main() {
  runApp(const VisionForgeApp());
}

class VisionForgeApp extends StatelessWidget {
  const VisionForgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VisionForge AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
      routes: {
        '/image_gen': (context) => const ImageGenerationScreen(),
        '/image_video': (context) => const ImageToVideoScreen(),
        '/text_video': (context) => const TextToVideoScreen(),
        '/lip_sync': (context) => const LipSyncScreen(),
        '/downloader': (context) => const VideoDownloaderScreen(),
        '/webview': (context) => const WebViewScreen(),
      },
    );
  }
}
