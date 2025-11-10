import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/memorial_letter_screen.dart';

class MemorialDetailScreen extends StatelessWidget {
  const MemorialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as MemorialDetailArguments?;
    final data = args ?? const MemorialDetailArguments.sample();

    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('추모관 상세'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MemorialHeroSection(data: data),
            const SizedBox(height: 20),
            _SummaryCard(data: data),
            const SizedBox(height: 20),
            _ActionRow(data: data),
            const SizedBox(height: 20),
            const _StatsCard(),
            const SizedBox(height: 20),
            const _TimelineCard(),
            const SizedBox(height: 20),
            const _MemoriesCard(),
            const SizedBox(height: 20),
            const _LettersPreviewCard(),
            const SizedBox(height: 20),
            const _SupportLinksCard(),
          ],
        ),
      ),
    );
  }
}

class _MemorialHeroSection extends StatelessWidget {
  const _MemorialHeroSection({required this.data});

  final MemorialDetailArguments data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: Image.network(
            data.heroImageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.55),
                Colors.black.withOpacity(0.25),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                data.relationSummary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.data});

  final MemorialDetailArguments data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '기억의 요약',
        subtitle: data.story,
        icon: Icons.spa_outlined,
        accentColor: AppPalette.accentMint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(
              icon: Icons.cake_outlined,
              label: '기념일',
              value: data.anniversaryLabel,
            ),
            const SizedBox(height: 12),
            _SummaryRow(
              icon: Icons.location_on_outlined,
              label: '추모 장소',
              value: '기억의 정원 · 가족 추모관 3층',
            ),
            const SizedBox(height: 12),
            _SummaryRow(
              icon: Icons.groups_outlined,
              label: '참여 가족',
              value: '자녀 3명, 손주 2명, 지인 12명',
            ),
            const SizedBox(height: 16),
            const AppHelperText(
              icon: Icons.info_outline,
              text: '가족 인증이 완료되었습니다. 추모관 관리 권한이 부여되었습니다.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppPalette.warmBrown),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppPalette.warmBrown,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: AppPalette.ink,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.data});

  final MemorialDetailArguments data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: AppPrimaryButton(
              label: '추모 편지 남기기',
              icon: Icons.edit_outlined,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/memorial-letter',
                  arguments: MemorialLetterArguments(
                    memorialId: data.memorialId ?? 'memorial-001',
                    memorialName: data.name,
                    defaultAuthor: '작성자',
                    defaultRelation: data.relation,
                  ),
                );
              },
              accentColor: AppPalette.warmBrown,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppOutlinedButton(
              label: '공유하기',
              leadingIcon: Icons.ios_share,
              onPressed: () {},
              color: AppPalette.warmBrown,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '추모 현황',
        subtitle: '지난 7일간 가족과 지인들의 참여 기록입니다.',
        icon: Icons.insights_outlined,
        accentColor: AppPalette.accentGold,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _StatChip(label: '방문 수', value: '128명'),
            _StatChip(label: '편지', value: '24통'),
            _StatChip(label: '사진', value: '36장'),
            _StatChip(label: '영상', value: '3개'),
            _StatChip(label: '기도 참여', value: '42명'),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.warmBeige, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppPalette.warmBrown,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.caption,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '추억 타임라인',
        subtitle: '시간순으로 남겨진 추억과 소식을 모았습니다.',
        icon: Icons.timeline_outlined,
        accentColor: AppPalette.accentLavender,
        child: Column(
          children: const [
            _TimelineEntry(
              date: '2024.03.10',
              title: '봄 소풍 사진을 추가했습니다',
              description: '손주들과 함께했던 봄날 사진 8장을 업로드했어요.',
            ),
            Divider(),
            _TimelineEntry(
              date: '2024.02.27',
              title: '기도 모임이 열렸습니다',
              description: '교회 지인 분들과 온라인 기도를 진행했습니다.',
            ),
            Divider(),
            _TimelineEntry(
              date: '2024.02.14',
              title: '편지 3통이 도착했습니다',
              description: '친구, 손주, 이웃의 마음담은 편지가 도착했어요.',
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.date,
    required this.title,
    required this.description,
  });

  final String date;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppPalette.warmBrown,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppPalette.caption,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppPalette.warmBrown,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: AppPalette.ink,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MemoriesCard extends StatelessWidget {
  const _MemoriesCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '추억 앨범',
        subtitle: '사진과 영상을 한 곳에서 감상할 수 있어요.',
        icon: Icons.photo_library_outlined,
        accentColor: AppPalette.accentPink,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://picsum.photos/seed/memoryAlbum$index/240/160',
                      width: 200,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const AppHelperText(
              icon: Icons.lightbulb_outline,
              text: '사진은 최대 100장까지 업로드할 수 있어요. 추억을 나누고 싶은 분들에게 공유해보세요.',
            ),
          ],
        ),
      ),
    );
  }
}

class _LettersPreviewCard extends StatelessWidget {
  const _LettersPreviewCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '최근 편지',
        subtitle: '소중한 마음이 담긴 편지를 미리 살펴보세요.',
        icon: Icons.mail_outline,
        accentColor: AppPalette.accentLavender,
        child: Column(
          children: const [
            _LetterTile(
              author: '장진영',
              relation: '장남',
              content: '어머니, 보고 싶은 마음이 더 깊어지는 요즘입니다. 함께했던 추억을 떠올리며 감사한 마음을 전해요.',
              timeAgo: '3시간 전',
            ),
            Divider(),
            _LetterTile(
              author: '오현수',
              relation: '이웃',
              content: '늘 따뜻하게 맞아주시던 모습이 그립습니다. 좋은 곳에서 편안하시길 기도드려요.',
              timeAgo: '어제',
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterTile extends StatelessWidget {
  const _LetterTile({
    required this.author,
    required this.relation,
    required this.content,
    required this.timeAgo,
  });

  final String author;
  final String relation;
  final String content;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, color: AppPalette.accentPink.withOpacity(0.8)),
            const SizedBox(width: 10),
            Text(
              '$author · $relation',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppPalette.warmBrown,
                  ),
            ),
            const Spacer(),
            Text(
              timeAgo,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppPalette.caption,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: AppPalette.ink,
              ),
        ),
      ],
    );
  }
}

class _SupportLinksCard extends StatelessWidget {
  const _SupportLinksCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '관리 & 도움말',
        subtitle: '추모관을 더 풍성하게 사용하는 방법을 안내해드려요.',
        icon: Icons.support_agent,
        accentColor: AppPalette.warmBrown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppChecklist(
              items: const [
                '추모관 설정에서 배경 음악과 소개 글을 수정해보세요.',
                '기념일 알림을 설정하면 가족에게 자동으로 메시지가 발송됩니다.',
                '감정 공유 게시판에서 다른 가족들과 추억을 나눠보세요.',
              ],
            ),
            const SizedBox(height: 16),
            AppOutlinedButton(
              label: '추모관 설정으로 이동',
              leadingIcon: Icons.settings,
              onPressed: () {},
              color: AppPalette.warmBrown,
            ),
          ],
        ),
      ),
    );
  }
}

class MemorialDetailArguments {
  const MemorialDetailArguments({
    this.memorialId,
    required this.name,
    required this.relationSummary,
    required this.heroImageUrl,
    required this.story,
    required this.anniversaryLabel,
    this.relation,
  });

  const MemorialDetailArguments.sample()
      : memorialId = 'memorial-001',
        name = '박정윤님 추모관',
        relationSummary = '사랑하는 어머니 · 1958.02.03 ~ 2022.11.18',
        heroImageUrl = 'https://picsum.photos/seed/memorialHero/1080/640',
        story = '박정윤님을 기억하는 핵심 정보를 모았습니다.',
        anniversaryLabel = '매년 3월 15일 · 첫 기일을 맞이합니다.',
        relation = '가족';

  final String? memorialId;
  final String name;
  final String relationSummary;
  final String heroImageUrl;
  final String story;
  final String anniversaryLabel;
  final String? relation;
}
