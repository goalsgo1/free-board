import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class MemorialStatsScreen extends StatefulWidget {
  const MemorialStatsScreen({super.key});

  static const routeName = '/memorial-stats';

  @override
  State<MemorialStatsScreen> createState() => _MemorialStatsScreenState();
}

class _MemorialStatsScreenState extends State<MemorialStatsScreen> {
  static const List<String> _periods = [
    '전체',
    '최근 1개월',
    '최근 3개월',
    '최근 6개월',
  ];

  static const List<_HighlightMetric> _highlightMetrics = [
    _HighlightMetric(
      label: '총 방문',
      value: '1,284명',
      delta: '+12%',
      icon: Icons.groups_outlined,
      color: AppPalette.accentMint,
    ),
    _HighlightMetric(
      label: '편지 등록',
      value: '86통',
      delta: '+18%',
      icon: Icons.edit_note_outlined,
      color: AppPalette.accentLavender,
    ),
    _HighlightMetric(
      label: '사진/영상',
      value: '214건',
      delta: '+9%',
      icon: Icons.photo_library_outlined,
      color: AppPalette.accentPink,
    ),
    _HighlightMetric(
      label: '기도 참여',
      value: '142명',
      delta: '+5%',
      icon: Icons.favorite_outline,
      color: AppPalette.accentGold,
    ),
  ];

  static const List<_EngagementStat> _engagementStats = [
    _EngagementStat(
      title: '댓글 & 위로 메시지',
      value: '192건',
      changeLabel: '지난달 대비 +23%',
      icon: Icons.sms_outlined,
      accent: AppPalette.accentLavender,
    ),
    _EngagementStat(
      title: '공유된 링크',
      value: '48회',
      changeLabel: '가족 공유 31회 · SNS 공유 17회',
      icon: Icons.share_outlined,
      accent: AppPalette.accentMint,
    ),
    _EngagementStat(
      title: '즐겨찾기 등록',
      value: '64명',
      changeLabel: '새로운 가족 초대 12명',
      icon: Icons.bookmark_outline,
      accent: AppPalette.accentGold,
    ),
  ];

  static const List<_DonationStat> _donationStats = [
    _DonationStat(
      label: '이번 달 수령',
      amount: '₩128,000',
      caption: '가족 & 지인 37명이 함께했습니다.',
      icon: Icons.savings_outlined,
      accent: Color(0xFF66BB6A),
    ),
    _DonationStat(
      label: '기부 전달',
      amount: '₩72,000',
      caption: '기억의 정원 재단에 6회 전달 완료',
      icon: Icons.volunteer_activism_outlined,
      accent: Color(0xFF42A5F5),
    ),
  ];

  static const List<String> _insights = [
    '가족 방문이 오전 9시와 오후 9시에 집중됩니다. 알림을 그 시간대에 맞춰 전송해 보세요.',
    '최근 추가된 사진 앨범이 방문과 편지 참여를 18% 증가시켰어요.',
    '공유 링크로 유입된 방문 중 42%가 새로운 가족 구성원입니다.',
  ];

  final List<double> _visitTrend = [72, 98, 120, 110, 148, 170, 164];
  final List<String> _visitLabels = const ['월', '화', '수', '목', '금', '토', '일'];

  int _selectedPeriodIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as MemorialStatsArguments?;
    final memorial = args ?? const MemorialStatsArguments.sample();

    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('추모관 통계'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: memorial.memorialName,
            subtitle: '가족과 친구들의 참여 현황을 한눈에 확인하세요.',
            icon: Icons.auto_graph_outlined,
            accentColor: AppPalette.accentMint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        memorial.heroImageUrl,
                        width: 88,
                        height: 88,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            memorial.relationSummary,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.ink,
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 8),
                          const AppHelperText(
                            icon: Icons.info_outline,
                            text: '통계는 매일 새벽 3시에 자동으로 갱신됩니다.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    _periods.length,
                    (index) => ChoiceChip(
                      label: Text(_periods[index]),
                      selected: _selectedPeriodIndex == index,
                      onSelected: (value) {
                        if (!value) return;
                        setState(() => _selectedPeriodIndex = index);
                      },
                      selectedColor: AppPalette.warmBrown,
                      labelStyle: TextStyle(
                        color: _selectedPeriodIndex == index
                            ? Colors.white
                            : AppPalette.warmBrown,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: _selectedPeriodIndex == index
                            ? AppPalette.warmBrown
                            : AppPalette.warmBeige,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '하이라이트 지표',
            subtitle: '${_periods[_selectedPeriodIndex]} 기준 주요 변화입니다.',
            icon: Icons.stacked_bar_chart_outlined,
            accentColor: AppPalette.accentLavender,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = (constraints.maxWidth - 16) / 2;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: _highlightMetrics
                      .map(
                        (metric) => _HighlightMetricTile(
                          metric: metric,
                          width: itemWidth,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '방문 추이',
            subtitle: '요일별 가족 방문 수와 변화율입니다.',
            icon: Icons.show_chart_outlined,
            accentColor: AppPalette.accentMint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHelperText(
                  icon: Icons.trending_up,
                  text: '금요일과 토요일 저녁 방문이 가장 활발해요.',
                ),
                const SizedBox(height: 16),
                _VisitTrendChart(
                  values: _visitTrend,
                  labels: _visitLabels,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '추모 활동 요약',
            subtitle: '편지, 댓글, 공유 현황을 확인하세요.',
            icon: Icons.diversity_2_outlined,
            accentColor: AppPalette.accentGold,
            child: Column(
              children: _engagementStats
                  .map(
                    (stat) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _EngagementTile(stat: stat),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '추모금 현황',
            subtitle: '모금과 전달 내역을 투명하게 확인합니다.',
            icon: Icons.volunteer_activism_outlined,
            accentColor: AppPalette.accentMint,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double cardWidth = (constraints.maxWidth - 16) / 2;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: _donationStats
                      .map(
                        (stat) => _DonationTile(
                          stat: stat,
                          width: cardWidth,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '추천 인사이트',
            subtitle: '통계 기반으로 제안하는 다음 액션입니다.',
            icon: Icons.tips_and_updates_outlined,
            accentColor: AppPalette.accentLavender,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._insights.map(
                  (message) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: AppPalette.warmBrown,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            message,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.ink,
                                  height: 1.5,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AppOutlinedButton(
                  label: '자세한 리포트 내보내기',
                  leadingIcon: Icons.picture_as_pdf_outlined,
                  onPressed: () {},
                  color: AppPalette.warmBrown,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemorialStatsArguments {
  const MemorialStatsArguments({
    required this.memorialId,
    required this.memorialName,
    required this.relationSummary,
    required this.heroImageUrl,
  });

  const MemorialStatsArguments.sample()
      : memorialId = 'memorial-001',
        memorialName = '박정윤님 추모관',
        relationSummary = '사랑하는 어머니 · 1958.02.03 ~ 2022.11.18',
        heroImageUrl = 'https://picsum.photos/seed/memorialStats/820/620';

  final String memorialId;
  final String memorialName;
  final String relationSummary;
  final String heroImageUrl;
}

class _HighlightMetricTile extends StatelessWidget {
  const _HighlightMetricTile({
    required this.metric,
    required this.width,
  });

  final _HighlightMetric metric;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.warmBeige, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(metric.icon, color: metric.color),
          const SizedBox(height: 12),
          Text(
            metric.value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppPalette.warmBrown,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            metric.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.caption,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            metric.delta,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: metric.delta.startsWith('+')
                      ? AppPalette.accentMint
                      : AppPalette.accentPink,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _VisitTrendChart extends StatelessWidget {
  const _VisitTrendChart({
    required this.values,
    required this.labels,
  });

  final List<double> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty || labels.isEmpty) {
      return const SizedBox.shrink();
    }
    final double maxValue = values.reduce(math.max);
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 360;
        final double barSpacing = isCompact ? 4 : 10;
        final double labelFontSize = isCompact ? 10 : 12;
        final double chartHeight = isCompact ? 150 : 180;
        final double barMaxHeight = chartHeight - 48;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppPalette.warmBeige, width: 1.2),
          ),
          child: SizedBox(
            height: chartHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(values.length, (index) {
                final double value = values[index];
                final double barHeight =
                    maxValue == 0 ? 0 : (value / maxValue) * (barMaxHeight - 24) + 24;
                final label = labels[index % labels.length];

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: barSpacing / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${value.toInt()}명',
                          style: textTheme.labelSmall?.copyWith(
                                color: AppPalette.caption,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: barHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppPalette.accentMint,
                                    AppPalette.accentMint.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          label,
                          style: textTheme.labelMedium?.copyWith(
                                color: AppPalette.warmBrown,
                                fontWeight: FontWeight.w600,
                                fontSize: labelFontSize,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _EngagementTile extends StatelessWidget {
  const _EngagementTile({required this.stat});

  final _EngagementStat stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: stat.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(stat.icon, color: stat.accent),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppPalette.warmBrown,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                stat.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppPalette.ink,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                stat.changeLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppPalette.caption,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DonationTile extends StatelessWidget {
  const _DonationTile({
    required this.stat,
    required this.width,
  });

  final _DonationStat stat;
  final double width;

  @override
  Widget build(BuildContext context) {
    final bool isCompact = width < 160;
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPalette.warmBeige, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: stat.accent.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(stat.icon, color: stat.accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  stat.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppPalette.warmBrown,
                        fontWeight: FontWeight.w700,
                      ),
                  softWrap: true,
                  maxLines: isCompact ? 2 : 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            stat.amount,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppPalette.warmBrown,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            stat.caption,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.caption,
                  height: 1.5,
                ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class _HighlightMetric {
  const _HighlightMetric({
    required this.label,
    required this.value,
    required this.delta,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String delta;
  final IconData icon;
  final Color color;
}

class _EngagementStat {
  const _EngagementStat({
    required this.title,
    required this.value,
    required this.changeLabel,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String value;
  final String changeLabel;
  final IconData icon;
  final Color accent;
}

class _DonationStat {
  const _DonationStat({
    required this.label,
    required this.amount,
    required this.caption,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String amount;
  final String caption;
  final IconData icon;
  final Color accent;
}


