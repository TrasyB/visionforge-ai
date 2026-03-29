import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';

class LipSyncScreen extends StatefulWidget {
  const LipSyncScreen({Key? key}) : super(key: key);

  @override
  State<LipSyncScreen> createState() => _LipSyncScreenState();
}

class _LipSyncScreenState extends State<LipSyncScreen> {
  int _selectedModelIndex = 0;
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();

  Future<void> _generate() async {
    setState(() => _isLoading = true);
    await ApiService.generateLipSync("dummy", _textController.text);
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lip Sync Generated! Check gallery.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Free AI Lip Sync Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Upload Section
            const Text("1. Upload Video", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Supported formats: mp4, webm, ogg", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text("Maximum file size: 30MB", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Sample Avatars", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // 2. Model Select Section
            const Text("2. Model Select", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedModelIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedModelIndex == 0 ? const Color(0xFF6C63FF).withOpacity(0.1) : const Color(0xFF1E1E1E),
                        border: Border.all(color: _selectedModelIndex == 0 ? const Color(0xFF6C63FF) : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Lip Sync 1.0", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Fastest, cheap, only supports portraits", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(height: 4),
                          Text(r"🪙 1 Credits/s  ⏳ 90s", style: TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedModelIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedModelIndex == 1 ? const Color(0xFF6C63FF).withOpacity(0.1) : const Color(0xFF1E1E1E),
                        border: Border.all(color: _selectedModelIndex == 1 ? const Color(0xFF6C63FF) : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Lip Sync 2.0 (New)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Realistic lip-syncing & movements", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(height: 4),
                          Text(r"🪙 8 Credits/s  ⏳ 30s", style: TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 3. Audio/Text Section
            const Text("3. Enter your text, upload or record audio", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                          ),
                          child: const Center(child: Text("Input Text", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(child: Text("Upload Audio", style: TextStyle(color: Colors.grey))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(child: Text("Record Audio", style: TextStyle(color: Colors.grey))),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomTextField(
                      hintText: "Type what you want to say...",
                      controller: _textController,
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.translate, size: 16, color: Colors.grey),
                            SizedBox(width: 4), Text("Translate", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            SizedBox(width: 16),
                            Icon(Icons.smart_toy, size: 16, color: Colors.grey),
                            SizedBox(width: 4), Text("AI Script", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const Text("0 / 1000", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: "Generate Lip Sync", onPressed: _generate, isLoading: _isLoading),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
