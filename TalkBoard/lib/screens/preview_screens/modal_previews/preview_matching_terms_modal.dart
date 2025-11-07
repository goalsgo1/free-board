import 'package:flutter/material.dart';

class PreviewMatchingTermsModal extends StatelessWidget {
  const PreviewMatchingTermsModal({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 32,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: const Text(
                '이용 약관 동의',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: warmBrown,
                ),
              ),
              backgroundColor: warmBeige,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: warmBrown),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '매칭 서비스 이용 약관',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: warmBeige.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: warmBrown.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: const SingleChildScrollView(
                        child: Text(
                          '약관 내용 스크롤...\n\n제1조 (목적)\n이 약관은...\n\n제2조 (정의)\n1. "서비스"란...\n\n제3조 (약관의 효력 및 변경)\n1. 이 약관은...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2C2C2C),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '약관 동의 *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: warmBrown,
                        ),
                        const Expanded(
                          child: Text(
                            '매칭 서비스 이용 약관 동의',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: warmBrown,
                        ),
                        const Expanded(
                          child: Text(
                            '개인정보 처리 방침 동의',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: warmBrown,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          '동의하고 계속하기',
                          style: TextStyle(
                            fontSize: 14,
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

