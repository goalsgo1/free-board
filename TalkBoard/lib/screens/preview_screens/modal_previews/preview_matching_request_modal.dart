import 'package:flutter/material.dart';

class PreviewMatchingRequestModal extends StatelessWidget {
  const PreviewMatchingRequestModal({super.key});

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
          maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                '매칭 신청',
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
                      '신청 메시지 작성 *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 100,
                        maxHeight: 200,
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
                      child: const TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: '간단한 인사말 및 자기소개...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '안내',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• 신중하게 작성해주세요',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                          Text(
                            '• 상대방이 검토 후 수락/거절합니다',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '이용 약관 동의 *',
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
                          '신청하기',
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

