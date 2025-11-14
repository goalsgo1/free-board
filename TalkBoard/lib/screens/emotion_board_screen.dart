import 'package:flutter/material.dart';
import 'package:free_board/board/board_themes.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/board/board_section_card.dart';
import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class EmotionBoardScreen extends StatefulWidget {
  const EmotionBoardScreen({super.key});

  static const routeName = '/emotion-board';

  @override
  State<EmotionBoardScreen> createState() => _EmotionBoardScreenState();
}

class _EmotionBoardScreenState extends State<EmotionBoardScreen> {
  final TextEditingController _searchController = TextEditingController();

  static final List<_EmotionPost> _posts = [
    const _EmotionPost(
      id: 'emotion-001',
      author: '김하늘',
      relation: '장녀',
      mood: '그리움',
      submittedAgoLabel: '2시간 전',
      excerpt:
          '오늘 어머니가 즐겨 듣던 노래를 들었어요. 여전히 그리움이 밀려오지만, 그 순간의 온기를 잊지 않으려고 해요.',
      likeCount: 128,
      commentCount: 34,
      supportCount: 22,
      tags: ['#그리움', '#가족', '#음악'],
      accentColor: AppPalette.accentLavender,
    ),
    const _EmotionPost(
      id: 'emotion-002',
      author: '이도윤',
      relation: '남편',
      mood: '위로',
      submittedAgoLabel: '어제',
      excerpt:
          '사랑하는 사람을 떠나보낸 뒤 처음으로 외출을 했어요. 오늘 나눈 작은 대화가 큰 위로가 되었습니다.',
      likeCount: 94,
      commentCount: 18,
      supportCount: 15,
      tags: ['#위로', '#새로운시작'],
      accentColor: AppPalette.accentMint,
    ),
    const _EmotionPost(
      id: 'emotion-003',
      author: '정소연',
      relation: '친구',
      mood: '감사',
      submittedAgoLabel: '3일 전',
      excerpt:
          '병상에서 함께 웃어준 친구에게 감사한 마음을 남깁니다. 힘든 시간을 견딜 수 있었던 건 함께한 추억 덕분이에요.',
      likeCount: 75,
      commentCount: 12,
      supportCount: 8,
      tags: ['#감사', '#친구'],
      accentColor: AppPalette.accentGold,
    ),
    const _EmotionPost(
      id: 'emotion-004',
      author: '박지훈',
      relation: '아버지',
      mood: '기쁨',
      submittedAgoLabel: '1주 전',
      excerpt:
          '아들의 웃음을 다시 볼 수 있었어요. 매일 기도해준 분들 덕분입니다. 함께 나누고 싶어 글을 남겨요.',
      likeCount: 163,
      commentCount: 41,
      supportCount: 29,
      tags: ['#기쁨', '#회복'],
      accentColor: AppPalette.accentPink,
    ),
  ];

  String _selectedMood = '전체';

  List<_EmotionPost> get _filteredPosts {
    final query = _searchController.text.trim().toLowerCase();
    return _posts.where((post) {
      final matchesQuery = query.isEmpty ||
          post.excerpt.toLowerCase().contains(query) ||
          post.author.toLowerCase().contains(query) ||
          post.tags.any((tag) => tag.toLowerCase().contains(query));
      final matchesMood =
          _selectedMood == '전체' || post.mood == _selectedMood;
      return matchesQuery && matchesMood;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardTheme = BoardThemes.emotion;
    final filterConfig = boardTheme.filterSection;
    final filtered = _filteredPosts;
    return Scaffold(
      backgroundColor: boardTheme.backgroundColor,
      appBar: AppBar(
        title: Text('${boardTheme.displayName} 게시판'),
        backgroundColor: boardTheme.appBarColor,
        foregroundColor: boardTheme.appBarForegroundColor,
        actions: const [AccessibilityButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.black, width: 1.4),
          ),
        icon: Icon(boardTheme.createAction.icon),
        label: Text(boardTheme.createAction.label),
        onPressed: () {
          Navigator.pushNamed(
            context,
            boardTheme.createAction.routeName,
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          BoardSectionCard.fromIntro(
            intro: boardTheme.introSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoardHelperMessages(messages: boardTheme.introSection.helperMessages),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (filterConfig != null)
            BoardSectionCard(
              title: filterConfig.title,
              subtitle: filterConfig.subtitle,
              icon: filterConfig.icon,
              accentColor: filterConfig.accentColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filterConfig.filterLabels.map((mood) {
                      final isSelected = _selectedMood == mood;
                      return ChoiceChip(
                        label: Text(mood),
                        selected: isSelected,
                        onSelected: (value) {
                          if (!value) return;
                          setState(() {
                            _selectedMood = mood;
                          });
                        },
                        selectedColor: AppPalette.warmBrown,
                        labelStyle: TextStyle(
                          color:
                              isSelected ? Colors.white : AppPalette.warmBrown,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: isSelected
                              ? AppPalette.warmBrown
                              : AppPalette.warmBeige,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _searchController,
                    label: filterConfig.searchLabel,
                    hint: filterConfig.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          if (boardTheme.tagSection != null)
            BoardSectionCard.fromTagSection(
              tagSection: boardTheme.tagSection!,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: boardTheme.tagSection!.tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor:
                            AppPalette.accentLavender.withOpacity(0.18),
                        labelStyle: const TextStyle(
                          color: AppPalette.warmBrown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          const SizedBox(height: 24),
          if (filtered.isEmpty)
            BoardSectionCard(
              title: boardTheme.emptyState.title,
              subtitle: boardTheme.emptyState.subtitle,
              icon: boardTheme.emptyState.icon,
              accentColor: boardTheme.emptyState.accentColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoardHelperMessages(messages: boardTheme.emptyState.helperMessages),
                ],
              ),
            )
          else ...[
            for (final post in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _EmotionPostCard(
                  post: post,
                  theme: boardTheme,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _EmotionPost {
  const _EmotionPost({
    required this.id,
    required this.author,
    required this.relation,
    required this.mood,
    required this.submittedAgoLabel,
    required this.excerpt,
    required this.likeCount,
    required this.commentCount,
    required this.supportCount,
    required this.tags,
    required this.accentColor,
  });

  final String id;
  final String author;
  final String relation;
  final String mood;
  final String submittedAgoLabel;
  final String excerpt;
  final int likeCount;
  final int commentCount;
  final int supportCount;
  final List<String> tags;
  final Color accentColor;
}

class _EmotionPostCard extends StatelessWidget {
  const _EmotionPostCard({
    required this.post,
    required this.theme,
  });

  final _EmotionPost post;
  final BoardThemeData theme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppSurfaceCard(
      title: post.mood,
      subtitle: '${post.author} · ${post.relation} · ${post.submittedAgoLabel}',
      icon: Icons.favorite_border,
      accentColor: post.accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.excerpt,
            style: textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: AppPalette.ink,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: post.tags
                .map(
                  (tag) => Chip(
                    label: Text(tag),
                    backgroundColor: post.accentColor.withOpacity(0.15),
                    labelStyle: const TextStyle(
                      color: AppPalette.warmBrown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _EmotionStat(
                icon: Icons.favorite,
                label: '공감',
                value: post.likeCount,
                color: AppPalette.accentPink,
              ),
              const SizedBox(width: 18),
              _EmotionStat(
                icon: Icons.chat_bubble_outline,
                label: '댓글',
                value: post.commentCount,
                color: AppPalette.accentLavender,
              ),
              const SizedBox(width: 18),
              _EmotionStat(
                icon: Icons.self_improvement_outlined,
                label: '응원',
                value: post.supportCount,
                color: AppPalette.accentMint,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  label: theme.actions.secondaryCta,
                  leadingIcon: theme.actions.secondaryIcon,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '"${post.mood}" 글에 ${theme.actions.reactionLabel}을 남겼습니다.',
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppPrimaryButton(
                  label: '${theme.actions.primaryCta} (준비 중)',
                  icon: theme.actions.primaryIcon,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('댓글 목록은 준비 중입니다.')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmotionStat extends StatelessWidget {
  const _EmotionStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          '$value $label',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppPalette.warmBrown,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

