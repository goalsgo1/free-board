import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/components/app_inputs.dart';

class PremiumSubscriptionScreen extends StatefulWidget {
  const PremiumSubscriptionScreen({super.key});

  static const routeName = '/premium-subscription';

  @override
  State<PremiumSubscriptionScreen> createState() => _PremiumSubscriptionScreenState();
}

class _PremiumSubscriptionScreenState extends State<PremiumSubscriptionScreen> {
  bool _autoRenewal = true;
  bool _shareBenefitsWithFamily = false;
  final TextEditingController _couponController = TextEditingController();

  static const List<_PremiumBenefit> _benefits = [
    _PremiumBenefit(
      title: '추모관 프리미엄 테마 전체 이용',
      description: '빛, 계절, 음악 테마 등 24개의 프리미엄 디자인을 자유롭게 적용할 수 있어요.',
      icon: Icons.palette_outlined,
    ),
    _PremiumBenefit(
      title: 'AI 기억 답장 무제한',
      description: '베타 기간 대기열 없이 즉시 답장을 생성하고, 저장 횟수 제한 없이 이용합니다.',
      icon: Icons.smart_toy_outlined,
    ),
    _PremiumBenefit(
      title: '고해상도 백업 & 보관',
      description: '사진·영상·음성 데이터를 원본 품질로 백업하고 365일 안전하게 보관해 드립니다.',
      icon: Icons.cloud_outlined,
    ),
  ];

  static const List<_BillingHistory> _history = [
    _BillingHistory(
      label: '2024.12.01 자동결제',
      description: '월간 프리미엄 · ₩9,900 · 카드 ****-0627',
      status: '성공',
    ),
    _BillingHistory(
      label: '2024.11.01 자동결제',
      description: '월간 프리미엄 · ₩9,900 · 카드 ****-0627',
      status: '성공',
    ),
    _BillingHistory(
      label: '2024.10.01 자동결제',
      description: '월간 프리미엄 · ₩9,900 · 카드 ****-0627',
      status: '성공',
    ),
  ];

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('프리미엄 구독 관리'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '현재 이용 중인 멤버십',
              subtitle: '월간 프리미엄 · ₩9,900 / 월 · 2025.01.01까지 이용 가능',
              icon: Icons.workspace_premium_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SubscriptionBadge(label: '체험판 3일 남음'),
                            const SizedBox(height: 12),
                            Text(
                              '다음 결제일 · 2025.01.02',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '결제 수단 · 카드 ****-0627',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      AppOutlinedButton(
                        label: '결제 수단 변경',
                        leadingIcon: Icons.payment_outlined,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('결제 수단 변경은 다음 업데이트에서 제공됩니다.')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('자동 갱신'),
                    subtitle: const Text('자동 갱신을 끄면 만료일까지 이용 후 멤버십이 종료됩니다.'),
                    value: _autoRenewal,
                    onChanged: (value) => setState(() => _autoRenewal = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('가족과 혜택 공유'),
                    subtitle: const Text('가족 계정 2명까지 프리미엄 혜택을 함께 이용할 수 있습니다.'),
                    value: _shareBenefitsWithFamily,
                    onChanged: (value) => setState(() => _shareBenefitsWithFamily = value),
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '프리미엄 혜택',
              subtitle: '현재 구독으로 이용할 수 있는 주요 기능입니다.',
              icon: Icons.card_giftcard_outlined,
              child: Column(
                children: [
                  for (final benefit in _benefits) ...[
                    _BenefitTile(benefit: benefit),
                    if (benefit != _benefits.last) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '쿠폰 / 코드 입력',
              subtitle: '쿠폰을 입력하면 즉시 적용되며, 남은 기간 이후부터 차감됩니다.',
              icon: Icons.confirmation_num_outlined,
              child: Column(
                children: [
                  AppTextField(
                    controller: _couponController,
                    label: '쿠폰 코드',
                    hint: '예: THANKS2025',
                    prefixIcon: const Icon(Icons.sell_outlined),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppPrimaryButton(
                      label: '쿠폰 적용',
                      icon: Icons.check_circle_outline,
                      onPressed: () {
                        if (_couponController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('쿠폰 코드를 입력해주세요.')),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('"${_couponController.text.trim()}" 쿠폰은 확인 후 적용됩니다.'),
                          ),
                        );
                        _couponController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '결제 내역',
              subtitle: '최근 3개월간 자동결제 내역입니다.',
              icon: Icons.receipt_long_outlined,
              child: Column(
                children: [
                  for (final item in _history) ...[
                    _BillingHistoryTile(item: item),
                    if (item != _history.last) const Divider(height: 24),
                  ],
                  const SizedBox(height: 12),
                  AppOutlinedButton(
                    label: '전체 내역 다운로드',
                    leadingIcon: Icons.cloud_download_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('상세 내역 다운로드는 준비 중입니다.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    label: '구독 해지 신청',
                    leadingIcon: Icons.cancel_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('구독 해지는 고객센터 상담 후 처리됩니다.')),
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
}

class _SubscriptionBadge extends StatelessWidget {
  const _SubscriptionBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({required this.benefit});

  final _PremiumBenefit benefit;

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
          child: Icon(benefit.icon, color: Colors.black87, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                benefit.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                benefit.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BillingHistoryTile extends StatelessWidget {
  const _BillingHistoryTile({required this.item});

  final _BillingHistory item;

  Color _statusColor(String status) {
    return status == '성공'
        ? const Color.fromRGBO(0, 120, 0, 1)
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          item.status,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: _statusColor(item.status),
              ),
        ),
      ],
    );
  }
}

class _PremiumBenefit {
  const _PremiumBenefit({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

class _BillingHistory {
  const _BillingHistory({
    required this.label,
    required this.description,
    required this.status,
  });

  final String label;
  final String description;
  final String status;
}
