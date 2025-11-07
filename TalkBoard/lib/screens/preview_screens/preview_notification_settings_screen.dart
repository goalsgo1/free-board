import 'package:flutter/material.dart';

class PreviewNotificationSettingsScreen extends StatelessWidget {
  const PreviewNotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '알림 설정',
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
          children: [
            _buildNotificationItem(
              '🎂',
              '기념일 알림',
              '고인의 생일/기일에 알림',
              true,
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              '💬',
              '댓글 알림',
              '댓글이 달렸을 때 알림',
              true,
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              '🕊️',
              '기도 알림',
              '기도 요청이 있을 때 알림',
              true,
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              '💌',
              '홈 화면 공개 제안 알림',
              '공감을 많이 받은 추모글에 대해 홈 화면 공개를 제안하는 알림',
              true,
            ),
            const SizedBox(height: 32),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '알림 시간 설정',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '알림 수신 시간',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5C5C5C),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '09:00 ~ 22:00',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: warmBrown,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String emoji,
    String title,
    String description,
    bool isEnabled,
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
            style: const TextStyle(fontSize: 24),
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
          Switch(
            value: isEnabled,
            onChanged: (value) {},
            activeColor: warmBrown,
          ),
        ],
      ),
    );
  }
}

