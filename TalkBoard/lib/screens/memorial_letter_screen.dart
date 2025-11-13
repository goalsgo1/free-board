import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class MemorialLetterScreen extends StatefulWidget {
  const MemorialLetterScreen({super.key});

  static const routeName = '/memorial-letter';

  @override
  State<MemorialLetterScreen> createState() => _MemorialLetterScreenState();
}

class _MemorialLetterScreenState extends State<MemorialLetterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _authorController;
  late final TextEditingController _relationController;
  late final TextEditingController _contentController;
  bool _sharePublicly = true;

  @override
  void initState() {
    super.initState();
    _authorController = TextEditingController();
    _relationController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _authorController.dispose();
    _relationController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as MemorialLetterArguments?;
    final data = args ?? const MemorialLetterArguments.sample();

    _authorController.text = _authorController.text.isEmpty
        ? data.defaultAuthor ?? ''
        : _authorController.text;
    _relationController.text = _relationController.text.isEmpty
        ? data.defaultRelation ?? ''
        : _relationController.text;

    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: Text('${data.memorialName} 편지 작성'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSurfaceCard(
                title: '편지 작성',
                subtitle: '따뜻한 마음을 담아 편지를 작성해주세요.',
                icon: Icons.edit_note_outlined,
                accentColor: AppPalette.accentPink,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _authorController,
                      label: '작성자 이름',
                      hint: '예: 장진영',
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '작성자 이름을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _relationController,
                      label: '관계',
                      hint: '예: 장남, 친구, 이웃',
                      prefixIcon: const Icon(Icons.diversity_3_outlined),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _contentController,
                      label: '편지 내용',
                      hint: '전하고 싶은 마음을 적어주세요.',
                      maxLines: 6,
                      prefixIcon: const Icon(Icons.chat_bubble_outline),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '편지 내용을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '공개 설정',
                subtitle: '편지를 누구와 공유할지 선택하세요.',
                icon: Icons.lock_open_outlined,
                accentColor: AppPalette.accentMint,
                child: SwitchListTile.adaptive(
                  title: const Text('공개 편지로 등록'),
                  subtitle:
                      const Text('공개 시 추모관 방문자에게 편지가 노출됩니다.'),
                  value: _sharePublicly,
                  onChanged: (value) => setState(() {
                    _sharePublicly = value;
                  }),
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '미리보기',
                subtitle: '편지가 방문자에게 이렇게 보여집니다.',
                icon: Icons.visibility_outlined,
                accentColor: AppPalette.warmBrown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite,
                            color: AppPalette.accentPink),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${_authorController.text.isEmpty ? data.defaultAuthor ?? '작성자' : _authorController.text} · ${_relationController.text.isEmpty ? data.defaultRelation ?? '가족' : _relationController.text}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppPalette.warmBrown,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _contentController.text.isEmpty
                          ? '작성 중인 편지가 이곳에 미리보기로 표시됩니다.'
                          : _contentController.text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                            color: AppPalette.ink,
                          ),
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
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      label: '편지 등록하기',
                      icon: Icons.send_outlined,
                      onPressed: _handleSubmit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
      const SnackBar(
        content: Text('추모 편지가 등록되었습니다. 검토 후 공개됩니다.'),
      ),
    );
    Navigator.pop(context);
  }
}

class MemorialLetterArguments {
  const MemorialLetterArguments({
    required this.memorialId,
    required this.memorialName,
    this.defaultAuthor,
    this.defaultRelation,
  });

  const MemorialLetterArguments.sample()
      : memorialId = 'memorial-001',
        memorialName = '박정윤님 추모관',
        defaultAuthor = '장진영',
        defaultRelation = '장남';

  final String memorialId;
  final String memorialName;
  final String? defaultAuthor;
  final String? defaultRelation;
}
