import 'package:flutter/material.dart';

class PreviewProfileEditScreen extends StatelessWidget {
  const PreviewProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '개인정보 수정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 프로필 사진
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: warmBeige,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: warmBrown.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: warmBrown,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warmBrown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text('사진 변경'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 이름
            _buildTextField('이름 *', '사용자 이름'),
            const SizedBox(height: 16),
            // 이메일
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warmBeige.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: warmBrown.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '이메일',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'user@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '(이메일 변경은 별도 인증 필요)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 비밀번호 변경
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warmBeige,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: warmBrown.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '비밀번호 변경',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: warmBrown,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warmBrown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text('변경하기'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // 저장 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: warmBrown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '저장',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: warmBrown,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: warmBeige,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: warmBrown.withOpacity(0.3),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: warmBrown.withOpacity(0.3),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: warmBrown,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}

