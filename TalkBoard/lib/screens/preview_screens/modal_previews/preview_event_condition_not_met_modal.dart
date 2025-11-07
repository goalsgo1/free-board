import 'package:flutter/material.dart';

class PreviewEventConditionNotMetModal extends StatelessWidget {
  const PreviewEventConditionNotMetModal({super.key});

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
          maxHeight: MediaQuery.of(context).size.height * 0.7,
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
              Icons.warning_amber_rounded,
              size: 64,
              color: Colors.amber,
            ),
            const SizedBox(height: 16),
            const Text(
              '감사 혜택 참여 조건을 충족하지 못했습니다',
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
                    '필요 조건:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        '공감 100개 이상',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '현재 상태:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.error_outline, size: 16, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        '공감 67개',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      '• 33개 더 필요합니다',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '조건을 충족하면 자동으로 혜택이 지급됩니다.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5C5C5C),
              ),
              textAlign: TextAlign.center,
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
                  '확인',
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
    );
  }
}

