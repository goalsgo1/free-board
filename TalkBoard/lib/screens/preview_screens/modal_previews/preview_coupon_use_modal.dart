import 'package:flutter/material.dart';

class PreviewCouponUseModal extends StatelessWidget {
  const PreviewCouponUseModal({super.key});

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
                '쿠폰 사용 확인',
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
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.orange.withOpacity(0.3),
                            Colors.yellow.withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 48,
                            color: Colors.orange,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '프리미엄 할인 쿠폰',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '20% 할인',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '유효 기간: ~2024.03.31',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '이 쿠폰을 사용하시겠습니까?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '사용 후 즉시 할인이 적용됩니다.',
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
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              '사용하기',
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
            ),
          ],
        ),
      ),
    );
  }
}

