import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({super.key});

  static const routeName = '/donation-history';

  static final List<_DonationRecord> _records = List.unmodifiable([
    _DonationRecord(
      donor: '김서윤',
      amount: 50000,
      memorial: '박정윤 추모관',
      date: DateTime(2024, 12, 10),
      message: '엄마와의 추억을 나눠주셔서 감사합니다.',
    ),
    _DonationRecord(
      donor: '익명',
      amount: 30000,
      memorial: '반려견 브라우니 추모관',
      date: DateTime(2024, 12, 2),
      message: '브라우니를 기억하며 작은 위로를 전합니다.',
    ),
    _DonationRecord(
      donor: '이도현',
      amount: 20000,
      memorial: '박정윤 추모관',
      date: DateTime(2024, 11, 21),
      message: '기념일에 맞춰 헌화를 보냅니다.',
    ),
  ]);

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  late final Map<DateTime, List<_DonationRecord>> _recordsByDate;
  late final List<DateTime> _sortedDates;
  late DateTime _selectedDate;
  late DateTime _displayedMonth;
  late final DateTime _minMonth;
  late final DateTime _maxMonth;
  late final int _totalAmount;
  late final int _recentAmount;
  late final int _thankYouCount;

  @override
  void initState() {
    super.initState();
    _recordsByDate = {};
    for (final record in DonationHistoryScreen._records) {
      final key = _dateOnly(record.date);
      _recordsByDate.putIfAbsent(key, () => []).add(record);
    }
    _sortedDates = _recordsByDate.keys.toList()..sort();
    if (_sortedDates.isEmpty) {
      final today = _dateOnly(DateTime.now());
      _sortedDates.add(today);
      _recordsByDate[today] = const [];
    }
    _selectedDate = _sortedDates.last;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
    _minMonth = DateTime(_sortedDates.first.year, _sortedDates.first.month);
    _maxMonth = DateTime(_sortedDates.last.year, _sortedDates.last.month);

    _totalAmount = DonationHistoryScreen._records.fold<int>(0, (sum, record) => sum + record.amount);
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    _recentAmount = DonationHistoryScreen._records
        .where((record) => record.date.isAfter(thirtyDaysAgo))
        .fold<int>(0, (sum, record) => sum + record.amount);
    _thankYouCount = DonationHistoryScreen._records.length;
  }

  List<_DonationRecord> get _selectedRecords =>
      _recordsByDate[_dateOnly(_selectedDate)] ?? const [];

  bool _hasDonations(DateTime date) => _recordsByDate.containsKey(_dateOnly(date));

  void _changeMonth(int offset) {
    final newMonth = DateTime(_displayedMonth.year, _displayedMonth.month + offset);
    if (newMonth.isBefore(_minMonth) || newMonth.isAfter(_maxMonth)) return;
    setState(() {
      _displayedMonth = newMonth;
      if (_selectedDate.year == newMonth.year && _selectedDate.month == newMonth.month) {
        return;
      }
      final matchingDate = _sortedDates.firstWhere(
        (date) => date.year == newMonth.year && date.month == newMonth.month,
        orElse: () => DateTime(newMonth.year, newMonth.month, 1),
      );
      _selectedDate = matchingDate;
    });
  }

  List<DateTime?> _buildMonthDays(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final leadingBlank = firstDay.weekday % 7;
    final totalCells = leadingBlank + daysInMonth;
    final rows = (totalCells / 7).ceil() * 7;
    final days = <DateTime?>[];
    for (int i = 0; i < leadingBlank; i++) {
      days.add(null);
    }
    for (int i = 0; i < daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i + 1));
    }
    while (days.length < rows) {
      days.add(null);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final selectedRecords = _selectedRecords;
    final calendarDays = _buildMonthDays(_displayedMonth);
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('추모금 내역'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.mypage),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '추모금 요약',
              subtitle: '누적 추모금과 최근 30일 동안 받은 감사 메시지 수입니다.',
              icon: Icons.savings_outlined,
              child: _SummaryStats(
                totalAmount: _totalAmount,
                recentAmount: _recentAmount,
                thankYouCount: _thankYouCount,
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '추모금 캘린더',
              subtitle: '받은 날짜를 선택하면 해당 일자의 상세 추모금 내역을 확인할 수 있어요.',
              icon: Icons.calendar_month_outlined,
              child: Column(
                children: [
                  _CalendarHeader(
                    month: _displayedMonth,
                    onPrev: () => _changeMonth(-1),
                    onNext: () => _changeMonth(1),
                    canGoPrev: !_isSameMonth(_displayedMonth, _minMonth),
                    canGoNext: !_isSameMonth(_displayedMonth, _maxMonth),
                  ),
                  const SizedBox(height: 12),
                  _CalendarGrid(
                    days: calendarDays,
                    selectedDate: _selectedDate,
                    displayMonth: _displayedMonth,
                    hasDonations: _hasDonations,
                    onSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '상세 내역',
              subtitle: '${_formatDate(_selectedDate)} 추모금 내역입니다.',
              icon: Icons.list_alt_outlined,
              child: selectedRecords.isEmpty
                  ? const AppHelperText(
                      icon: Icons.hourglass_empty_outlined,
                      text: '선택한 날짜에는 추모금이 전달되지 않았어요.',
                    )
                  : Column(
                      children: [
                        for (final record in selectedRecords) ...[
                          _DonationHistoryTile(record: record),
                          if (record != selectedRecords.last)
                            const Divider(height: 24),
                        ],
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '요일별 통계',
              subtitle: '최근 30일 기준 요일별 추모금 금액입니다.',
              icon: Icons.bar_chart_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _StatRow(label: '월요일', value: '₩30,000'),
                  SizedBox(height: 8),
                  _StatRow(label: '수요일', value: '₩50,000'),
                  SizedBox(height: 8),
                  _StatRow(label: '주말 합계', value: '₩20,000'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    label: 'CSV로 내보내기',
                    leadingIcon: Icons.download_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('CSV 내보내기는 준비 중입니다.')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryButton(
                    label: '마이페이지로 돌아가기',
                    icon: Icons.home_outlined,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameMonth(DateTime a, DateTime b) => a.year == b.year && a.month == b.month;
}

class _SummaryStats extends StatelessWidget {
  const _SummaryStats({
    required this.totalAmount,
    required this.recentAmount,
    required this.thankYouCount,
  });

  final int totalAmount;
  final int recentAmount;
  final int thankYouCount;

  @override
  Widget build(BuildContext context) {
    final entries = <MapEntry<String, String>>[
      MapEntry('총 누적 추모금', _formatCurrency(totalAmount)),
      MapEntry('최근 30일 추모금', _formatCurrency(recentAmount)),
      MapEntry('감사 메시지', '$thankYouCount건'),
    ];
    return Row(
      children: List.generate(entries.length, (index) {
        final entry = entries[index];
        final margin = EdgeInsets.only(right: index == entries.length - 1 ? 0 : 12);
        return Expanded(
          child: _SummaryChip(
            label: entry.key,
            value: entry.value,
            margin: margin,
          ),
        );
      }),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.value,
    this.margin,
  });

  final String label;
  final String value;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}

class _DonationHistoryTile extends StatelessWidget {
  const _DonationHistoryTile({required this.record});

  final _DonationRecord record;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
          ),
          child: const Icon(Icons.favorite_outline, color: Colors.black, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.donor,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${record.memorial} · ${_formatDate(record.date)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                record.message,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      height: 1.6,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatCurrency(record.amount),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 12),
            AppOutlinedButton(
              label: '감사장 보내기',
              leadingIcon: Icons.mail_outlined,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${record.donor} 님께 감사장을 준비 중입니다.')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _DonationRecord {
  const _DonationRecord({
    required this.donor,
    required this.amount,
    required this.memorial,
    required this.date,
    required this.message,
  });

  final String donor;
  final int amount;
  final String memorial;
  final DateTime date;
  final String message;
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

String _formatCurrency(int amount) {
  final digits = amount.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    final positionFromEnd = digits.length - i;
    buffer.write(digits[i]);
    if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
      buffer.write(',');
    }
  }
  return '₩${buffer.toString()}';
}

String _formatDate(DateTime date) {
  final mm = date.month.toString().padLeft(2, '0');
  final dd = date.day.toString().padLeft(2, '0');
  return '${date.year}.$mm.$dd';
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({
    required this.month,
    required this.onPrev,
    required this.onNext,
    required this.canGoPrev,
    required this.canGoNext,
  });

  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final bool canGoPrev;
  final bool canGoNext;

  String get _label => '${month.year}년 ${month.month}월';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: canGoPrev ? onPrev : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          _label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
        ),
        IconButton(
          onPressed: canGoNext ? onNext : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.days,
    required this.selectedDate,
    required this.displayMonth,
    required this.hasDonations,
    required this.onSelected,
  });

  final List<DateTime?> days;
  final DateTime selectedDate;
  final DateTime displayMonth;
  final bool Function(DateTime) hasDonations;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    const weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: weekdayLabels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        for (int row = 0; row < days.length / 7; row++)
          Row(
            children: [
              for (int col = 0; col < 7; col++)
                Expanded(
                  child: _CalendarCell(
                    date: days[row * 7 + col],
                    displayMonth: displayMonth,
                    isSelected: days[row * 7 + col] != null &&
                        DateUtils.isSameDay(days[row * 7 + col], selectedDate),
                    hasDonation: days[row * 7 + col] != null && hasDonations(days[row * 7 + col]!),
                    onTap: (date) {
                      onSelected(date);
                    },
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _CalendarCell extends StatelessWidget {
  const _CalendarCell({
    required this.date,
    required this.displayMonth,
    required this.isSelected,
    required this.hasDonation,
    required this.onTap,
  });

  final DateTime? date;
  final DateTime displayMonth;
  final bool isSelected;
  final bool hasDonation;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return const SizedBox(height: 48);
    }
    final isOutOfMonth = date!.month != displayMonth.month;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isOutOfMonth
              ? Colors.black.withOpacity(0.3)
              : isSelected
                  ? Colors.white
                  : Colors.black,
          fontWeight: hasDonation ? FontWeight.w700 : FontWeight.w500,
        );
    return GestureDetector(
      onTap: () => onTap(date!),
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasDonation ? Colors.black : const Color.fromRGBO(0, 0, 0, 0.12),
            width: hasDonation ? 1.6 : 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${date!.day}', style: textStyle),
            if (hasDonation && !isSelected)
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
