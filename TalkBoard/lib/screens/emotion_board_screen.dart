import 'package:flutter/material.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/emotion_post_create_screen.dart';

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
    final filtered = _filteredPosts;
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('감정 공유 게시판'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppPalette.accentLavender,
        foregroundColor: AppPalette.warmBrown,
        icon: const Icon(Icons.add_comment_outlined),
        label: const Text('감정 글 작성'),
        onPressed: () {
          Navigator.pushNamed(
            context,
            EmotionPostCreateScreen.routeName,
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: '지금 마음을 나눠요',
            subtitle: '감사, 그리움, 위로, 기쁨 등 다양한 감정을 공유할 수 있어요.',
            icon: Icons.favorite_outline,
            accentColor: AppPalette.accentPink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHelperText(
                  icon: Icons.info_outline,
                  text:
                      '누군가의 이야기가 또 다른 누군가에게 큰 위로가 됩니다. 부드러운 언어와 배려를 담아주세요.',
                ),
                SizedBox(height: 12),
                AppHelperText(
                  icon: Icons.tips_and_updates_outlined,
                  text: '욕설이나 비방, 개인정보가 포함된 글은 비공개 처리될 수 있습니다.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '감정으로 찾아보기',
            subtitle: '공유하고 싶은 감정 키워드를 선택해보세요.',
            icon: Icons.filter_alt_outlined,
            accentColor: AppPalette.accentMint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    '전체',
                    '감사',
                    '그리움',
                    '위로',
                    '기쁨',
                    '슬픔',
                    '응원',
                  ].map((mood) {
                    return ChoiceChip(
                      label: Text(mood),
                      selected: _selectedMood == mood,
                      onSelected: (value) {
                        if (!value) return;
                        setState(() {
                          _selectedMood = mood;
                        });
                      },
                      selectedColor: AppPalette.warmBrown,
                      labelStyle: TextStyle(
                        color: _selectedMood == mood
                            ? Colors.white
                            : AppPalette.warmBrown,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: _selectedMood == mood
                            ? AppPalette.warmBrown
                            : AppPalette.warmBeige,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _searchController,
                  label: '키워드 검색',
                  hint: '예: 위로, 감사, #가족',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '주간 인기 태그',
            subtitle: '많이 공감받은 태그로 글을 찾아보세요.',
            icon: Icons.tag_outlined,
            accentColor: AppPalette.accentGold,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                '#가족',
                '#위로',
                '#감사',
                '#추억',
                '#새로운시작',
                '#기쁨',
                '#회복중',
              ]
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
            AppSurfaceCard(
              title: '검색 결과가 없어요',
              subtitle: '조건을 조정하거나 다른 키워드로 다시 검색해보세요.',
              icon: Icons.sentiment_dissatisfied_outlined,
              accentColor: AppPalette.accentPink,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: '감정을 변경하거나 키워드를 줄이면 더 많은 글을 볼 수 있습니다.',
                  ),
                ],
              ),
            )
          else ...[
            for (final post in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _EmotionPostCard(post: post),
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
  const _EmotionPostCard({required this.post});

  final _EmotionPost post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            style: theme.textTheme.bodyMedium?.copyWith(
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
                  label: '공감 남기기',
                  leadingIcon: Icons.favorite_border,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"${post.mood}" 글에 공감했습니다.')),
                    );
                  },
                  color: post.accentColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppPrimaryButton(
                  label: '댓글 보기',
                  icon: Icons.forum_outlined,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('댓글 목록은 준비 중입니다.')),
                    );
                  },
                  accentColor: post.accentColor,
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

String _formatCurrency(int amount) {
  final digits = amount.toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match.group(1)},',
  );
  return '₩$formatted';
}

