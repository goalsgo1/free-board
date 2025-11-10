import 'package:flutter/material.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/regret_letter_create_screen.dart';

class RegretLetterBoardScreen extends StatefulWidget {
  const RegretLetterBoardScreen({super.key});

  static const routeName = '/regret-letter';

  @override
  State<RegretLetterBoardScreen> createState() =>
      _RegretLetterBoardScreenState();
}

class _RegretLetterBoardScreenState extends State<RegretLetterBoardScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _onlyFavorites = false;
  bool _onlyMyLetters = false;
  String _selectedCategory = '전체';

  static final List<_RegretLetter> _letters = [
    const _RegretLetter(
      id: 'letter-001',
      title: '조금 더 웃어줄걸',
      excerpt:
          '엄마, 마지막 순간에 더 밝은 얼굴로 당신을 안심시켜 드렸어야 했는데 자꾸 후회가 되네요. 그날 이후로 매일 당신이 좋아하던 국화를 선반 위에 올려두고 있어요.',
      author: '김하늘',
      relation: '장녀',
      memorialName: '김은희님 추모관',
      postedAgoLabel: '3시간 전',
      categories: ['사과', '그리움'],
      likeCount: 128,
      commentCount: 42,
      shareCount: 17,
      accentColor: AppPalette.accentLavender,
    ),
    const _RegretLetter(
      id: 'letter-002',
      title: '끝까지 함께하지 못한 마음',
      excerpt:
          '아버지, 수술 전에 더 많은 이야기를 나눴다면 어땠을까 하는 생각이 매일 들어요. 대신 이제부터는 남은 가족들과 더 많은 시간을 보내려고 합니다.',
      author: '박지후',
      relation: '막내아들',
      memorialName: '박종현님 추모관',
      postedAgoLabel: '어제',
      categories: ['다짐', '사과'],
      likeCount: 94,
      commentCount: 26,
      shareCount: 12,
      accentColor: AppPalette.accentMint,
    ),
    const _RegretLetter(
      id: 'letter-003',
      title: '당신에게 보내는 늦은 감사',
      excerpt:
          '사랑하는 당신, 늘 고마웠다는 말을 자주 하지 못했네요. 지금이라도 이렇게 글로 마음을 전합니다. 당신이 남긴 따뜻함을 잊지 않을게요.',
      author: '이지은',
      relation: '배우자',
      memorialName: '이도현님 추모관',
      postedAgoLabel: '2일 전',
      categories: ['감사', '사랑'],
      likeCount: 153,
      commentCount: 31,
      shareCount: 24,
      accentColor: AppPalette.accentPink,
    ),
  ];

  List<String> get _categories => [
        '전체',
        ...{
          for (final letter in _letters) ...letter.categories,
        }
      ];

  List<_RegretLetter> get _filteredLetters {
    final query = _searchController.text.trim().toLowerCase();
    return _letters.where((letter) {
      final matchesQuery = query.isEmpty ||
          letter.title.toLowerCase().contains(query) ||
          letter.excerpt.toLowerCase().contains(query) ||
          letter.memorialName.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == '전체' ||
          letter.categories.contains(_selectedCategory);
      final matchesFavorites = !_onlyFavorites || letter.likeCount > 120;
      final matchesMine = !_onlyMyLetters || letter.author == '김하늘';
      return matchesQuery && matchesCategory && matchesFavorites && matchesMine;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredLetters;
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('후회 없는 편지'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.mail_outline),
        label: const Text('편지 쓰기'),
        onPressed: () {
          Navigator.pushNamed(context, RegretLetterCreateScreen.routeName);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: '전하지 못한 마음을 편지로 남겨요',
            subtitle: '후회 없는 편지는 고인에게 전하지 못했던 말들을 나누는 공간입니다.',
            icon: Icons.markunread_mailbox_outlined,
            accentColor: AppPalette.accentLavender,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHelperText(
                  icon: Icons.info_outline,
                  text: '편지는 관리자 검토 후 공개되며, 민감한 개인정보는 비공개 처리됩니다.',
                ),
                SizedBox(height: 12),
                AppHelperText(
                  icon: Icons.tips_and_updates_outlined,
                  text: '편지를 작성하려면 먼저 추모관을 선택한 뒤 상세 화면에서 편지 작성 버튼을 눌러주세요.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '편지 찾기',
            subtitle: '카테고리와 검색을 활용해 공감하고 싶은 편지를 찾아보세요.',
            icon: Icons.filter_alt_outlined,
            accentColor: AppPalette.accentMint,
            child: Column(
              children: [
                AppTextField(
                  controller: _searchController,
                  label: '편지 검색',
                  hint: '예: 감사, 사과, 추억',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _categories
                      .map(
                        (category) => ChoiceChip(
                          label: Text(category),
                          selected: _selectedCategory == category,
                          onSelected: (selected) {
                            if (!selected) return;
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          selectedColor: AppPalette.warmBrown,
                          labelStyle: TextStyle(
                            color: _selectedCategory == category
                                ? Colors.white
                                : AppPalette.warmBrown,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: _selectedCategory == category
                                ? AppPalette.warmBrown
                                : AppPalette.warmBeige,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('좋아요 많은 편지 먼저 보기'),
                  value: _onlyFavorites,
                  onChanged: (value) {
                    setState(() {
                      _onlyFavorites = value;
                    });
                  },
                  activeColor: AppPalette.warmBrown,
                ),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('내가 쓴 편지만 보기'),
                  value: _onlyMyLetters,
                  onChanged: (value) {
                    setState(() {
                      _onlyMyLetters = value;
                    });
                  },
                  activeColor: AppPalette.warmBrown,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (filtered.isEmpty)
            AppSurfaceCard(
              title: '검색 결과가 없어요',
              subtitle: '다른 키워드나 카테고리로 다시 검색해보세요.',
              icon: Icons.mark_email_unread_outlined,
              accentColor: AppPalette.accentPink,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: '추모관 상세 화면에서 편지를 작성하면 이곳에 공유됩니다.',
                  ),
                ],
              ),
            )
          else ...[
            for (final letter in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _RegretLetterCard(letter: letter),
              ),
          ],
        ],
      ),
    );
  }
}

class _RegretLetter {
  const _RegretLetter({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.relation,
    required this.memorialName,
    required this.postedAgoLabel,
    required this.categories,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.accentColor,
  });

  final String id;
  final String title;
  final String excerpt;
  final String author;
  final String relation;
  final String memorialName;
  final String postedAgoLabel;
  final List<String> categories;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final Color accentColor;
}

class _RegretLetterCard extends StatelessWidget {
  const _RegretLetterCard({required this.letter});

  final _RegretLetter letter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppSurfaceCard(
      title: letter.title,
      subtitle:
          '${letter.author} · ${letter.relation} · ${letter.postedAgoLabel}',
      icon: Icons.mail_outline,
      accentColor: letter.accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            letter.excerpt,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: AppPalette.ink,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _LetterTagChip(
                label: letter.memorialName,
                icon: Icons.park_outlined,
                color: AppPalette.accentGold,
              ),
              for (final category in letter.categories)
                _LetterTagChip(
                  label: '#$category',
                  icon: Icons.sell_outlined,
                  color: letter.accentColor,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _LetterStatChip(
                icon: Icons.favorite_border,
                label: '공감',
                value: '${letter.likeCount}',
              ),
              _LetterStatChip(
                icon: Icons.mode_comment_outlined,
                label: '댓글',
                value: '${letter.commentCount}',
              ),
              _LetterStatChip(
                icon: Icons.ios_share_outlined,
                label: '공유',
                value: '${letter.shareCount}',
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 520;
              final buttons = [
                AppOutlinedButton(
                  label: '추모관 살펴보기',
                  leadingIcon: Icons.travel_explore,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('"${letter.memorialName}"으로 이동 기능은 준비 중입니다.'),
                      ),
                    );
                  },
                  color: letter.accentColor,
                ),
                AppPrimaryButton(
                  label: '편지 자세히 보기',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '"${letter.title}" 편지 상세 화면은 준비 중입니다.',
                        ),
                      ),
                    );
                  },
                  accentColor: letter.accentColor,
                ),
              ];
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final widget in buttons) ...[
                      widget,
                      const SizedBox(height: 12),
                    ],
                  ],
                );
              }
              return Row(
                children: [
                  for (var i = 0; i < buttons.length; i++) ...[
                    Expanded(child: buttons[i]),
                    if (i != buttons.length - 1) const SizedBox(width: 12),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LetterTagChip extends StatelessWidget {
  const _LetterTagChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.warmBrown,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _LetterStatChip extends StatelessWidget {
  const _LetterStatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppPalette.accessibleAccent(AppPalette.accentLavender),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppPalette.accentLavender),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppPalette.warmBrown,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppPalette.caption,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

