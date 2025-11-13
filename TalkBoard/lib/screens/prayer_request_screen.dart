import 'package:flutter/material.dart';
import 'package:free_board/board/board_themes.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/board/board_section_card.dart';
import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/screens/prayer_request_detail_screen.dart';

class PrayerRequestScreen extends StatefulWidget {
  const PrayerRequestScreen({super.key});

  @override
  State<PrayerRequestScreen> createState() => _PrayerRequestScreenState();
}

class _PrayerRequestScreenState extends State<PrayerRequestScreen> {
  final TextEditingController _searchController = TextEditingController();

  static final List<_PrayerRequest> _requests = [
    const _PrayerRequest(
      id: 'prayer-001',
      title: '어머니의 항암 치료를 위해',
      requester: '김하늘',
      relation: '장녀',
      category: '가족',
      submittedAgoLabel: '2시간 전',
      excerpt:
          '이번 주 월요일부터 항암 치료 3차에 들어갑니다. 부작용 없이 잘 견딜 수 있도록 함께 기도해 주세요.',
      prayerCount: 42,
      commentCount: 12,
      supportCount: 18,
      isAnswered: false,
      accentColor: AppPalette.accentPink,
      donationAmount: 185000,
      donorCount: 11,
      allowsDonation: true,
    ),
    const _PrayerRequest(
      id: 'prayer-002',
      title: '아버지의 심장 수술 회복',
      requester: '박지후',
      relation: '막내아들',
      category: '건강',
      submittedAgoLabel: '어제',
      excerpt:
          '심장 스텐트 수술을 마치고 회복 중입니다. 산소포화도와 혈압이 안정될 수 있도록 중보 부탁드립니다.',
      prayerCount: 58,
      commentCount: 21,
      supportCount: 33,
      isAnswered: false,
      accentColor: AppPalette.accentMint,
      donationAmount: 296000,
      donorCount: 24,
      allowsDonation: true,
    ),
    const _PrayerRequest(
      id: 'prayer-003',
      title: '형제의 진로 고민',
      requester: '정수빈',
      relation: '동생',
      category: '진로',
      submittedAgoLabel: '3일 전',
      excerpt:
          '대학 졸업 후 새로운 길을 찾는 중입니다. 하나님께서 원하시는 진로를 discern 하도록 함께 기도해주세요.',
      prayerCount: 17,
      commentCount: 6,
      supportCount: 14,
      isAnswered: false,
      accentColor: AppPalette.accentLavender,
      donationAmount: 98000,
      donorCount: 9,
      allowsDonation: false,
    ),
    const _PrayerRequest(
      id: 'prayer-004',
      title: '장례 절차를 준비하며',
      requester: '이지은',
      relation: '배우자',
      category: '위로',
      submittedAgoLabel: '1주 전',
      excerpt:
          '배우자의 장례를 준비하며 가족 모두가 평안 가운데 지낼 수 있도록 기도를 부탁드립니다.',
      prayerCount: 64,
      commentCount: 28,
      supportCount: 45,
      isAnswered: true,
      accentColor: AppPalette.accentGold,
      donationAmount: 412000,
      donorCount: 31,
      allowsDonation: false,
    ),
  ];

  String _selectedCategory = '전체';
  bool _hideAnswered = false;

  List<String> get _categories => [
        '전체',
        ...{
          for (final request in _requests) request.category,
        }
      ];

  List<_PrayerRequest> get _filteredRequests {
    final query = _searchController.text.trim().toLowerCase();
    return _requests.where((request) {
      final matchesQuery = query.isEmpty ||
          request.title.toLowerCase().contains(query) ||
          request.excerpt.toLowerCase().contains(query) ||
          request.requester.toLowerCase().contains(query);
      final matchesCategory =
          _selectedCategory == '전체' || request.category == _selectedCategory;
      final matchesAnswered = !_hideAnswered || !request.isAnswered;
      return matchesQuery && matchesCategory && matchesAnswered;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardTheme = BoardThemes.prayer;
    final filterConfig = boardTheme.filterSection;
    final statsConfig = boardTheme.statsConfig;
    final filtered = _filteredRequests;
    return Scaffold(
      backgroundColor: boardTheme.backgroundColor,
      appBar: AppBar(
        title: Text('${boardTheme.displayName} 목록'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth;
                    final isCompact = maxWidth < 560;
                    final stats = _PrayerSummaryStat.generate(
                      _requests,
                      statsConfig,
                    );
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: stats
                          .map(
                            (stat) => SizedBox(
                              width: isCompact ? maxWidth : (maxWidth - 24) / 3,
                              child: _PrayerSummaryTile(stat: stat),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 12),
                BoardHelperMessages(
                  messages: boardTheme.introSection.helperMessages,
                ),
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
                            onSelected: (value) {
                              if (!value) return;
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
                    title: const Text('응답 완료된 기도는 숨기기'),
                    value: _hideAnswered,
                    onChanged: (value) {
                      setState(() {
                        _hideAnswered = value;
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
            for (final request in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _PrayerRequestCard(
                  request: request,
                  theme: boardTheme,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _PrayerRequest {
  const _PrayerRequest({
    required this.id,
    required this.title,
    required this.requester,
    required this.relation,
    required this.category,
    required this.submittedAgoLabel,
    required this.excerpt,
    required this.prayerCount,
    required this.commentCount,
    required this.supportCount,
    required this.isAnswered,
    required this.accentColor,
    this.donationAmount = 0,
    this.donorCount = 0,
    this.allowsDonation = true,
  });

  final String id;
  final String title;
  final String requester;
  final String relation;
  final String category;
  final String submittedAgoLabel;
  final String excerpt;
  final int prayerCount;
  final int commentCount;
  final int supportCount;
  final bool isAnswered;
  final Color accentColor;
  final int donationAmount;
  final int donorCount;
  final bool allowsDonation;
}

class _PrayerRequestCard extends StatelessWidget {
  const _PrayerRequestCard({
    required this.request,
    required this.theme,
  });

  final _PrayerRequest request;
  final BoardThemeData theme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final totalPrayersDefinition = theme.statsConfig?.items.firstWhere(
      (item) => item.id == 'total_prayers',
      orElse: () => const BoardStatDefinition(
        id: 'total_prayers',
        label: '기도 참여',
        icon: Icons.self_improvement_outlined,
        accentColor: AppPalette.accentMint,
      ),
    );
    final totalPrayerLabel = totalPrayersDefinition?.label ?? '기도 참여';
    final totalPrayerColor = totalPrayersDefinition?.accentColor ?? AppPalette.accentMint;
    return AppSurfaceCard(
      title: request.title,
      subtitle:
          '${request.requester} · ${request.relation} · ${request.submittedAgoLabel}',
      icon: Icons.waving_hand_outlined,
      accentColor: request.accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.excerpt,
            style: textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: AppPalette.ink,
            ),
          ),
          if (request.donationAmount > 0) ...[
            const SizedBox(height: 12),
            AppHelperText(
              icon: Icons.volunteer_activism_outlined,
              text:
                  '${_formatCurrency(request.donationAmount)} · ${request.donorCount}명이 동참했습니다.',
            ),
          ],
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PrayerStatChip(
                icon: Icons.self_improvement_outlined,
                label: totalPrayerLabel,
                value: '${request.prayerCount}',
                accentColor: totalPrayerColor,
              ),
              _PrayerStatChip(
                icon: Icons.forum_outlined,
                label: '응원 댓글',
                value: '${request.commentCount}',
                accentColor: AppPalette.accentLavender,
              ),
              _PrayerStatChip(
                icon: Icons.favorite_border,
                label: '공감',
                value: '${request.supportCount}',
                accentColor: AppPalette.accentPink,
              ),
              if (request.isAnswered)
                _PrayerStatChip(
                  icon: Icons.check_circle_outline,
                  label: '응답 완료',
                  value: '함께 감사해요',
                  accentColor: AppPalette.accentGold,
                ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 520;
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppOutlinedButton(
                            label: theme.actions.secondaryCta,
                            leadingIcon: theme.actions.secondaryIcon,
                            onPressed: () =>
                                _showPrayerSnack(context, request.title, theme),
                    ),
                    const SizedBox(height: 12),
                    AppPrimaryButton(
                            label: theme.actions.primaryCta,
                            icon: theme.actions.primaryIcon,
                      onPressed: () => _openPrayerDetail(context, request),
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: AppOutlinedButton(
                      label: theme.actions.secondaryCta,
                      leadingIcon: theme.actions.secondaryIcon,
                      onPressed: () =>
                          _showPrayerSnack(context, request.title, theme),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      label: theme.actions.primaryCta,
                      icon: theme.actions.primaryIcon,
                      onPressed: () => _openPrayerDetail(context, request),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

void _showPrayerSnack(
  BuildContext context,
  String title,
  BoardThemeData theme,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '"$title" ${theme.actions.reactionLabel}을 남겼습니다.',
      ),
    ),
  );
}

void _openPrayerDetail(
  BuildContext context,
  _PrayerRequest request,
) {
  Navigator.pushNamed(
    context,
    PrayerRequestDetailScreen.routeName,
    arguments: PrayerRequestDetailArguments(
      prayerId: request.id,
      title: request.title,
      requester: '${request.requester} 님',
      relation: request.relation,
      category: request.category,
      submittedAtLabel: '최근 업데이트 · ${request.submittedAgoLabel}',
      summary: request.excerpt,
      content:
          '기도 요청에 대한 자세한 내용은 추후 실제 데이터 연동 시 표시됩니다.\n\n'
          '• 요청자: ${request.requester}\n'
          '• 관계: ${request.relation}\n'
          '• 카테고리: ${request.category}\n\n'
          '실제 데이터 연동 시에는 구체적인 상황 설명과 기도 요청 사유를 여기에 표시합니다.',
      journal: request.isAnswered
          ? '응답 소식이 등록된 기도입니다. 자세한 응답 기록은 상세 화면에서 확인해 주세요.'
          : null,
      imageUrls: const [],
      answerNote: request.isAnswered
          ? '함께 기도해 주셔서 감사합니다. 업데이트된 응답 소식은 추후 공유드릴 예정입니다.'
          : null,
      allowsDonation: request.allowsDonation,
      totalDonationAmount: request.donationAmount,
      donorCount: request.donorCount,
    ),
  );
}

class _PrayerStatChip extends StatelessWidget {
  const _PrayerStatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.4), width: 1.2),
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
          Icon(icon, color: accentColor),
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
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
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

class _PrayerSummaryStat {
  const _PrayerSummaryStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  static List<_PrayerSummaryStat> generate(
    List<_PrayerRequest> requests,
    BoardStatsConfig? config,
  ) {
    final todaysRequests =
        requests.where((request) => request.submittedAgoLabel.contains('시간')).length;
    final totalPrayers =
        requests.fold<int>(0, (sum, request) => sum + request.prayerCount);
    final answered = requests.where((request) => request.isAnswered).length;

    BoardStatDefinition resolve(
      String id,
      String fallbackLabel,
      IconData fallbackIcon,
      Color fallbackColor,
    ) {
      final fallback = BoardStatDefinition(
        id: id,
        label: fallbackLabel,
        icon: fallbackIcon,
        accentColor: fallbackColor,
      );
      if (config == null) {
        return fallback;
      }

      return config.items.firstWhere(
        (item) => item.id == id,
        orElse: () => fallback,
      );
    }

    final todayDef = resolve(
      'today_count',
      '오늘 등록',
      Icons.pending_actions_outlined,
      AppPalette.accentPink,
    );
    final totalDef = resolve(
      'total_prayers',
      '누적 기도 참여',
      Icons.self_improvement_outlined,
      AppPalette.accentMint,
    );
    final answeredDef = resolve(
      'answered',
      '응답된 기도',
      Icons.celebration_outlined,
      AppPalette.accentGold,
    );

    return [
      _PrayerSummaryStat(
        icon: todayDef.icon,
        label: todayDef.label,
        value: '$todaysRequests건',
        accentColor: todayDef.accentColor,
      ),
      _PrayerSummaryStat(
        icon: totalDef.icon,
        label: totalDef.label,
        value: '$totalPrayers회',
        accentColor: totalDef.accentColor,
      ),
      _PrayerSummaryStat(
        icon: answeredDef.icon,
        label: answeredDef.label,
        value: '$answered건',
        accentColor: answeredDef.accentColor,
      ),
    ];
  }
}

class _PrayerSummaryTile extends StatelessWidget {
  const _PrayerSummaryTile({required this.stat});

  final _PrayerSummaryStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: stat.accentColor.withOpacity(0.35), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: stat.accentColor.withOpacity(0.16),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: stat.accentColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(stat.icon, color: stat.accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.caption,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  stat.value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppPalette.warmBrown,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
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

