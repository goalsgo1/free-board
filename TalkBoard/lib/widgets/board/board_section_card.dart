import 'package:flutter/material.dart';

import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';

/// 래퍼 위젯: [AppSurfaceCard]에 보드 테마 데이터를 쉽게 연결하기 위한 도우미.
class BoardSectionCard extends StatelessWidget {
  const BoardSectionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.child,
  }) : super(key: key);

  BoardSectionCard.fromIntro({
    Key? key,
    required BoardIntroSection intro,
    required Widget child,
  }) : this(
          key: key,
          title: intro.title,
          subtitle: intro.subtitle,
          icon: intro.icon,
          accentColor: intro.accentColor,
          child: child,
        );

  BoardSectionCard.fromTagSection({
    Key? key,
    required BoardTagSection tagSection,
    required Widget child,
  }) : this(
          key: key,
          title: tagSection.title,
          subtitle: tagSection.subtitle,
          icon: tagSection.icon,
          accentColor: tagSection.accentColor,
          child: child,
        );

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      accentColor: accentColor,
      child: child,
    );
  }
}

class BoardHelperMessages extends StatelessWidget {
  const BoardHelperMessages({
    super.key,
    required this.messages,
  });

  final List<BoardHelperMessage> messages;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: messages
          .map(
            (message) => AppHelperText(
              icon: message.icon,
              text: message.text,
            ),
          )
          .toList(),
    );
  }
}


