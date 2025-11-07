import 'package:flutter/material.dart';

class PreviewDonationModal extends StatelessWidget {
  const PreviewDonationModal({super.key});

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
          maxHeight: MediaQuery.of(context).size.height * 0.8,
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
            // AppBar
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
                      '추모금 전달',
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
                      '금액 입력',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF8B7355), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '₩ ',
                          prefixStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: '10,000',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '안내',
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
                            '• 전달 금액의 5% 수수료 차감',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• ₩1,900 유지비 차감',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• 수령액: ₩7,600',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5C5C5C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '결제 수단 선택',
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
                      child: Column(
                        children: [
                          _buildPaymentMethodOption('카드'),
                          const Divider(height: 24),
                          _buildPaymentMethodOption('계좌이체'),
                          const Divider(height: 24),
                          _buildPaymentMethodOption('간편결제'),
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
                          '추모금 전달하기',
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

  Widget _buildPaymentMethodOption(String method) {
    return Row(
      children: [
        Radio<String>(
          value: method,
          groupValue: '카드',
          onChanged: (_) {},
          activeColor: const Color(0xFF8B7355),
        ),
        Text(
          method,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF5C5C5C),
          ),
        ),
      ],
    );
  }
}

