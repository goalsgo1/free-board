import 'package:flutter/material.dart';
import 'package:free_board/board/board_themes.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/board/board_section_card.dart';
import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/regret_letter_detail_screen.dart';

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
      fullContent:
          '엄마, 마지막 순간에 더 밝은 얼굴로 당신을 안심시켜 드렸어야 했는데 자꾸 후회가 돼. 그날 이후로 매일 당신이 좋아하던 국화를 선반 위에 올려두고 있어. 꽃향기를 맡으면 우리가 함께 나눴던 소소한 이야기들이 떠오르고, 당신이 웃으면서 “딸아, 괜찮다”고 하던 목소리가 귀에 맴돌아.\n\n지난주에는 당신이 앉아 계시던 창가 자리에 조용히 앉아서 편지를 써봤어. 아직 제대로 읽어드리지 못했지만, 오늘은 이 공간에 마음을 나눠봐. 만약 다시 시간을 돌릴 수 있다면, 더 자주 웃고 당신의 손을 잡아드리고 싶어. 당신이 걱정하지 않도록 더 밝은 모습으로 곁에 있을걸 하는 마음이 계속 남아. 그래도 이제는 이 후회를 오래 붙잡고 있지 않으려 해. 당신이 남겨준 따뜻함으로 오늘을 살아가볼게.\n\n다음 주에는 당신이 좋아하시던 흰색 카네이션을 챙겨갈게. 하늘에서 보고 계시면, 제가 괜찮게 지내고 있다는 걸 알아주면 좋겠어. 사랑하고 또 사랑해.',
      author: '김하늘',
      relation: '장녀',
      memorialName: '김은희님 추모관',
      postedAgoLabel: '3시간 전',
      categories: ['사과', '그리움'],
      likeCount: 128,
      commentCount: 42,
      shareCount: 17,
      promiseNote: '매주 월요일마다 엄마가 좋아하시던 국화를 선반 위에 올려둘게요.',
      accentColor: AppPalette.accentLavender,
    ),
    const _RegretLetter(
      id: 'letter-002',
      title: '끝까지 함께하지 못한 마음',
      excerpt:
          '아버지, 수술 전에 더 많은 이야기를 나눴다면 어땠을까 하는 생각이 매일 들어요. 대신 이제부터는 남은 가족들과 더 많은 시간을 보내려고 합니다.',
      fullContent:
          '아버지, 수술 전에 더 많은 이야기를 나눴다면 어땠을까 하는 생각이 매일 들어요. 병실에서 들려온 기계 소리 속에서도 당신의 목소리가 그렇게 또렷하게 느껴질 줄 몰랐어요. 지금이라도 늦지 않았다면, 당신이 늘 강조하시던 성실함과 따뜻함을 잊지 않겠다고 다짐하고 싶어요.\n\n마지막으로 남겨주신 “가족이 제일 중요하다”는 말, 마음에 깊이 새기고 있어요. 그래서 요즘은 형, 누나들과 더 자주 만나기로 했죠. 우리가 함께 모여 당신 이야기를 나누면 모두가 웃음이 나요. 당신이 우리에게 남겨준 사랑이 이렇게 컸다는 걸 다시 느끼게 됩니다.\n\n언젠가 아버지를 다시 만날 수 있는 날, “아버지 덕분에 잘 지냈다”고 말할 수 있도록 오늘도 최선을 다해볼게요.',
      author: '박지후',
      relation: '막내아들',
      memorialName: '박종현님 추모관',
      postedAgoLabel: '어제',
      categories: ['다짐', '사과'],
      likeCount: 94,
      commentCount: 26,
      shareCount: 12,
      promiseNote: '남은 가족과 매달 첫 주 토요일에 기념 식사를 이어갈게요.',
      accentColor: AppPalette.accentMint,
    ),
    const _RegretLetter(
      id: 'letter-003',
      title: '당신에게 보내는 늦은 감사',
      excerpt:
          '사랑하는 당신, 늘 고마웠다는 말을 자주 하지 못했네요. 지금이라도 이렇게 글로 마음을 전합니다. 당신이 남긴 따뜻함을 잊지 않을게요.',
      fullContent:
          '사랑하는 당신, 늘 고마웠다는 말을 자주 하지 못했네요. 당신이 제게 보여준 배려와 웃음이 어느새 제 삶의 기준이 되어 있다는 걸, 당신이 떠난 뒤에야 깨달았어요. 매일 아침 당신이 내려주던 커피 향이 그리워서, 요즘은 그 레시피를 따라 만들어 보고 있어요. 아직 당신처럼 깊지 않지만, 그 향을 맡으면 당신의 미소가 떠올라서 참 좋아요.\n\n우리가 함께 했던 시간, 그리고 당신이 제게 남겨준 작은 메모 하나하나를 꺼내 읽어보며 오늘도 힘을 얻습니다. “힘들면 잠시 쉬어도 괜찮아”라는 말처럼, 저도 때로는 숨을 고르고 당신을 생각하며 하루를 마무리하고 있어요.\n\n당신이 남긴 따뜻함을 잊지 않고, 다른 사람들에게도 나누며 살게요. 당신이 늘 그랬던 것처럼요. 사랑해요, 언제나.',
      author: '이지은',
      relation: '배우자',
      memorialName: '이도현님 추모관',
      postedAgoLabel: '2일 전',
      categories: ['감사', '사랑'],
      likeCount: 153,
      commentCount: 31,
      shareCount: 24,
      promiseNote: '당신과 함께했던 기념일을 매년 가족들과 조용히 기념할게요.',
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
    final boardTheme = BoardThemes.regretLetter;
    final filterConfig = boardTheme.filterSection;
    final filtered = _filteredLetters;
    return Scaffold(
      backgroundColor: boardTheme.backgroundColor,
      appBar: AppBar(
        title: Text(boardTheme.displayName),
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
        onPressed: () => Navigator.pushNamed(
          context,
          boardTheme.createAction.routeName,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          BoardSectionCard.fromIntro(
            intro: boardTheme.introSection,
            child: BoardHelperMessages(
              messages: boardTheme.introSection.helperMessages,
            ),
          ),
          const SizedBox(height: 24),
          if (filterConfig != null)
            BoardSectionCard(
              title: filterConfig.title,
              subtitle: filterConfig.subtitle,
              icon: filterConfig.icon,
              accentColor: filterConfig.accentColor,
              child: Column(
                children: [
                  AppTextField(
                    controller: _searchController,
                    label: filterConfig.searchLabel,
                    hint: filterConfig.searchHint,
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
            BoardSectionCard(
              title: boardTheme.emptyState.title,
              subtitle: boardTheme.emptyState.subtitle,
              icon: boardTheme.emptyState.icon,
              accentColor: boardTheme.emptyState.accentColor,
              child: BoardHelperMessages(
                messages: boardTheme.emptyState.helperMessages,
              ),
            )
          else ...[
            for (final letter in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _RegretLetterCard(
                  letter: letter,
                  theme: boardTheme,
                ),
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
    required this.fullContent,
    required this.author,
    required this.relation,
    required this.memorialName,
    required this.postedAgoLabel,
    required this.categories,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    this.promiseNote,
    required this.accentColor,
  });

  final String id;
  final String title;
  final String excerpt;
  final String fullContent;
  final String author;
  final String relation;
  final String memorialName;
  final String postedAgoLabel;
  final List<String> categories;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final String? promiseNote;
  final Color accentColor;
}

class _RegretLetterCard extends StatelessWidget {
  const _RegretLetterCard({
    required this.letter,
    required this.theme,
  });

  final _RegretLetter letter;
  final BoardThemeData theme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
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
            style: textTheme.textTheme.bodyMedium?.copyWith(
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
                  label: theme.actions.secondaryCta,
                  leadingIcon: theme.actions.secondaryIcon,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('"${letter.memorialName}"으로 이동 기능은 준비 중입니다.'),
                      ),
                    );
                  },
                ),
                AppPrimaryButton(
                  label: theme.actions.primaryCta,
                  icon: theme.actions.primaryIcon,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RegretLetterDetailScreen.routeName,
                      arguments: RegretLetterDetailArguments(
                        letterId: letter.id,
                        title: letter.title,
                        author: letter.author,
                        relation: letter.relation,
                        postedAgoLabel: letter.postedAgoLabel,
                        memorialName: letter.memorialName,
                        fullContent: letter.fullContent,
                        categories: letter.categories,
                        likeCount: letter.likeCount,
                        commentCount: letter.commentCount,
                        shareCount: letter.shareCount,
                        promiseNote: letter.promiseNote,
                        accentColor: letter.accentColor,
                      ),
                    );
                  },
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

