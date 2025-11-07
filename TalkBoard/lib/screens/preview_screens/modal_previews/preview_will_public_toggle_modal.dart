import 'package:flutter/material.dart';

class PreviewWillPublicToggleModal extends StatelessWidget {
  const PreviewWillPublicToggleModal({super.key});

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
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        padding: const EdgeInsets.all(24),
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
            const Icon(
              Icons.lock_outline,
              size: 64,
              color: warmBrown,
            ),
            const SizedBox(height: 16),
            const Text(
              '공개 상태를 변경하시겠습니까?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C2C2C),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warmBeige.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: warmBrown.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '현재:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                      Text(
                        '비공개',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '변경:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                      Text(
                        '전체 공개',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: warmBrown,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '공개 시 다른 사용자들이 이 유언을\n읽고 참고할 수 있습니다.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5C5C5C),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: warmBrown, width: 1),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: warmBrown,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
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
                      '변경',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

