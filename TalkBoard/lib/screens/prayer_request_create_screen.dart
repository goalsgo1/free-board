import 'package:flutter/material.dart';
import 'package:free_board/board/board_themes.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/board/board_section_card.dart';
import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class PrayerRequestCreateScreen extends StatefulWidget {
  const PrayerRequestCreateScreen({super.key});

  static const routeName = '/prayer-create';

  @override
  State<PrayerRequestCreateScreen> createState() =>
      _PrayerRequestCreateScreenState();
}

class _PrayerRequestCreateScreenState
    extends State<PrayerRequestCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _detailController = TextEditingController();
  final _answerController = TextEditingController();
  final _donationGoalController = TextEditingController();

  String _selectedCategory = '가족';
  bool _shareWithCommunity = true;
  bool _allowComments = true;
  bool _enableDonation = true;

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _detailController.dispose();
    _answerController.dispose();
    _donationGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardTheme = BoardThemes.prayer;
    final formTheme = boardTheme.createForm!;
    final mediaRules = boardTheme.mediaRules;
    final List<BoardHelperMessage> mediaMessages = [
      if (mediaRules?.maxAttachments != null)
        BoardHelperMessage(
          icon: Icons.collections_outlined,
          text: '최대 ${mediaRules!.maxAttachments}개의 파일을 업로드할 수 있어요.',
        ),
      if (mediaRules?.maxFileSizeMb != null)
        BoardHelperMessage(
          icon: Icons.cloud_upload_outlined,
          text:
              '파일당 ${mediaRules!.maxFileSizeMb!.toStringAsFixed(0)}MB 이하로 업로드해주세요.',
        ),
      ...?mediaRules?.helperMessages,
      ...formTheme.additionalMediaGuidelines,
    ];
    final supportedTypes = (mediaRules?.supportedTypes ?? const [])
        .map((type) => '#$type')
        .join(' · ');
    return Scaffold(
      backgroundColor: boardTheme.backgroundColor,
      appBar: AppBar(
        title: Text(boardTheme.createAction.label),
        backgroundColor: boardTheme.appBarColor,
        foregroundColor: boardTheme.appBarForegroundColor,
        actions: const [AccessibilityButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          BoardSectionCard.fromIntro(
            intro: formTheme.introSection,
            child: BoardHelperMessages(
              messages: formTheme.introSection.helperMessages,
            ),
          ),
          if (mediaMessages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: BoardSectionCard(
                title: '업로드 가이드',
                subtitle: supportedTypes.isEmpty
                    ? '관련 자료를 첨부할 때 확인해주세요.'
                    : '지원 형식: $supportedTypes',
                icon: Icons.cloud_upload_outlined,
                accentColor: boardTheme.createAction.accentColor,
                child: BoardHelperMessages(messages: mediaMessages),
              ),
            ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSurfaceCard(
                  title: '기본 정보',
                  subtitle: '기도 제목의 범주와 핵심 내용을 입력합니다.',
                  icon: Icons.edit_note_outlined,
                  accentColor: AppPalette.accentLavender,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _titleController,
                        label: '기도 제목',
                        hint: '예: 어머니의 항암 치료를 위해',
                        prefixIcon: const Icon(Icons.title),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '기도 제목을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _summaryController,
                        label: '요약',
                        hint: '기도가 필요한 상황을 한 줄로 요약해주세요.',
                        prefixIcon: const Icon(Icons.short_text),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '요약 내용을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _CategorySelector(
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '기도 내용 작성',
                  subtitle: '기도 제목에 담긴 사연을 자세히 설명해주세요.',
                  icon: Icons.article_outlined,
                  accentColor: AppPalette.accentMint,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _detailController,
                        label: '기도 요청 상세 내용',
                        hint: '기도가 필요한 이유와 상황을 자세히 적어주세요.',
                        maxLines: 8,
                        prefixIcon: const Icon(Icons.description_outlined),
                        validator: (value) {
                          if (value == null || value.trim().length < 10) {
                            return '10자 이상으로 상황을 설명해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _answerController,
                        label: '응답 기록 (선택)',
                        hint: '응답이 있었다면 간단히 나누어 주세요.',
                        maxLines: 4,
                        prefixIcon: const Icon(Icons.check_circle_outline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '공개 설정',
                  subtitle: '기도 제목을 어떻게 공유할지 설정하세요.',
                  icon: Icons.settings_outlined,
                  accentColor: AppPalette.accentGold,
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('커뮤니티 전체와 공유'),
                        subtitle: const Text('비활성화하면 가족에게만 공개됩니다.'),
                        value: _shareWithCommunity,
                        onChanged: (value) {
                          setState(() {
                            _shareWithCommunity = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('응원 댓글 허용'),
                        subtitle:
                            const Text('함께 기도하는 분들이 응원 메시지를 남길 수 있습니다.'),
                        value: _allowComments,
                        onChanged: (value) {
                          setState(() {
                            _allowComments = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('기도 동참금 받기'),
                        subtitle:
                            const Text('경제적으로 돕고 싶은 경우를 위해 동참금을 받을 수 있습니다.'),
                        value: _enableDonation,
                        onChanged: (value) {
                          setState(() {
                            _enableDonation = value;
                            if (!value) {
                              _donationGoalController.clear();
                            }
                          });
                        },
                      ),
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: AppTextField(
                            controller: _donationGoalController,
                            label: '동참금 목표 금액 (선택)',
                            hint: '예: 300000 (숫자만 입력)',
                            prefixIcon: const Icon(Icons.savings_outlined),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        crossFadeState: _enableDonation
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '등록 전 확인사항',
                  subtitle: '모든 정보를 확인한 뒤 등록 버튼을 눌러주세요.',
                  icon: Icons.rule_folder_outlined,
                  accentColor: AppPalette.accentLavender,
                  child: const AppHelperText(
                    icon: Icons.warning_amber_rounded,
                    text:
                        '등록된 기도 요청은 관리자 검토 후 공개됩니다. 부적절한 내용은 비공개 처리될 수 있습니다.',
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        label: '초안으로 저장',
                        leadingIcon: Icons.save_outlined,
                        onPressed: _handleDraftSave,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPrimaryButton(
                        label: '기도 요청 등록하기',
                        icon: Icons.check_circle_outline,
                        onPressed: _handleSubmit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleDraftSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('초안 저장 기능은 준비 중입니다.'),
      ),
    );
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final donationGoalText = _enableDonation
        ? _donationGoalController.text.replaceAll(RegExp(r'[^0-9]'), '')
        : '';
    final donationMessage = _enableDonation
        ? (donationGoalText.isNotEmpty
            ? ' 목표 금액: ${_formatCurrency(int.parse(donationGoalText))}.'
            : ' 목표 금액 없이 동참금을 받을 예정입니다.')
        : ' 동참금은 받지 않습니다.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '"${_titleController.text.trim()}" 기도 요청이 등록되었습니다. 검토 후 공개됩니다.$donationMessage',
        ),
      ),
    );
    Navigator.pop(context);
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static const _categories = [
    '가족',
    '건강',
    '진로',
    '위로',
    '재정',
    '관계',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '카테고리 선택',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppPalette.warmBrown,
                ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories
              .map(
                (category) => ChoiceChip(
                  label: Text(category),
                  selected: value == category,
                  onSelected: (selected) {
                    if (selected) onChanged(category);
                  },
                  selectedColor: AppPalette.warmBrown,
                  labelStyle: TextStyle(
                    color: value == category ? Colors.white : AppPalette.warmBrown,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: value == category
                        ? AppPalette.warmBrown
                        : AppPalette.warmBeige,
                  ),
                ),
              )
              .toList(),
        ),
      ],
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

