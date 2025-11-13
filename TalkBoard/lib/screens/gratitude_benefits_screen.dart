import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class GratitudeBenefitsScreen extends StatefulWidget {
  const GratitudeBenefitsScreen({super.key});

  static const routeName = '/gratitude-benefits';

  @override
  State<GratitudeBenefitsScreen> createState() => _GratitudeBenefitsScreenState();
}

class _GratitudeBenefitsScreenState extends State<GratitudeBenefitsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showActiveOnly = true;

  static const List<_BenefitCampaign> _campaigns = [
    _BenefitCampaign(
      title: '겨울 추모 꽃다발 선물',
      sponsor: '기억의 정원 × Bloom & Letter',
      period: '2025.01.10 ~ 2025.02.28',
      statusLabel: '진행 중',
      description: '가족과 추모 모임을 위한 생화 꽃다발을 추첨으로 제공합니다. 사연을 나눠주세요.',
      tags: ['생화', '사연 공모', '추첨'],
    ),
    _BenefitCampaign(
      title: '추모관 프리미엄 멤버십 1개월권',
      sponsor: '기억의 정원',
      period: '2024.12.01 ~ 2024.12.31',
      statusLabel: '종료',
      description: '추모관 꾸미기 테마, 음악, AI 답장 프리뷰 등 프리미엄 기능을 체험할 수 있어요.',
      tags: ['프리미엄', '체험권'],
    ),
  ];

  static const List<_AppreciationStory> _stories = [
    _AppreciationStory(
      title: '엄마와 마지막으로 나눈 대화 덕분에 힘이 되었어요',
      contributor: '김서윤 · 2일 전 참여',
      message: 'AI 기억 답장을 통해 엄마의 응원을 다시 들을 수 있어서 고맙습니다. 겨울 꽃다발이 오면 가족 모임 때 함께 나눌게요.',
    ),
    _AppreciationStory(
      title: '프리미엄 테마로 추모관을 새롭게 꾸몄어요',
      contributor: '이도현 · 1주 전 참여',
      message: 'PC에서만 가능했던 추모관 커버 기능을 모바일에서도 쓰게 되어 감사했어요. 혜택 덕분에 변화를 줄 수 있었습니다.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('감사 혜택'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '오늘도 기억을 지켜줘서 고마워요',
              subtitle: '감사 혜택은 추모 활동을 응원하고 일상을 회복할 수 있도록 마련한 이벤트입니다.',
              icon: Icons.card_giftcard_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: '혜택 신청 시 등록한 연락처로 안내가 발송되며, 당첨자는 개별 연락드립니다.',
                  ),
                  SizedBox(height: 8),
                  AppHelperText(
                    icon: Icons.verified_user_outlined,
                    text: '사연/응모 내용은 익명 처리 후 커뮤니티에 소개될 수 있습니다.',
                  ),
                  SizedBox(height: 8),
                  AppHelperText(
                    icon: Icons.lightbulb_outline,
                    text: '새로운 혜택은 매월 첫째 주에 업데이트되며, 지난 혜택도 기록으로 남겨 확인할 수 있어요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '혜택 찾기',
              subtitle: '신청하고 싶은 혜택을 검색하거나 조건을 적용해 보세요.',
              icon: Icons.search,
              child: Column(
                children: [
                  AppTextField(
                    controller: _searchController,
                    label: '혜택 검색',
                    hint: '예: 꽃다발, 프리미엄, 추모 모임',
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('진행 중인 혜택만 보기'),
                    value: _showActiveOnly,
                    onChanged: (value) => setState(() => _showActiveOnly = value),
                    activeColor: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: AppOutlinedButton(
                          label: '필터 초기화',
                          leadingIcon: Icons.refresh_outlined,
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _showActiveOnly = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppPrimaryButton(
                          label: '새 혜택 제안하기',
                          icon: Icons.add_comment_outlined,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('새 혜택 제안 기능은 준비 중입니다.')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '진행 중/지난 혜택',
              subtitle: '응모 기간과 참여 조건을 확인하고 신청해 보세요.',
              icon: Icons.event_available_outlined,
              child: Column(
                children: [
                  for (final campaign in _filteredCampaigns) ...[
                    _BenefitCard(campaign: campaign),
                    if (campaign != _filteredCampaigns.last) const SizedBox(height: 16),
                  ],
                  if (_filteredCampaigns.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
                      ),
                      child: const AppHelperText(
                        icon: Icons.hourglass_bottom_outlined,
                        text: '현재 진행 중인 혜택이 없습니다. 곧 새로운 혜택으로 찾아올게요.',
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '감사 이야기',
              subtitle: '혜택을 통해 위로를 받은 분들의 이야기를 읽어보세요.',
              icon: Icons.favorite_border,
              child: Column(
                children: [
                  for (final story in _stories) ...[
                    _AppreciationStoryCard(story: story),
                    if (story != _stories.last) const SizedBox(height: 16),
                  ],
                  const SizedBox(height: 16),
                  AppOutlinedButton(
                    label: '감사 이야기 남기기',
                    leadingIcon: Icons.edit_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('감사 이야기 작성 기능은 준비 중입니다.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: '홈으로 돌아가기',
              icon: Icons.home_outlined,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  List<_BenefitCampaign> get _filteredCampaigns {
    final keyword = _searchController.text.trim().toLowerCase();
    return _campaigns.where((campaign) {
      if (_showActiveOnly && campaign.statusLabel != '진행 중') {
        return false;
      }
      if (keyword.isEmpty) return true;
      final haystack = [
        campaign.title,
        campaign.sponsor,
        campaign.description,
        campaign.tags.join(' '),
      ].join(' ').toLowerCase();
      return haystack.contains(keyword);
    }).toList();
  }
}

class _BenefitCampaign {
  const _BenefitCampaign({
    required this.title,
    required this.sponsor,
    required this.period,
    required this.statusLabel,
    required this.description,
    required this.tags,
  });

  final String title;
  final String sponsor;
  final String period;
  final String statusLabel;
  final String description;
  final List<String> tags;
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.campaign});

  final _BenefitCampaign campaign;

  Color _statusColor(String label) {
    if (label == '진행 중') return const Color.fromRGBO(0, 128, 0, 1);
    return const Color.fromRGBO(0, 0, 0, 0.6);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaign.sponsor,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
                ),
                child: Text(
                  campaign.statusLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _statusColor(campaign.statusLabel),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            campaign.period,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
          ),
          const SizedBox(height: 12),
          Text(
            campaign.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: campaign.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1),
                    ),
                    child: Text(
                      '#$tag',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  label: '상세 안내 보기',
                  leadingIcon: Icons.open_in_new,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"${campaign.title}" 상세 안내는 준비 중입니다.')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppPrimaryButton(
                  label: '혜택 신청하기',
                  icon: Icons.send_outlined,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('혜택 신청 기능은 준비 중입니다.')),
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

class _AppreciationStory {
  const _AppreciationStory({
    required this.title,
    required this.contributor,
    required this.message,
  });

  final String title;
  final String contributor;
  final String message;
}

class _AppreciationStoryCard extends StatelessWidget {
  const _AppreciationStoryCard({required this.story});

  final _AppreciationStory story;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            story.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            story.contributor,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
          ),
          const SizedBox(height: 12),
          Text(
            story.message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
