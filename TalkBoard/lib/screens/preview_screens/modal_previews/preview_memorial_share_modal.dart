import 'package:flutter/material.dart';

class PreviewMemorialShareModal extends StatelessWidget {
  const PreviewMemorialShareModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF8B7355), width: 2),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 32,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF8B7355)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      '추모관 공유',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B7355),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '공유 링크',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF8B7355), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'https://memorial.app/...',
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('복사'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'QR 코드',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF8B7355), width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Icon(Icons.qr_code, size: 100, color: Color(0xFF8B7355)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('저장하기'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'SNS 공유',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSnsButton(Icons.chat, '카카오톡'),
                        _buildSnsButton(Icons.facebook, '페이스북'),
                        _buildSnsButton(Icons.alternate_email, '트위터'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '공유 통계',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F1E8),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF8B7355), width: 1),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '공유 횟수: 15회',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '공유를 통해 방문: 8명',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnsButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF8B7355), width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, color: const Color(0xFF8B7355)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
        ),
      ],
    );
  }
}

