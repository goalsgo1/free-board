import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class PreviewMemorialLetterWriteScreen extends StatelessWidget {
  const PreviewMemorialLetterWriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('추모 편지 남기기 (Preview)'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _IntroSection(),
            SizedBox(height: 20),
            _LetterFormSection(),
            SizedBox(height: 20),
            _GuidelineSection(),
            SizedBox(height: 20),
            _PreviewSection(),
          ],
        ),
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '따뜻한 마음을 전해주세요',
      subtitle: '추모 편지는 가족과 친구들에게 큰 위로가 됩니다.',
      icon: Icons.favorite_outline,
      accentColor: AppPalette.accentPink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '1. 가장 기억에 남는 순간을 떠올려 보세요.\n2. 전하고 싶었던 말과 감사한 마음을 담아보세요.\n3. 다른 가족들이 읽을 때 위로가 될 수 있도록 따뜻하게 마무리하세요.',
            style: TextStyle(height: 1.5, color: AppPalette.ink),
          ),
        ],
      ),
    );
  }
}

class _LetterFormSection extends StatelessWidget {
  const _LetterFormSection();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '편지 작성',
      subtitle: '작성자 정보와 편지 내용을 입력합니다.',
      icon: Icons.edit_note_outlined,
      accentColor: AppPalette.accentLavender,
      child: Column(
        children: [
          AppTextField(
            controller: TextEditingController(text: '장진영'),
            label: '작성자 이름',
            hint: '예: 장진영',
            prefixIcon: const Icon(Icons.badge_outlined),
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: TextEditingController(text: '장남'),
            label: '관계',
            hint: '예: 장남, 친구, 이웃',
            prefixIcon: const Icon(Icons.diversity_3_outlined),
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: TextEditingController(
              text:
                  '어머니, 그리움이 깊어지는 요즘입니다. 함께했던 봄 소풍을 떠올리며 감사한 마음을 전합니다. 가족 모두 늘 건강하게 지내고 있어요.',
            ),
            label: '편지 내용',
            hint: '전하고 싶은 마음을 적어주세요.',
            maxLines: 6,
            prefixIcon: const Icon(Icons.chat_bubble_outline),
          ),
          const SizedBox(height: 14),
          const AppHelperText(
            icon: Icons.info_outline,
            text: '편지는 관리자 확인 후 공개됩니다. 욕설이나 비방이 포함되면 게시되지 않을 수 있습니다.',
          ),
        ],
      ),
    );
  }
}

class _GuidelineSection extends StatelessWidget {
  const _GuidelineSection();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '편지 공개 설정',
      subtitle: '편지를 누구와 공유할지 선택하세요.',
      icon: Icons.lock_open_outlined,
      accentColor: AppPalette.accentMint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.public, color: AppPalette.accentMint),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '공개 편지로 등록하면 추모관 방문자가 모두 읽을 수 있습니다.',
                  style: TextStyle(height: 1.5, color: AppPalette.ink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.family_restroom, color: AppPalette.accentMint),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '가족에게만 공개할 수도 있습니다. 추후 설정에서 변경 가능합니다.',
                  style: TextStyle(height: 1.5, color: AppPalette.ink),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewSection extends StatelessWidget {
  const _PreviewSection();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '미리보기',
      subtitle: '편지가 방문자에게 이렇게 보여집니다.',
      icon: Icons.visibility_outlined,
      accentColor: AppPalette.warmBrown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: AppPalette.accentPink),
              const SizedBox(width: 10),
              Text(
                '장진영 · 장남',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppPalette.warmBrown,
                    ),
              ),
              const Spacer(),
              Text(
                '3시간 전',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppPalette.caption,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '어머니, 따뜻했던 봄소풍의 기억이 그리워 편지를 남깁니다. 항상 손을 잡아주시던 그 힘이 저희 가족에게 큰 위로가 되었어요.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: AppPalette.ink,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  label: '임시 저장',
                  leadingIcon: Icons.save_outlined,
                  onPressed: () {},
                  color: AppPalette.warmBrown,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppPrimaryButton(
                  label: '편지 등록하기',
                  icon: Icons.check_circle_outline,
                  onPressed: () {},
                  accentColor: AppPalette.warmBrown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
