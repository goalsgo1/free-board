import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:free_board/models/memorial.dart';
import 'package:free_board/providers/memorial_provider.dart';
import 'package:free_board/screens/memorial_letter_screen.dart';
import 'package:free_board/screens/memorial_stats_screen.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class MemorialDetailScreen extends StatelessWidget {
  const MemorialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as MemorialDetailArguments?;
    final memorialId = args?.memorialId;

    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('추모관 상세'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: memorialId == null
          ? const _ErrorView(message: '유효하지 않은 추모관 정보입니다.')
          : Consumer<MemorialProvider>(
              builder: (context, provider, child) {
                final memorial = provider.findById(memorialId);
                if (memorial == null) {
                  if (provider.memorials.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const _ErrorView(message: '추모관을 찾을 수 없습니다.');
                }
                return _MemorialDetailContent(memorial: memorial);
              },
            ),
    );
  }
}

class _MemorialDetailContent extends StatelessWidget {
  const _MemorialDetailContent({required this.memorial});

  final Memorial memorial;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MemorialHeroSection(memorial: memorial),
          const SizedBox(height: 20),
          _SummaryCard(memorial: memorial),
          const SizedBox(height: 20),
          _ActionRow(memorial: memorial),
          const SizedBox(height: 20),
          _StatsCard(memorial: memorial),
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
    );
  }
}

class _MemorialHeroSection extends StatelessWidget {
  const _MemorialHeroSection({required this.memorial});

  final Memorial memorial;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: Image.network(
            memorial.heroImageUrl ??
                'https://picsum.photos/seed/${Uri.encodeComponent(memorial.id)}/1080/640',
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
                memorial.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                _buildRelationSummary(memorial),
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
  const _SummaryCard({required this.memorial});

  final Memorial memorial;

  @override
  Widget build(BuildContext context) {
    final relation = memorial.relation?.trim();
    final relationLabel =
        relation != null && relation.isNotEmpty ? relation : '관계 정보가 없습니다.';
    final anniversary = memorial.anniversaryLabel?.trim();
    final anniversaryLabel = anniversary != null && anniversary.isNotEmpty
        ? anniversary
        : '기념일 정보가 아직 없습니다.';
    final notes = memorial.notes?.trim();
    final notesLabel = notes != null && notes.isNotEmpty
        ? notes
        : '추모 메모가 아직 작성되지 않았습니다.';
    final accessibilityLabels = [
      memorial.isPublic ? '공개' : '비공개',
      memorial.allowComments ? '편지 허용' : '편지 제한',
      memorial.allowSharing ? '공유 허용' : '공유 제한',
    ].join(' · ');
    final categories = memorial.categories.isNotEmpty
        ? memorial.categories.join(', ')
        : null;
    final tags = memorial.tags.isNotEmpty ? memorial.tags.join(' · ') : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '기억의 요약',
        subtitle: memorial.story?.isNotEmpty == true
            ? memorial.story!
            : '아직 추억 소개가 작성되지 않았습니다.',
        icon: Icons.spa_outlined,
        accentColor: AppPalette.accentMint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(
              icon: Icons.person_outline,
              label: '관계',
              value: relationLabel,
            ),
            const SizedBox(height: 12),
            _SummaryRow(
              icon: Icons.cake_outlined,
              label: '기념일',
              value: anniversaryLabel,
            ),
            const SizedBox(height: 12),
            _SummaryRow(
              icon: Icons.lock_open_outlined,
              label: '공개 설정',
              value: accessibilityLabels,
            ),
            if (categories != null) ...[
              const SizedBox(height: 12),
              _SummaryRow(
                icon: Icons.category_outlined,
                label: '분류',
                value: categories,
              ),
            ],
            if (tags != null) ...[
              const SizedBox(height: 12),
              _SummaryRow(
                icon: Icons.tag_outlined,
                label: '태그',
                value: tags,
              ),
            ],
            const SizedBox(height: 12),
            _SummaryRow(
              icon: Icons.notes_outlined,
              label: '추모 메모',
              value: notesLabel,
            ),
            const SizedBox(height: 16),
            AppHelperText(
              icon: Icons.info_outline,
              text:
                  '마지막 업데이트 ${_formatTimeAgo(memorial.updatedAt)} · 생성 ${_formatDate(memorial.createdAt)}',
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
  const _ActionRow({required this.memorial});

  final Memorial memorial;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
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
                        memorialId: memorial.id,
                        memorialName: memorial.name,
                        defaultAuthor: '작성자',
                        defaultRelation: memorial.relation ?? '가족',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppOutlinedButton(
                  label: '공유하기',
                  leadingIcon: Icons.ios_share,
              badgeText: '준비 중',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppOutlinedButton(
            label: '추모관 통계 보기',
            leadingIcon: Icons.bar_chart_outlined,
            onPressed: () {
              Navigator.pushNamed(
                context,
                MemorialStatsScreen.routeName,
                arguments: MemorialStatsArguments(
                  memorialId: memorial.id,
                  memorialName: memorial.name,
                  relationSummary: _buildRelationSummary(memorial),
                  heroImageUrl: memorial.heroImageUrl ??
                      'https://picsum.photos/seed/${Uri.encodeComponent(memorial.id)}/720/420',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.memorial});

  final Memorial memorial;

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _StatMetric(label: '방문 수', value: memorial.visitCount, suffix: '명'),
      _StatMetric(label: '편지', value: memorial.letterCount, suffix: '통'),
      _StatMetric(label: '사진', value: memorial.photoCount, suffix: '장'),
      _StatMetric(label: '영상', value: memorial.videoCount, suffix: '개'),
      _StatMetric(label: '기도 참여', value: memorial.prayerCount, suffix: '명'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppSurfaceCard(
        title: '추모 현황',
        subtitle: '최근 7일간 가족과 지인들의 참여 기록입니다.',
        icon: Icons.insights_outlined,
        accentColor: AppPalette.accentGold,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: metrics
              .map((metric) => _StatChip(metric: metric))
              .toList(),
        ),
      ),
    );
  }
}

class _StatMetric {
  const _StatMetric({
    required this.label,
    required this.value,
    required this.suffix,
  });

  final String label;
  final int value;
  final String suffix;
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.metric});

  final _StatMetric metric;

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
            _formatCount(metric.value, metric.suffix),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppPalette.warmBrown,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            metric.label,
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
              badgeText: '준비 중',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppPalette.warmBrown),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppPalette.ink,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

String _formatCount(int value, String suffix) {
  return '${_formatNumber(value)}$suffix';
}

String _formatNumber(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    final positionFromEnd = digits.length - i;
    buffer.write(digits[i]);
    if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
      buffer.write(',');
    }
  }
  return buffer.toString();
}

String _buildRelationSummary(Memorial memorial) {
  final relation = memorial.relation?.trim();
  final relationLabel =
      relation != null && relation.isNotEmpty ? relation : '관계 미정';
  final updatedAgo = _formatTimeAgo(memorial.updatedAt);
  return '$relationLabel · $updatedAgo 업데이트';
}

String _formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return '방금';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}분 전';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}시간 전';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}일 전';
  } else {
    return _formatDate(dateTime);
  }
}

String _formatDate(DateTime dateTime) {
  final year = dateTime.year;
  final month = dateTime.month;
  final day = dateTime.day;
  return '$year년 ${month}월 ${day}일';
}

class MemorialDetailArguments {
  const MemorialDetailArguments({required this.memorialId});

  final String memorialId;
}
