import 'package:flutter/material.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class EmotionPostCreateScreen extends StatefulWidget {
  const EmotionPostCreateScreen({super.key});

  static const routeName = '/emotion-create';

  @override
  State<EmotionPostCreateScreen> createState() =>
      _EmotionPostCreateScreenState();
}

class _EmotionPostCreateScreenState extends State<EmotionPostCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  final _tagController = TextEditingController();
  final _memoryController = TextEditingController();

  String _selectedMood = '감사';
  bool _allowComments = true;
  bool _shareWithCommunity = true;

  @override
  void dispose() {
    _titleController.dispose();
    _storyController.dispose();
    _tagController.dispose();
    _memoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('감정 글 작성'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: '마음을 나눠요',
            subtitle: '지금 느끼는 감정을 솔직하게 표현해보세요.',
            icon: Icons.favorite_border,
            accentColor: AppPalette.accentPink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHelperText(
                  icon: Icons.info_outline,
                  text: '따뜻한 언어와 배려를 담아 적어주세요. 욕설이나 개인정보는 포함되지 않도록 주의해 주세요.',
                ),
                SizedBox(height: 12),
                AppHelperText(
                  icon: Icons.tips_and_updates_outlined,
                  text: '감정 공유 글은 검토 후 공개되며, 필요한 경우 비공개 처리될 수 있습니다.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSurfaceCard(
                  title: '감정 선택',
                  subtitle: '현재 마음에 가장 가까운 감정을 골라주세요.',
                  icon: Icons.mood,
                  accentColor: AppPalette.accentLavender,
                  child: _MoodSelector(
                    value: _selectedMood,
                    onChanged: (value) {
                      setState(() {
                        _selectedMood = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '감정 기록',
                  subtitle: '제목과 내용을 입력해 감정을 나눠보세요.',
                  icon: Icons.edit_note_outlined,
                  accentColor: AppPalette.accentMint,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _titleController,
                        label: '제목',
                        hint: '예: 오늘 문득 찾아온 그리움',
                        prefixIcon: const Icon(Icons.title),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '제목을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _storyController,
                        label: '내용',
                        hint: '어떤 감정을 느꼈는지, 어떤 일이 있었는지 나눠주세요.',
                        maxLines: 8,
                        prefixIcon: const Icon(Icons.article_outlined),
                        validator: (value) {
                          if (value == null || value.trim().length < 10) {
                            return '10자 이상으로 감정을 나눠주세요.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '태그 & 추억',
                  subtitle: '관련 태그나 기억하고 싶은 내용을 추가하세요.',
                  icon: Icons.tag_outlined,
                  accentColor: AppPalette.accentGold,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _tagController,
                        label: '태그 (쉼표로 구분)',
                        hint: '예: 감사, 위로, 가족',
                        prefixIcon: const Icon(Icons.tag),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _memoryController,
                        label: '추억 메모 (선택)',
                        hint: '기억하고 싶은 문장이나 다짐을 남겨보세요.',
                        maxLines: 4,
                        prefixIcon: const Icon(Icons.bookmark_border),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  title: '공개 설정',
                  subtitle: '누구와 감정을 나누고 싶은지 선택하세요.',
                  icon: Icons.settings_outlined,
                  accentColor: AppPalette.accentLavender,
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
                        title: const Text('댓글 허용'),
                        subtitle:
                            const Text('다른 사용자가 응원 댓글을 남길 수 있도록 허용합니다.'),
                        value: _allowComments,
                        onChanged: (value) {
                          setState(() {
                            _allowComments = value;
                          });
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
                        label: '임시 저장',
                        leadingIcon: Icons.save_outlined,
                        onPressed: _handleDraftSave,
                        color: AppPalette.warmBrown,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPrimaryButton(
                        label: '감정 글 올리기',
                        icon: Icons.send_outlined,
                        onPressed: _handleSubmit,
                        accentColor: AppPalette.warmBrown,
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
        content: Text('임시 저장 기능은 준비 중입니다.'),
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
          '"${_titleController.text.trim()}" 감정 글이 등록되었습니다. 검토 후 공개됩니다.',
        ),
      ),
    );
    Navigator.pop(context);
  }
}

class _MoodSelector extends StatelessWidget {
  const _MoodSelector({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static const moods = [
    '감사',
    '위로',
    '그리움',
    '기쁨',
    '슬픔',
    '응원',
    '따뜻함',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: moods
          .map(
            (mood) => ChoiceChip(
              label: Text(mood),
              selected: value == mood,
              onSelected: (selected) {
                if (selected) onChanged(mood);
              },
              selectedColor: AppPalette.accentPink,
              labelStyle: TextStyle(
                color: value == mood ? Colors.white : AppPalette.warmBrown,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.white,
              side: BorderSide(
                color:
                    value == mood ? AppPalette.accentPink : AppPalette.warmBeige,
              ),
            ),
          )
          .toList(),
    );
  }
}

