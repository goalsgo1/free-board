import 'package:flutter/material.dart';

class PreviewPaymentCompleteModal extends StatelessWidget {
  const PreviewPaymentCompleteModal({super.key});

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
        ),
        padding: const EdgeInsets.all(24),
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
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              '결제가 완료되었습니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B7355),
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
              child: const Column(
                children: [
                  Text('결제 금액: ₩12,400', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Text('결제 일시: 2024.03.15 14:30', style: TextStyle(fontSize: 12)),
                ],
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
                  '확인',
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
    );
  }
}
