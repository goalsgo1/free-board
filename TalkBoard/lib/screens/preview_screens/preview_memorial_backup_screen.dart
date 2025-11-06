import 'package:flutter/material.dart';

class PreviewMemorialBackupScreen extends StatelessWidget {
  const PreviewMemorialBackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '추모관 백업/내보내기',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 추모관 정보
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
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: warmBrown.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: warmBrown,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      '[고인 이름] 추모관',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: warmBrown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '내보내기 형식 선택',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: warmBrown,
              ),
            ),
            const SizedBox(height: 16),
            // PDF 내보내기
            _buildBackupOption(
              '📄',
              'PDF 내보내기',
              '추모관 전체 내용을 PDF로 저장',
              '내보내기',
            ),
            const SizedBox(height: 12),
            // 사진/영상 다운로드
            _buildBackupOption(
              '📷',
              '사진/영상 다운로드',
              '추모관의 모든 사진과 영상 다운로드',
              '다운로드',
            ),
            const SizedBox(height: 12),
            // 편지 텍스트 내보내기
            _buildBackupOption(
              '💌',
              '편지 텍스트 내보내기',
              '모든 편지 내용을 텍스트 파일로',
              '내보내기',
            ),
            const SizedBox(height: 12),
            // 전체 데이터 백업
            _buildBackupOption(
              '💾',
              '전체 데이터 백업',
              '추모관 전체 데이터를 JSON 형식으로',
              '백업하기',
            ),
            const SizedBox(height: 32),
            // 안내
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
                    '안내',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• 백업 파일은 안전하게 보관하세요',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• 사진/영상은 원본 품질로 다운로드됩니다',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• 백업에는 개인정보가 포함될 수 있습니다',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupOption(
    String emoji,
    String title,
    String description,
    String buttonText,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warmBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: warmBrown.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: warmBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5C5C5C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: warmBrown,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

