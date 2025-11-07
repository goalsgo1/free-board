import 'package:flutter/material.dart';

class PreviewCategorySelectModal extends StatelessWidget {
  const PreviewCategorySelectModal({super.key});
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
        padding: const EdgeInsets.all(16),
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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF8B7355)),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    '카테고리 선택',
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
            const SizedBox(height: 16),
            _buildCategoryOption('슬픔'),
            const SizedBox(height: 8),
            _buildCategoryOption('기억'),
            const SizedBox(height: 8),
            _buildCategoryOption('위로'),
            const SizedBox(height: 16),
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
                child: const Text('선택하기', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryOption(String category) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8B7355), width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: category,
            groupValue: '슬픔',
            onChanged: (_) {},
            activeColor: const Color(0xFF8B7355),
          ),
          Text(category, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
