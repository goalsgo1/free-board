import 'package:flutter/material.dart';

class PreviewWithdrawalModal extends StatelessWidget {
  const PreviewWithdrawalModal({super.key});

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
          maxHeight: MediaQuery.of(context).size.height * 0.9,
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
                      '추모금 출금 요청',
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
                      '출금 가능 금액',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F1E8),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF8B7355), width: 2),
                      ),
                      child: const Text(
                        '₩25,000',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B7355),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '출금 금액',
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
                          hintText: '25,000',
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
                      '계좌 정보',
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
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: '은행',
                              border: InputBorder.none,
                            ),
                            items: ['KB국민은행', '신한은행', '우리은행']
                                .map((bank) => DropdownMenuItem(
                                      value: bank,
                                      child: Text(bank),
                                    ))
                                .toList(),
                            onChanged: (_) {},
                            value: 'KB국민은행',
                          ),
                          const Divider(),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: '계좌번호',
                              border: InputBorder.none,
                              hintText: '입력...',
                            ),
                          ),
                          const Divider(),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: '예금주',
                              border: InputBorder.none,
                              hintText: '입력...',
                            ),
                          ),
                        ],
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
                            '• 출금은 영업일 기준 1-2일 소요',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• 최소 출금 금액: ₩10,000',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                          ),
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
                          '출금 요청하기',
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

