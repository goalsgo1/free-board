import 'package:flutter/material.dart';
import 'package:free_board/board/board_themes.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/board/board_section_card.dart';
import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class RegretLetterCreateScreen extends StatefulWidget {
  const RegretLetterCreateScreen({super.key});

  static const routeName = '/regret-letter/create';

  @override
  State<RegretLetterCreateScreen> createState() =>
      _RegretLetterCreateScreenState();
}

class _RegretLetterCreateScreenState extends State<RegretLetterCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _promiseController = TextEditingController();
  final _tagController = TextEditingController();

  String _selectedMemorial = '김은희님 추모관';
  String _selectedTone = '사과와 감사';
  bool _shareWithCommunity = true;
  bool _allowComments = true;
  bool _highlightInMemorial = true;

  final List<String> _memorialOptions = [
    '김은희님 추모관',
    '박종현님 추모관',
    '이도현님 추모관',
    '새 추모관 선택 예정',
  ];

  final List<String> _toneOptions = [
    '사과와 감사',
    '추억 나눔',
    '앞으로의 다짐',
    '사랑과 그리움',
    '마지막 인사',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _promiseController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardTheme = BoardThemes.regretLetter;
    final formTheme = boardTheme.createForm!;
    final mediaRules = boardTheme.mediaRules;
    final List<BoardHelperMessage> mediaMessages = [
      if (mediaRules?.maxAttachments != null)
        BoardHelperMessage(
          icon: Icons.collections_outlined,
          text: '최대 ${mediaRules!.maxAttachments}개의 추억 자료를 첨부할 수 있어요.',
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
                    ? '첨부 가능한 자료 안내를 확인하세요.'
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
              children: [
                AppSurfaceCard(
                  title: '연결할 추모관 선택',
                  subtitle: '편지를 기록할 추모관을 골라주세요.',
                  icon: Icons.park_outlined,
                  accentColor: AppPalette.accentMint,
                  child: DropdownButtonFormField<String>(
                    value: _selectedMemorial,
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: const InputDecoration(
                      labelText: '추모관 선택',
                      border: OutlineInputBorder(),
                    ),
                    items: _memorialOptions
                        .map(
                          (option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedMemorial = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '편지 정보',
                  subtitle: '제목과 전하고 싶은 이야기를 작성해보세요.',
                  icon: Icons.edit_note_outlined,
                  accentColor: AppPalette.accentPink,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _titleController,
                        label: '편지 제목',
                        hint: '예: 더 자주 웃어드릴걸',
                        prefixIcon: const Icon(Icons.title),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '편지 제목을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _contentController,
                        label: '편지 내용',
                        hint: '전하고 싶은 이야기를 솔직하게 적어주세요.',
                        maxLines: 10,
                        prefixIcon: const Icon(Icons.notes),
                        validator: (value) {
                          if (value == null || value.trim().length < 30) {
                            return '30자 이상으로 마음을 전해주세요.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '편지 톤 선택',
                  subtitle: '편지의 분위기를 골라 태그로 보여줄 수 있어요.',
                  icon: Icons.sell_outlined,
                  accentColor: AppPalette.accentGold,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _toneOptions
                        .map(
                          (tone) => ChoiceChip(
                            label: Text(tone),
                            selected: _selectedTone == tone,
                            onSelected: (selected) {
                              if (!selected) return;
                              setState(() {
                                _selectedTone = tone;
                              });
                            },
                            selectedColor: AppPalette.warmBrown,
                            labelStyle: TextStyle(
                              color: _selectedTone == tone
                                  ? Colors.white
                                  : AppPalette.warmBrown,
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: _selectedTone == tone
                                  ? AppPalette.warmBrown
                                  : AppPalette.warmBeige,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '추억/다짐 메모',
                  subtitle: '편지와 함께 남길 추억이나 앞으로의 다짐을 기록할 수 있어요.',
                  icon: Icons.menu_book_outlined,
                  accentColor: AppPalette.accentLavender,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _promiseController,
                        label: '앞으로의 다짐 (선택)',
                        hint: '예: 가족들과 더 자주 만나 따뜻한 시간을 보낼게.',
                        maxLines: 3,
                        prefixIcon: const Icon(Icons.flag_outlined),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _tagController,
                        label: '태그 (쉼표로 구분)',
                        hint: '예: 감사, 사과, 그리움',
                        prefixIcon: const Icon(Icons.tag),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '공개 및 알림 설정',
                  subtitle: '편지를 누구에게 공유할지, 어떤 알림을 받을지 정할 수 있어요.',
                  icon: Icons.settings_outlined,
                  accentColor: AppPalette.accentMint,
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('커뮤니티 전체 공개'),
                        subtitle:
                            const Text('비활성화하면 가족에게만 보이고 커뮤니티 목록에는 노출되지 않습니다.'),
                        value: _shareWithCommunity,
                        onChanged: (value) {
                          setState(() {
                            _shareWithCommunity = value;
                          });
                        },
                        activeColor: AppPalette.warmBrown,
                      ),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('댓글 허용'),
                        subtitle: const Text('응원의 댓글과 공감을 받을 수 있습니다.'),
                        value: _allowComments,
                        onChanged: (value) {
                          setState(() {
                            _allowComments = value;
                          });
                        },
                        activeColor: AppPalette.warmBrown,
                      ),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('추모관 상단에 하이라이트 노출'),
                        subtitle: const Text('추모관 방문 시 이 편지가 상단에 노출됩니다.'),
                        value: _highlightInMemorial,
                        onChanged: (value) {
                          setState(() {
                            _highlightInMemorial = value;
                          });
                        },
                        activeColor: AppPalette.warmBrown,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        label: '임시 저장',
                        leadingIcon: Icons.save_outlined,
                        badgeText: '준비 중',
                        onPressed: _handleDraftSave,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPrimaryButton(
                        label: '편지 등록하기 (준비 중)',
                        icon: Icons.send_outlined,
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
      SnackBar(
        content: Text(
          '"${_titleController.text.trim().isEmpty ? '새 편지' : _titleController.text.trim()}" 임시 저장 기능은 준비 중입니다.',
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '"${_titleController.text.trim()}" 편지가 등록되었습니다. 검토 후 공개됩니다.',
        ),
      ),
    );
    Navigator.pop(context);
  }
}

