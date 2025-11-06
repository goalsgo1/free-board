import 'package:flutter/material.dart';

class PreviewDonationHistoryScreen extends StatelessWidget {
  const PreviewDonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '추모금 내역',
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
            // 필터
            Row(
              children: [
                _buildFilterChip('전체', true),
                const SizedBox(width: 8),
                _buildFilterChip('수령', false),
                const SizedBox(width: 8),
                _buildFilterChip('전달', false),
                const SizedBox(width: 8),
                _buildFilterChip('최신순', false),
                const SizedBox(width: 8),
                _buildFilterChip('금액순', false),
              ],
            ),
            const SizedBox(height: 24),
            // 수령 내역
            _buildDonationCard(
              '수령',
              '₩25,000',
              '전달자: 위로의 마음',
              '수수료: ₩1,250 (5%)',
              '유지비: ₩1,900',
              '수령액: ₩21,850',
              '2024.01.15 14:30',
              warmBeige,
            ),
            const SizedBox(height: 12),
            _buildDonationCard(
              '수령',
              '₩10,000',
              '전달자: 따뜻한 마음',
              '수수료: ₩500 (5%)',
              '유지비: ₩1,900',
              '수령액: ₩7,600',
              '2024.01.10 09:20',
              warmBeige,
            ),
            const SizedBox(height: 12),
            // 전달 내역
            _buildDonationCard(
              '전달',
              '₩50,000',
              '수령자: [고인 이름] 추모관',
              '',
              '',
              '',
              '2024.01.05 16:45',
              warmBeige,
            ),
            const SizedBox(height: 24),
            // 총액
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warmBrown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: warmBrown.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '총 수령액:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                  ),
                  Text(
                    '₩29,450',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: warmBrown,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warmBrown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: warmBrown.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '총 전달액:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                  ),
                  Text(
                    '₩50,000',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: warmBrown,
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

  Widget _buildFilterChip(String label, bool isSelected) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {},
      selectedColor: warmBrown,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : warmBrown,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      ),
      backgroundColor: warmBeige,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: warmBrown.withOpacity(0.3),
          width: 2,
        ),
      ),
    );
  }

  Widget _buildDonationCard(
    String type,
    String amount,
    String donor,
    String fee,
    String maintenance,
    String netAmount,
    String date,
    Color backgroundColor,
  ) {
    const Color warmBrown = Color(0xFF8B7355);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    type == '수령' ? Icons.arrow_downward : Icons.arrow_upward,
                    color: warmBrown,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                  ),
                ],
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: warmBrown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            donor,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5C5C5C),
            ),
          ),
          if (fee.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              fee,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF5C5C5C),
              ),
            ),
          ],
          if (maintenance.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              maintenance,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF5C5C5C),
              ),
            ),
          ],
          if (netAmount.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              netAmount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: warmBrown,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}

