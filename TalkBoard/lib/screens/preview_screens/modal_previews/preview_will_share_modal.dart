import 'package:flutter/material.dart';

class PreviewWillShareModal extends StatelessWidget {
  const PreviewWillShareModal({super.key});

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
                '유언 공유',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '공유 링크',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: warmBeige.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: warmBrown.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'https://memorial.app/will/...',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C5C5C),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: const BorderSide(color: warmBrown, width: 1),
                            ),
                            child: const Text(
                              '복사',
                              style: TextStyle(
                                fontSize: 12,
                                color: warmBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'SNS 공유',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSNSButton('카카오톡', Icons.chat_bubble_outline),
                        _buildSNSButton('페이스북', Icons.facebook),
                        _buildSNSButton('트위터', Icons.alternate_email),
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

  Widget _buildSNSButton(String label, IconData icon) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: warmBeige,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: warmBrown.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: warmBrown,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF5C5C5C),
          ),
        ),
      ],
    );
  }
}

