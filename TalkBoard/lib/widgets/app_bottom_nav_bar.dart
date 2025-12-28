import 'package:flutter/material.dart';
import 'package:free_board/utils/design_tokens.dart';

enum AppNavTab { home, matching, gratitude, mypage, settings }

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.currentTab});

  final AppNavTab currentTab;

  static const List<_NavItem> _items = [
    _NavItem(AppNavTab.home, '홈', Icons.home_outlined, '/home'),
    _NavItem(AppNavTab.matching, '위로 매칭', Icons.handshake_outlined, '/matching'),
    _NavItem(AppNavTab.gratitude, '감사 혜택', Icons.card_giftcard_outlined, '/gratitude-benefits'),
    _NavItem(AppNavTab.mypage, '마이페이지', Icons.person_outline, '/mypage'),
    _NavItem(AppNavTab.settings, '설정', Icons.settings_outlined, '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _items.indexWhere((item) => item.tab == currentTab);

    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.white,
        boxShadow: DesignTokens.shadowTop,
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: DesignTokens.warmBrown.withOpacity(0.1),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: states.contains(MaterialState.selected)
                  ? DesignTokens.warmBrown
                  : DesignTokens.caption,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              size: 24,
              color: states.contains(MaterialState.selected)
                  ? DesignTokens.warmBrown
                  : DesignTokens.caption,
            ),
          ),
        ),
        child: NavigationBar(
          height: 72,
          elevation: 0,
          backgroundColor: DesignTokens.white,
          selectedIndex: currentIndex.isNegative ? 0 : currentIndex,
          destinations: _items
              .map(
                (item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(
                    item.icon,
                    color: DesignTokens.warmBrown,
                  ),
                  label: item.label,
                ),
              )
              .toList(),
          onDestinationSelected: (index) => _handleTap(context, _items[index]),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, _NavItem item) {
    if (item.tab == currentTab) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      item.routeName,
      (route) => route.isFirst,
    );
  }
}

class _NavItem {
  const _NavItem(this.tab, this.label, this.icon, this.routeName);

  final AppNavTab tab;
  final String label;
  final IconData icon;
  final String routeName;
}
