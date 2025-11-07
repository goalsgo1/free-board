import 'package:flutter/material.dart';
import 'modals_preview_list_screen.dart';

class PreviewModalsScreen extends StatelessWidget {
  const PreviewModalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('팝업/모달 프리뷰'),
        backgroundColor: const Color(0xFF8B7355),
        foregroundColor: Colors.white,
      ),
      body: const ModalsPreviewListScreen(),
    );
  }
}

