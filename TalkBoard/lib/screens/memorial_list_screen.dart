import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:free_board/board/board_themes.dart';
import 'package:free_board/models/memorial.dart';
import 'package:free_board/providers/memorial_provider.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/board/board_section_card.dart';
import 'package:free_board/widgets/board/board_theme.dart';
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
  String _selectedFilter = '전체';
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleSearchChanged)
      ..dispose();
    super.dispose();
  }

  List<_MemorialListItem> _allItems(BuildContext context) {
    final memorials = context.watch<MemorialProvider>().memorials;
    return memorials.map(_MemorialListItem.fromMemorial).toList();
  }

  List<_MemorialListItem> _filteredItems(List<_MemorialListItem> items) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = items.where((item) {
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

  List<String> _buildFilters(List<_MemorialListItem> items) {
    final categories = <String>{};
    for (final item in items) {
      categories.addAll(item.categories);
    }
    final sorted = categories.toList()..sort();
    return ['전체', ...sorted];
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
    final allItems = _allItems(context);
    final filters = _buildFilters(allItems);
    if (!filters.contains(_selectedFilter)) {
      _selectedFilter = '전체';
    }
    final filteredItems = _filteredItems(allItems);
    final totalCount = allItems.length;
    final favoriteCount =
        allItems.where((item) => item.isFavorite).length;
    final pinnedCount = allItems.where((item) => item.isPinned).length;

    final boardTheme = BoardThemes.memorial;
    final filterConfig = boardTheme.filterSection;
    final statsConfig = boardTheme.statsConfig;
    return Scaffold(
      backgroundColor: boardTheme.backgroundColor,
      appBar: AppBar(
        title: Text(boardTheme.displayName),
        backgroundColor: boardTheme.appBarColor,
        foregroundColor: boardTheme.appBarForegroundColor,
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
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, '/memorial-edit');
          if (!mounted) return;
          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('새 추모관이 추가되었습니다.')),
            );
          }
        },
        icon: Icon(boardTheme.createAction.icon, color: Colors.black),
        label: Text(
          boardTheme.createAction.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.black, width: 1.4),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            BoardSectionCard.fromIntro(
              intro: boardTheme.introSection,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatTile(
                          label: '전체',
                          value: '$totalCount숲',
                          icon: Icons.inbox,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatTile(
                          label: '즐겨찾기',
                          value: '$favoriteCount숲',
                          icon: Icons.favorite,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatTile(
                          label: '고정됨',
                          value: '$pinnedCount숲',
                          icon: Icons.push_pin,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (statsConfig?.title != null) ...[
                    Divider(
                      color: AppPalette.warmBrown.withOpacity(0.2),
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      statsConfig!.title!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppPalette.warmBrown,
                          ),
                    ),
                    if (statsConfig.subtitle != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        statsConfig.subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppPalette.caption,
                            ),
                      ),
                    ],
                    const SizedBox(height: 12),
                  ],
                  Text(
                    '다가오는 기념일',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppPalette.warmBrown,
                        ),
                  ),
                  const SizedBox(height: 12),
                  if (allItems.isEmpty)
                    const AppHelperText(
                      text: '아직 등록된 추모관이 없습니다. 새 추모관을 만들어보세요.',
                      icon: Icons.info_outline,
                    )
                  else
                    ...allItems.take(2).map(
                      (item) {
                        const Color accent = AppPalette.warmBrown;
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
            if (filterConfig != null) ...[
              const SizedBox(height: 24),
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
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    _FilterChips(
                      filters: filters,
                      selected: _selectedFilter,
                      onSelected: (value) {
                        setState(() {
                          _selectedFilter = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('즐겨찾기만 보기'),
                      subtitle: const Text('즐겨찾기한 추모관만 목록에 표시합니다.'),
                      value: _showFavoritesOnly,
                      onChanged: (value) {
                        setState(() {
                          _showFavoritesOnly = value;
                        });
                      },
                      activeColor: AppPalette.warmBrown,
                    ),
                    const SizedBox(height: 8),
                    const AppHelperText(
                      text: '즐겨찾기 버튼을 눌러 자주 찾는 추모관을 한 번에 모아볼 수 있어요.',
                      icon: Icons.info_outline,
                    ),
                  ],
                ),
              ),
            ],
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
                theme: boardTheme,
              )
            else
              ...filteredItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: _MemorialListCard(
                    item: item,
                    theme: boardTheme,
                    onOpen: () => Navigator.pushNamed(
                      context,
                      '/memorial-detail',
                      arguments: MemorialDetailArguments(
                        memorialId: item.memorialId,
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
    required this.theme,
  });

  final _MemorialListItem item;
  final VoidCallback onOpen;
  final VoidCallback onShare;
  final BoardThemeData theme;

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
          Align(
            alignment: Alignment.topRight,
            child: Wrap(
              spacing: 8,
              children: [
                _CardIconButton(
                  tooltip: item.isPinned ? '고정 해제' : '고정하기',
                  icon: item.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  isActive: item.isPinned,
                  onPressed: () async {
                    final provider = context.read<MemorialProvider>();
                    final success = await provider.updatePinned(
                      item.memorialId,
                      !item.isPinned,
                    );
                    if (!context.mounted) return;
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            item.isPinned
                                ? '"${item.name}" 고정을 해제했습니다.'
                                : '"${item.name}"을(를) 상단에 고정했습니다.',
                          ),
                        ),
                      );
                    } else {
                      final error = provider.errorMessage ??
                          '고정 상태를 변경하지 못했습니다.';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                  },
                ),
                _CardIconButton(
                  tooltip: item.isFavorite ? '즐겨찾기 해제' : '즐겨찾기',
                  icon: item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  isActive: item.isFavorite,
                  onPressed: () async {
                    final provider = context.read<MemorialProvider>();
                    final success = await provider.updateFavorite(
                      item.memorialId,
                      !item.isFavorite,
                    );
                    if (!context.mounted) return;
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            item.isFavorite
                                ? '"${item.name}" 즐겨찾기를 해제했습니다.'
                                : '"${item.name}"을(를) 즐겨찾기에 추가했습니다.',
                          ),
                        ),
                      );
                    } else {
                      final error = provider.errorMessage ??
                          '즐겨찾기 상태를 변경하지 못했습니다.';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: item.tags
                .map(
                  (tag) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppPalette.warmBrown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tag,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppPalette.warmBrown,
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
            label: theme.actions.primaryCta,
            icon: theme.actions.primaryIcon,
            onPressed: onOpen,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: AppOutlinedButton(
              label: '공유하기 (준비 중)',
              leadingIcon: Icons.share,
              onPressed: onShare,
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
    required this.theme,
  });

  final String searchText;
  final VoidCallback onClearFilter;
  final BoardThemeData theme;

  @override
  Widget build(BuildContext context) {
    final query = searchText.trim();
    final messages = [
      BoardHelperMessage(
        icon: Icons.search_off,
        text: query.isEmpty
            ? '필터 조건을 조정하거나 새 추모관을 만들어보세요.'
            : '“$query”에 해당하는 추모관이 없습니다. 철자를 다시 확인하거나 다른 검색어를 사용해보세요.',
      ),
      ...theme.emptyState.helperMessages,
    ];
    return BoardSectionCard(
      title: theme.emptyState.title,
      subtitle: theme.emptyState.subtitle,
      icon: theme.emptyState.icon,
      accentColor: theme.emptyState.accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoardHelperMessages(messages: messages),
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
    required this.createdAt,
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
  final DateTime createdAt;

  String get searchText =>
      '$name $relation ${categories.join(' ')} $storyPreview'
          .toLowerCase();

  static _MemorialListItem fromMemorial(Memorial memorial) {
    final categories = memorial.categories.isNotEmpty
        ? memorial.categories
        : _fallbackCategories(memorial.relation);
    final tags =
        memorial.tags.isNotEmpty ? memorial.tags : _fallbackTags(memorial);
    return _MemorialListItem(
      memorialId: memorial.id,
      name: memorial.name,
      relation: memorial.relation ?? '관계 미정',
      categories: categories,
      accentColor: _accentColorFor(memorial),
      updatedAtLabel: _formatUpdatedAt(memorial.updatedAt),
      anniversaryLabel:
          memorial.anniversaryLabel ?? '기념일 정보가 아직 없습니다.',
      tags: tags,
      storyPreview: memorial.story?.isNotEmpty == true
          ? memorial.story!
          : '추억 이야기가 아직 작성되지 않았습니다.',
      isPinned: memorial.isPinned,
      isFavorite: memorial.isFavorite,
      heroImageUrl: memorial.heroImageUrl ??
          'https://picsum.photos/seed/${Uri.encodeComponent(memorial.id)}/720/420',
      createdAt: memorial.createdAt,
    );
  }

  static List<String> _fallbackCategories(String? relation) {
    if (relation == null || relation.trim().isEmpty) {
      return const ['기타'];
    }
    final normalized = relation.toLowerCase();
    if (normalized.contains('반려')) return const ['반려동물'];
    if (normalized.contains('친구')) return const ['친구'];
    if (normalized.contains('선생') || normalized.contains('교수')) {
      return const ['스승'];
    }
    if (normalized.contains('어머니') ||
        normalized.contains('아버지') ||
        normalized.contains('부모') ||
        normalized.contains('형') ||
        normalized.contains('오빠') ||
        normalized.contains('언니') ||
        normalized.contains('누나') ||
        normalized.contains('동생') ||
        normalized.contains('자녀') ||
        normalized.contains('가족')) {
      return const ['가족'];
    }
    return const ['기타'];
  }

  static List<String> _fallbackTags(Memorial memorial) {
    final tags = <String>[
      memorial.isPublic ? '공개 추모관' : '비공개 추모관',
      memorial.allowComments ? '편지 허용' : '편지 제한',
      memorial.allowSharing ? '공유 허용' : '공유 제한',
    ];
    if (memorial.anniversaryLabel != null &&
        memorial.anniversaryLabel!.trim().isNotEmpty) {
      tags.add(memorial.anniversaryLabel!.trim());
    }
    if (memorial.relation != null && memorial.relation!.trim().isNotEmpty) {
      tags.add(memorial.relation!.trim());
    }
    return tags;
  }

  static Color _accentColorFor(Memorial memorial) {
    const palette = [
      AppPalette.warmBrown,
      AppPalette.accentMint,
      AppPalette.accentLavender,
      AppPalette.accentGold,
      AppPalette.accentPink,
      AppPalette.deepBlue,
    ];
    final seed = memorial.id.isNotEmpty
        ? memorial.id.hashCode
        : memorial.name.hashCode;
    final color = palette[seed.abs() % palette.length];
    return AppPalette.accessibleAccent(color);
  }

  static String _formatUpdatedAt(DateTime updatedAt) {
    final now = DateTime.now();
    final difference = now.difference(updatedAt);
    if (difference.inMinutes <= 1) {
      return '방금 전 업데이트';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전 업데이트';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전 업데이트';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전 업데이트';
    } else {
      final month = updatedAt.month.toString().padLeft(2, '0');
      final day = updatedAt.day.toString().padLeft(2, '0');
      return '${updatedAt.year}.$month.$day 업데이트';
    }
  }
}

class _CardIconButton extends StatelessWidget {
  const _CardIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isActive = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? AppPalette.warmBrown : AppPalette.warmBeige,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 18,
            color: isActive ? AppPalette.warmBrown : AppPalette.ink,
          ),
        ),
      ),
    );
  }
}


