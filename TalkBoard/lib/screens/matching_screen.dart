import 'dart:async';

import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/screens/matching_profile_guide_screen.dart';
import 'package:free_board/screens/matching_profile_editor_screen.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  static const routeName = '/matching';

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  String _selectedTab = _matchingTabs.first.id;
  final TextEditingController _searchController = TextEditingController();
  String _keyword = '';
  Timer? _searchDebounce;
  bool _isSearching = false;
  String? _searchError;

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rawProfiles = _profilesByTab[_selectedTab] ?? const <_MatchingProfile>[];
    final keyword = _keyword.trim().toLowerCase();
    final profiles = keyword.isEmpty
        ? rawProfiles
        : rawProfiles
            .where(
              (profile) =>
                  profile.headline.toLowerCase().contains(keyword) ||
                  profile.subHeadline.toLowerCase().contains(keyword) ||
                  profile.story.toLowerCase().contains(keyword) ||
                  profile.tags.any((tag) => tag.toLowerCase().contains(keyword)),
            )
            .toList();
    final selectedTab = _matchingTabs.firstWhere(
      (tab) => tab.id == _selectedTab,
      orElse: () => _matchingTabs.first,
    );

    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('상호 위로 매칭'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: '서로를 위한 위로의 다리',
            subtitle: '비슷한 상실 경험을 가진 분들과 연결되어 장기적인 위로 관계를 만들어보세요.',
            icon: Icons.handshake_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHelperText(
                  icon: Icons.info_outline,
                  text: '프로필은 관리자 검토 후 노출되며, 초기 대화는 익명 채팅으로 진행됩니다.',
                ),
                const SizedBox(height: 12),
                const AppHelperText(
                  icon: Icons.timer_outlined,
                  text: '응답률과 활동 내역을 기반으로 적합한 상대를 추천해 드려요.',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        label: '프로필 등록 가이드',
                        leadingIcon: Icons.menu_book_outlined,
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          final result = await navigator.pushNamed(
                            MatchingProfileGuideScreen.routeName,
                          );
                          if (!mounted) return;
                          if (result == true) {
                            navigator.pushNamed(MatchingProfileEditorScreen.routeName);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPrimaryButton(
                        label: '내 프로필 작성',
                        icon: Icons.person_add_alt_1_outlined,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            MatchingProfileEditorScreen.routeName,
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
            title: '안전 안내',
            icon: Icons.shield_moon_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHelperText(
                  icon: Icons.lock_outline,
                  text: '연락처·주소 등 개인정보는 매칭 승인 후 서로가 동의할 때만 공유됩니다.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.gpp_good_outlined,
                  text: '신뢰 점수가 낮거나 신고가 누적된 계정과는 자동으로 매칭되지 않습니다.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.report_problem_outlined,
                  text: '부적절한 대화는 즉시 신고해 주세요. 운영팀이 24시간 이내 확인합니다.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '매칭 유형 선택',
            icon: Icons.tune_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: _searchController,
                  label: '프로필 검색',
                  hint: '예: 엄마를 잃은 딸, 반려동물',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _keyword.isEmpty
                      ? null
                      : IconButton(
                          tooltip: '검색어 지우기',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchDebounce?.cancel();
                            _searchController.clear();
                            setState(() {
                              _keyword = '';
                              _searchError = null;
                              _isSearching = false;
                            });
                          },
                        ),
                  onChanged: (value) {
                    _searchDebounce?.cancel();
                    setState(() {
                      _keyword = value;
                      _isSearching = true;
                      _searchError = null;
                    });
                    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
                      if (!mounted) return;
                      setState(() {
                        _isSearching = false;
                      });
                    });
                  },
                ),
                const SizedBox(height: 12),
                if (_isSearching)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _matchingTabs
                      .map(
                        (tab) => ChoiceChip(
                          label: Text(tab.label),
                          selected: _selectedTab == tab.id,
                          onSelected: (selected) {
                            if (!selected) return;
                            setState(() {
                              _selectedTab = tab.id;
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: _selectedTab == tab.id ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: _selectedTab == tab.id ? Colors.black : Colors.black12,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                AppHelperText(
                  icon: Icons.lightbulb_outline,
                  text: selectedTab.helperText,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (_searchError != null)
            AppSurfaceCard(
              title: '검색 오류',
              subtitle: '검색을 처리하는 중 문제가 발생했어요.',
              icon: Icons.error_outline,
              child: AppHelperText(
                icon: Icons.refresh_outlined,
                text: _searchError!,
              ),
            )
          else if (profiles.isEmpty)
            AppSurfaceCard(
              title: '매칭 준비 중',
              subtitle: '이 유형에 맞는 프로필을 생성하고 있습니다. 잠시 후 다시 확인해 주세요.',
              icon: Icons.hourglass_bottom_outlined,
              child: AppHelperText(
                icon: Icons.refresh_outlined,
                text: keyword.isEmpty
                    ? selectedTab.emptyMessage
                    : '“$keyword”에 해당하는 프로필이 없습니다. 검색어를 바꿔보세요.',
              ),
            )
          else
            ...profiles.map((profile) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _MatchingProfileCard(profile: profile),
                )),
        ],
      ),
    );
  }
}

class _MatchingProfileCard extends StatelessWidget {
  const _MatchingProfileCard({required this.profile});

  final _MatchingProfile profile;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: profile.headline,
      subtitle: profile.subHeadline,
      icon: Icons.person_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Text(
            profile.story,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.black.withValues(alpha: 0.78),
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  label: '프로필 상세 보기',
                  leadingIcon: Icons.visibility_outlined,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('“${profile.headline}” 상세 프로필은 준비 중입니다.'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppPrimaryButton(
                  label: profile.ctaLabel,
                  icon: Icons.handshake_outlined,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('“${profile.headline}”에게 매칭 신청을 전송했어요.'),
                      ),
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

class _MatchingTab {
  const _MatchingTab({
    required this.id,
    required this.label,
    required this.helperText,
    required this.emptyMessage,
  });

  final String id;
  final String label;
  final String helperText;
  final String emptyMessage;
}

class _MatchingProfile {
  const _MatchingProfile({
    required this.headline,
    required this.subHeadline,
    required this.story,
    required this.tags,
    required this.ctaLabel,
  });

  final String headline;
  final String subHeadline;
  final String story;
  final List<String> tags;
  final String ctaLabel;
}

const List<_MatchingTab> _matchingTabs = [
  _MatchingTab(
    id: 'seeking_comfort',
    label: '위로 찾는 중',
    helperText: '비슷한 경험을 지닌 분들에게 위로를 받고 싶은 사용자의 프로필이에요.',
    emptyMessage: '새로운 위로 요청이 등록되면 가장 먼저 알려드릴게요.',
  ),
  _MatchingTab(
    id: 'offering_comfort',
    label: '위로 전하고 싶어요',
    helperText: '먼저 손 내밀고 싶은 분들의 프로필입니다. 서로의 경험을 나눠보세요.',
    emptyMessage: '위로를 전하고 싶은 분들의 신청을 준비 중입니다.',
  ),
  _MatchingTab(
    id: 'my_matches',
    label: '내 매칭',
    helperText: '진행 중인 매칭과 대화 상태를 모아볼 수 있어요.',
    emptyMessage: '아직 진행 중인 매칭이 없어요. 새 프로필에 매칭을 신청해 보세요.',
  ),
];

final Map<String, List<_MatchingProfile>> _profilesByTab = {
  'seeking_comfort': const [
    _MatchingProfile(
      headline: '딸을 잃은 엄마 · 30대 후반',
      subHeadline: '“딸의 빈자리를 함께 나눌 수 있는 분을 찾고 있어요.”',
      story:
          '2년 전 딸을 떠나보낸 뒤로 같은 경험을 가진 분들과 함께 마음을 나누고 싶었습니다. 편지를 주고받으며 서로의 하루를 지켜봐 주실 분을 찾습니다.',
      tags: ['딸과의 추억', '주 2회 대화', '편지 교환'],
      ctaLabel: '매칭 신청하기',
    ),
    _MatchingProfile(
      headline: '아버지를 잃은 아들 · 20대 초반',
      subHeadline: '“회사 생활과 상실의 무게를 함께 이겨내고 싶어요.”',
      story:
          '최근 아버지를 떠나보내고 회사 생활을 이어가고 있습니다. 비슷한 경험이 있는 분과 함께 일상 속 마음을 나누고 싶습니다.',
      tags: ['직장인', '익명 채팅 선호', '주말 전화'],
      ctaLabel: '매칭 신청하기',
    ),
  ],
  'offering_comfort': const [
    _MatchingProfile(
      headline: '엄마를 잃은 딸 · 20대 후반',
      subHeadline: '“엄마를 잃은 분들과 서로 기대고 싶습니다.”',
      story:
          '저 역시 엄마의 빈자리를 겪으며 많은 도움을 받았습니다. 이제는 제가 먼저 이야기를 들어드리고 싶어요. 함께 소리 내어 울고 웃을 수 있길 바랍니다.',
      tags: ['공감 대화', '주 1회 영상 통화', '기념일 함께하기'],
      ctaLabel: '위로 건네기',
    ),
    _MatchingProfile(
      headline: '반려동물을 떠나보낸 가족 · 30대',
      subHeadline: '“반려 가족의 빈자리를 이해해줄 친구를 찾습니다.”',
      story:
          '반려견을 떠나보낸 지 6개월이 지났습니다. 반려동물과의 작별을 겪은 분과 정기적으로 추억을 나누고 싶어요.',
      tags: ['반려동물', '추억 사진 공유', '산책 모임'],
      ctaLabel: '위로 건네기',
    ),
  ],
  'my_matches': const [
    _MatchingProfile(
      headline: '엄마를 잃은 딸과 매칭 중',
      subHeadline: '“지난주 첫 만남 이후 편지를 주고받고 있어요.”',
      story:
          '매칭 후 서로의 이야기를 나누며 큰 위로를 받고 있습니다. 다음 주 첫 오프라인 만남을 준비하고 있어요.',
      tags: ['편지 교환 중', '응답률 95%', '기념일 공유'],
      ctaLabel: '대화 이어가기',
    ),
  ],
};


