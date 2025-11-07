import 'package:flutter/material.dart';

class PreviewImageViewerModal extends StatelessWidget {
  const PreviewImageViewerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: const Color(0xFF8B7355), width: 2),
              ),
              child: const Icon(Icons.image, size: 100, color: Color(0xFF8B7355)),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    onPressed: () {},
                  ),
                  const Text(
                    '1/5',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

