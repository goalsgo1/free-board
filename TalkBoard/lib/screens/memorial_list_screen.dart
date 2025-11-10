import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/memorial_detail_screen.dart';

class MemorialListScreen extends StatefulWidget {
  const MemorialListScreen({super.key});

  static const routeName = '/memorial-list';

  @override
  State<MemorialListScreen> createState() => _MemorialListScreenState();
}

class _MemorialListScreenState extends State<MemorialListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<_MemorialListItem> _items = const [
    _MemorialListItem(
      memorialId: 'memorial-001',
      name: '박정윤',
      relation: '어머니',
      categories: ['가족', '인간'],
      accentColor: AppPalette.warmBrown,
      updatedAtLabel: '3시간 전 업데이트',
      anniversaryLabel: '기일 · 3월 15일 (오늘)',
      tags: ['사진 42장', '편지 18개', '추억 영상 2개'],
      storyPreview:
          '가족 모두가 모여 생일을 축하하던 모습을 기록했어요. 새로운 사진을 추가했습니다.',
      isPinned: true,
      isFavorite: true,
      heroImageUrl: 'https://picsum.photos/seed/memorialList1/720/420',
    ),
    _MemorialListItem(
      memorialId: 'memorial-002',
      name: '브라우니',
      relation: '반려견',
      categories: ['반려동물', '추억'],
      accentColor: AppPalette.softMint,
      updatedAtLabel: '어제 · 21:10',
      anniversaryLabel: '입양일 · 4월 2일 (D-15)',
      tags: ['사진 18장', '음성 메모 3개'],
      storyPreview:
          '추억 노트에 산책 영상을 추가했어요. 입양 기념일 이벤트를 준비 중입니다.',
      isPinned: false,
      isFavorite: true,
      heroImageUrl: 'https://picsum.photos/seed/memorialList2/720/420',
    ),
    _MemorialListItem(
      memorialId: 'memorial-003',
      name: '김태영',
      relation: '대학교 친구',
      categories: ['친구', '인간'],
      accentColor: AppPalette.softLavender,
      updatedAtLabel: '3일 전',
      anniversaryLabel: '생일 · 5월 6일 (D-49)',
      tags: ['편지 5개', '방명록 12개'],
      storyPreview:
          '동아리 친구들의 새 편지를 추가했어요. 방명록 정리를 진행 중입니다.',
      isPinned: false,
      isFavorite: false,
      heroImageUrl: 'https://picsum.photos/seed/memorialList3/720/420',
    ),
    _MemorialListItem(
      memorialId: 'memorial-004',
      name: '정다운',
      relation: '고등학교 친구',
      categories: ['친구', '인간'],
      accentColor: AppPalette.deepBlue,
      updatedAtLabel: '1주일 전',
      anniversaryLabel: '기일 · 8월 24일',
      tags: ['사진 9장', '음성 편지 1개'],
      storyPreview:
          '추억 책갈피에 여행 사진을 업로드했습니다. 추억 모음집을 준비해보세요.',
      isPinned: false,
      isFavorite: false,
      heroImageUrl: 'https://picsum.photos/seed/memorialList4/720/420',
    ),
  ];

  late final List<String> _filters;
  String _selectedFilter = '전체';
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    final categories = <String>{};
    for (final item in _items) {
      categories.addAll(item.categories);
    }
    _filters = ['전체', ...categories];
    _searchController.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleSearchChanged)
      ..dispose();
    super.dispose();
  }

  List<_MemorialListItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _items.where((item) {
      final matchesFilter =
          _selectedFilter == '전체' || item.categories.contains(_selectedFilter);
      final matchesFavorite = !_showFavoritesOnly || item.isFavorite;
      final matchesQuery = query.isEmpty || item.searchText.contains(query);
      return matchesFilter && matchesFavorite && matchesQuery;
    }).toList();

    filtered.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1;
      }
      if (a.isFavorite != b.isFavorite) {
        return a.isFavorite ? -1 : 1;
      }
      return a.name.compareTo(b.name);
    });

    return filtered;
  }

  void _handleSearchChanged() {
    setState(() {});
  }

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppPalette.warmBrown,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('추모관 목록'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: [
          const AccessibilityButton(),
          IconButton(
            tooltip: _showFavoritesOnly ? '전체 추모관 보기' : '즐겨찾기만 보기',
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showComingSoon(context, '추모관 생성은 추후 구현 예정입니다.'),
        icon: const Icon(Icons.add),
        label: const Text('새 추모관 만들기'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '내 추모관 현황',
              subtitle: '필터와 검색을 활용해 추억을 빠르게 찾아보세요.',
              icon: Icons.auto_awesome,
              accentColor: AppPalette.warmBrown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatTile(
                          label: '전체',
                          value: '${_items.length}숲',
                          icon: Icons.inbox,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatTile(
                          label: '즐겨찾기',
                          value:
                              '${_items.where((item) => item.isFavorite).length}숲',
                          icon: Icons.favorite,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatTile(
                          label: '고정됨',
                          value:
                              '${_items.where((item) => item.isPinned).length}숲',
                          icon: Icons.push_pin,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Divider(
                    color: AppPalette.warmBrown.withOpacity(0.2),
                    height: 1,
                    thickness: 1,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '다가오는 기념일',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppPalette.warmBrown,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ..._items.take(2).map(
                    (item) {
                      final accent =
                          AppPalette.accessibleAccent(item.accentColor);
                      return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: accent,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: accent,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.anniversaryLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppPalette.caption,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _searchController,
              label: '추모관 검색',
              hint: '추모관 이름이나 추억 키워드를 입력하세요',
              prefixIcon: const Icon(Icons.search),
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            _FilterChips(
              filters: _filters,
              selected: _selectedFilter,
              onSelected: (value) {
                setState(() {
                  _selectedFilter = value;
                });
              },
            ),
            const AppHelperText(
              text: '즐겨찾기 버튼을 눌러 자주 찾는 추모관을 한 번에 모아볼 수 있어요.',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 24),
            if (filteredItems.isEmpty)
              _EmptyState(
                searchText: _searchController.text,
                onClearFilter: () {
                  setState(() {
                    _selectedFilter = '전체';
                    _showFavoritesOnly = false;
                    _searchController.clear();
                  });
                },
              )
            else
              ...filteredItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: _MemorialListCard(
                    item: item,
                    onOpen: () => Navigator.pushNamed(
                      context,
                      '/memorial-detail',
                      arguments: MemorialDetailArguments(
                        memorialId: item.memorialId,
                        name: item.name,
                        relationSummary:
                            '${item.relation} · ${item.updatedAtLabel}',
                        relation: item.relation,
                        heroImageUrl: item.heroImageUrl,
                        story: item.storyPreview,
                        anniversaryLabel: item.anniversaryLabel,
                      ),
                    ),
                    onShare: () => _showComingSoon(
                      context,
                      '공유 기능은 곧 추가될 예정입니다.',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters
            .map(
              (filter) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: selected == filter,
                  onSelected: (_) => onSelected(filter),
                  labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: selected == filter ? Colors.white : AppPalette.ink,
                      ),
                  selectedColor: AppPalette.warmBrown,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: selected == filter
                        ? AppPalette.warmBrown
                        : AppPalette.warmBeige,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MemorialListCard extends StatelessWidget {
  const _MemorialListCard({
    required this.item,
    required this.onOpen,
    required this.onShare,
  });

  final _MemorialListItem item;
  final VoidCallback onOpen;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final accent = AppPalette.accessibleAccent(item.accentColor);
    return AppSurfaceCard(
      title: item.name,
      subtitle: '${item.relation} · ${item.updatedAtLabel}',
      icon: item.isPinned ? Icons.push_pin : Icons.auto_awesome_outlined,
      accentColor: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: item.tags
                .map(
                  (tag) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tag,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: accent,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Text(
            item.storyPreview,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: AppPalette.ink,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            item.anniversaryLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.caption,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 18),
          AppPrimaryButton(
            label: '추모관 들어가기',
            icon: Icons.open_in_new,
            onPressed: onOpen,
            accentColor: accent,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: AppOutlinedButton(
              label: '공유하기 (준비 중)',
              leadingIcon: Icons.share,
              onPressed: onShare,
              color: accent,
            ),
          ),
          if (item.isFavorite)
            const AppHelperText(
              text: '즐겨찾기한 추모관입니다. 홈 화면 위젯에서도 빠르게 접근할 수 있어요.',
              icon: Icons.favorite,
            ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppPalette.warmBeige, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppPalette.warmBrown, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppPalette.ink,
                ),
          ),
          const SizedBox(height: 4),
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.searchText,
    required this.onClearFilter,
  });

  final String searchText;
  final VoidCallback onClearFilter;

  @override
  Widget build(BuildContext context) {
    final query = searchText.trim();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.warmBeige, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.search_off, color: AppPalette.warmBrown),
              const SizedBox(width: 12),
              Text(
                '조건에 맞는 추모관이 없어요',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppPalette.warmBrown,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            query.isEmpty
                ? '필터 조건을 조정하거나 새 추모관을 만들어보세요.'
                : '“$query”에 해당하는 추모관이 없습니다. 철자를 다시 확인하거나 다른 검색어를 사용해보세요.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: AppPalette.caption,
                ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: AppOutlinedButton(
              label: '필터 초기화',
              leadingIcon: Icons.refresh,
              onPressed: onClearFilter,
            ),
          ),
        ],
      ),
    );
  }
}

class _MemorialListItem {
  const _MemorialListItem({
    required this.memorialId,
    required this.name,
    required this.relation,
    required this.categories,
    required this.accentColor,
    required this.updatedAtLabel,
    required this.anniversaryLabel,
    required this.tags,
    required this.storyPreview,
    required this.isPinned,
    required this.isFavorite,
    required this.heroImageUrl,
  });

  final String memorialId;
  final String name;
  final String relation;
  final List<String> categories;
  final Color accentColor;
  final String updatedAtLabel;
  final String anniversaryLabel;
  final List<String> tags;
  final String storyPreview;
  final bool isPinned;
  final bool isFavorite;
  final String heroImageUrl;

  String get searchText =>
      '$name $relation ${categories.join(' ')} $storyPreview'
          .toLowerCase();
}


