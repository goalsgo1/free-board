import 'package:flutter/material.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/components/app_inputs.dart';

class PrayerRequestDetailArguments {
  const PrayerRequestDetailArguments({
    required this.prayerId,
    required this.title,
    required this.requester,
    required this.relation,
    required this.category,
    required this.submittedAtLabel,
    required this.summary,
    required this.content,
    this.journal,
    this.imageUrls = const [],
    this.answerNote,
    this.allowsDonation = true,
    this.totalDonationAmount = 0,
    this.donorCount = 0,
  });

  final String prayerId;
  final String title;
  final String requester;
  final String relation;
  final String category;
  final String submittedAtLabel;
  final String summary;
  final String content;
  final String? journal;
  final List<String> imageUrls;
  final String? answerNote;
  final bool allowsDonation;
  final int totalDonationAmount;
  final int donorCount;

  const PrayerRequestDetailArguments.sample()
      : prayerId = 'prayer-001',
        title = '어머니의 항암 치료를 위해',
        requester = '김하늘 님',
        relation = '장녀',
        category = '가족',
        submittedAtLabel = '2024.03.15 · 09:12 등록',
        summary =
            '이번 주 월요일부터 항암 치료 3차에 들어갑니다. 부작용 없이 잘 견딜 수 있도록 함께 기도해 주세요.',
        content =
            '어머니는 3년 전 유방암 판정을 받고 수술과 치료를 계속 이어오고 있습니다. 최근 검사에서 재발 가능성이 있어 항암 치료를 다시 시작하게 되었습니다. \n\n부작용으로 인해 식사를 잘 못하시고, 체력이 빠르게 떨어지고 있어 걱정이 큽니다. \n\n1) 항암 치료 중 부작용이 최소화되도록 \n2) 가족 모두가 지치지 않고 돌볼 수 있도록 \n3) 의료진에게 지혜가 더해지도록 함께 기도 부탁드립니다.',
        journal =
            '3월 18일 오전 10시 · 어머니께서 오늘은 어제보다 괜찮다고 말씀하셨어요. 간단한 죽을 드셨고, 기도해 주시는 분들께 감사 인사를 전하고 싶다고 하셨어요.',
        imageUrls = const [
          'https://picsum.photos/seed/prayer1/800/600',
          'https://picsum.photos/seed/prayer2/800/600',
        ],
        answerNote =
            '3월 27일 · 항암 치료 3차가 무사히 끝났습니다. 체력은 조금 떨어졌지만 큰 부작용 없이 회복 중이에요. 기도해 주신 모든 분들께 감사드립니다.',
        allowsDonation = true,
        totalDonationAmount = 385000,
        donorCount = 27;
}

class PrayerRequestDetailScreen extends StatefulWidget {
  const PrayerRequestDetailScreen({super.key});

  static const routeName = '/prayer-detail';

  @override
  State<PrayerRequestDetailScreen> createState() =>
      _PrayerRequestDetailScreenState();
}

class _PrayerRequestDetailScreenState extends State<PrayerRequestDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _shareAnswerPublicly = true;
  int? _selectedDonationAmount;
  final TextEditingController _customDonationController =
      TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    _customDonationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as PrayerRequestDetailArguments?;
    final data = args ?? const PrayerRequestDetailArguments.sample();

    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('기도 상세'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppPalette.accentLavender,
        foregroundColor: AppPalette.warmBrown,
        icon: const Icon(Icons.self_improvement_outlined),
        label: const Text('기도 완료 기록'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('기도 완료 기록 기능은 준비 중입니다.'),
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: data.title,
            subtitle:
                '${data.requester} · ${data.relation} · ${data.category} · ${data.submittedAtLabel}',
            icon: Icons.volunteer_activism_outlined,
            accentColor: AppPalette.accentPink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.summary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppPalette.ink,
                      ),
                ),
                const SizedBox(height: 16),
                const AppHelperText(
                  icon: Icons.info_outline,
                  text: '110명이 함께 기도 중입니다. 오늘 8명이 새롭게 참여했습니다.',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _PrayerTagChip(label: '응답 대기'),
                    _PrayerTagChip(label: '건강 돌봄'),
                    _PrayerTagChip(label: '가족'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '기도 요청 내용',
            subtitle: '기도 제목에 담긴 상황을 자세히 확인하세요.',
            icon: Icons.article_outlined,
            accentColor: AppPalette.accentLavender,
            child: Text(
              data.content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                    color: AppPalette.ink,
                  ),
            ),
          ),
          if (data.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '함께 나눈 기록',
              subtitle: '사진과 메모로 기도 제목의 상황을 공유합니다.',
              icon: Icons.photo_library_outlined,
              accentColor: AppPalette.accentMint,
              child: SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final url = data.imageUrls[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        url,
                        width: 220,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: data.imageUrls.length,
                ),
              ),
            ),
          ],
          if (data.journal != null) ...[
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '진행 상황 업데이트',
              subtitle: '기도 제목과 관련된 최근 소식입니다.',
              icon: Icons.update_outlined,
              accentColor: AppPalette.accentGold,
              child: Text(
                data.journal!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: AppPalette.ink,
                    ),
              ),
            ),
          ],
          if (data.answerNote != null) ...[
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '응답 소식',
              subtitle: '함께 기도한 분들과 감사 소식을 나눠보세요.',
              icon: Icons.celebration_outlined,
              accentColor: AppPalette.accentLavender,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.answerNote!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                          color: AppPalette.ink,
                        ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('응답 소식을 공개 목록에 공유'),
                    subtitle: const Text('공개 시 다른 가족들이 응답 소식을 함께 보며 감사할 수 있습니다.'),
                    value: _shareAnswerPublicly,
                    onChanged: (value) {
                      setState(() {
                        _shareAnswerPublicly = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
          if (data.allowsDonation) ...[
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '기도 동참금',
              subtitle: '기도와 함께 경제적으로 돕고 싶은 분들을 위한 공간입니다.',
              icon: Icons.volunteer_activism_outlined,
              accentColor: AppPalette.accentPink,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '현재까지 ${_formatCurrency(data.totalDonationAmount)}이 모였어요 · ${data.donorCount}명이 함께했어요.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                          color: AppPalette.ink,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [10000, 20000, 50000, 100000]
                        .map(
                          (amount) => _DonationAmountChip(
                            amount: amount,
                            selected: _selectedDonationAmount == amount,
                            onSelected: (selected) {
                              setState(() {
                                _selectedDonationAmount =
                                    selected ? amount : null;
                                if (selected) {
                                  _customDonationController.clear();
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: _customDonationController,
                    label: '직접 입력 (₩)',
                    hint: '원하시는 금액을 입력하세요.',
                    prefixIcon: const Icon(Icons.edit_outlined),
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      if (_selectedDonationAmount != null &&
                          _customDonationController.text.isNotEmpty) {
                        setState(() {
                          _selectedDonationAmount = null;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppOutlinedButton(
                          label: '동참금 안내 보기',
                          leadingIcon: Icons.article_outlined,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('동참금 사용 계획 안내는 준비 중입니다.'),
                              ),
                            );
                          },
                          color: AppPalette.accentPink,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppPrimaryButton(
                          label: '기도 동참금 보내기',
                          icon: Icons.favorite,
                          onPressed: () => _handleDonation(context),
                          accentColor: AppPalette.accentPink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '응원 메시지',
            subtitle: '따뜻한 응원과 위로의 말을 남겨보세요.',
            icon: Icons.forum_outlined,
            accentColor: AppPalette.accentPink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _EncouragementBubble(
                  author: '이민지',
                  relation: '교회 공동체',
                  content: '함께 기도하고 있습니다. 치료 과정 중에도 평안과 힘이 함께하길 기도할게요.',
                  createdAt: '1시간 전',
                ),
                SizedBox(height: 12),
                _EncouragementBubble(
                  author: '장영호',
                  relation: '작은교구 리더',
                  content:
                      '의료진에게 지혜가 임하고, 가족 모두에게 휴식과 위로가 주어지길 기도합니다.',
                  createdAt: '3시간 전',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '응원 댓글 남기기',
            subtitle: '기도로 함께하고 있다는 메시지를 남겨주세요.',
            icon: Icons.edit_note_outlined,
            accentColor: AppPalette.accentMint,
            child: Column(
              children: [
                AppTextField(
                  controller: _commentController,
                  label: '응원 댓글',
                  hint: '예: 함께 기도하고 있습니다. 꼭 회복되실 거예요.',
                  maxLines: 3,
                  prefixIcon: const Icon(Icons.chat_bubble_outline),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        label: '임시 저장',
                        leadingIcon: Icons.save_outlined,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('임시 저장 기능은 준비 중입니다.'),
                            ),
                          );
                        },
                        color: AppPalette.accentMint,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPrimaryButton(
                        label: '응원 남기기',
                        icon: Icons.send_outlined,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('응원 댓글이 등록되었습니다.'),
                            ),
                          );
                          _commentController.clear();
                        },
                        accentColor: AppPalette.accentMint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '다른 기도 제목 살펴보기',
            subtitle: '비슷한 기도 제목을 함께 살펴보고 응답을 나눌 수 있습니다.',
            icon: Icons.diversity_2_outlined,
            accentColor: AppPalette.accentGold,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _SuggestedPrayerCard(
                  title: '아버지의 심장 수술 회복',
                  category: '건강',
                  participants: 58,
                  routeName: PrayerRequestDetailScreen.routeName,
                ),
                _SuggestedPrayerCard(
                  title: '형제의 진로 고민',
                  category: '진로',
                  participants: 17,
                  routeName: PrayerRequestDetailScreen.routeName,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleDonation(BuildContext context) {
    FocusScope.of(context).unfocus();
    int? amount = _selectedDonationAmount;
    if (amount == null) {
      final sanitized =
          _customDonationController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (sanitized.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('동참할 금액을 선택하거나 입력해주세요.')),
        );
        return;
      }
      amount = int.tryParse(sanitized);
      if (amount == null || amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('올바른 금액을 입력해주세요.')),
        );
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('${_formatCurrency(amount)}을 기도로 함께했습니다. 감사합니다!'),
      ),
    );
    setState(() {
      _selectedDonationAmount = null;
      _customDonationController.clear();
    });
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

class _DonationAmountChip extends StatelessWidget {
  const _DonationAmountChip({
    required this.amount,
    required this.selected,
    required this.onSelected,
  });

  final int amount;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final label = _formatCurrency(amount);
    final textStyle = TextStyle(
      color: selected ? Colors.white : AppPalette.warmBrown,
      fontWeight: FontWeight.w600,
    );
    return ChoiceChip(
      label: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 140),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, style: textStyle),
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: AppPalette.warmBrown,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected ? AppPalette.warmBrown : AppPalette.warmBeige,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}

class _PrayerTagChip extends StatelessWidget {
  const _PrayerTagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.warmBeige,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.warmBrown.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppPalette.warmBrown,
        ),
      ),
    );
  }
}

class _EncouragementBubble extends StatelessWidget {
  const _EncouragementBubble({
    required this.author,
    required this.relation,
    required this.content,
    required this.createdAt,
  });

  final String author;
  final String relation;
  final String content;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.warmBeige, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_border, color: AppPalette.accentPink),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '$author · $relation',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppPalette.warmBrown,
                      ),
                ),
              ),
              Text(
                createdAt,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppPalette.caption,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: AppPalette.ink,
                ),
          ),
        ],
      ),
    );
  }
}

class _SuggestedPrayerCard extends StatelessWidget {
  const _SuggestedPrayerCard({
    required this.title,
    required this.category,
    required this.participants,
    required this.routeName,
  });

  final String title;
  final String category;
  final int participants;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          routeName,
          arguments: const PrayerRequestDetailArguments.sample(),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppPalette.warmBeige, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppPalette.accentMint.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.self_improvement_outlined,
                    color: AppPalette.accentMint,
                  ),
                ),
                const Spacer(),
                Text(
                  '$participants명',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.accentMint,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppPalette.warmBrown,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              category,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.caption,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

