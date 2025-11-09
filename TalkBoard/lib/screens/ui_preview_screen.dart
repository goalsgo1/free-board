import 'package:flutter/material.dart';
import 'package:free_board/screens/ui_preview_list_screen.dart';
import 'package:free_board/widgets/accessibility_button.dart';

class UIPreviewScreen extends StatelessWidget {
  const UIPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI 프리뷰'),
        backgroundColor: const Color(0xFF8B7355),
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: const UIPreviewListScreen(),
    );
  }
}

