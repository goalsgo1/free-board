import 'package:flutter/material.dart';

class PreviewPasswordChangeModal extends StatelessWidget {
  const PreviewPasswordChangeModal({super.key});

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
          maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                      '비밀번호 변경',
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
                      '현재 비밀번호 *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '입력...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '새 비밀번호 *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '입력...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '새 비밀번호 확인 *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '입력...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F1E8),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF8B7355), width: 1),
                      ),
                      child: const Text(
                        '• 비밀번호는 최소 6자 이상이어야 합니다',
                        style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B7355),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          '변경하기',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
}

