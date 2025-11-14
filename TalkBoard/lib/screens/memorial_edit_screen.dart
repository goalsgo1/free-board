import 'package:flutter/material.dart';

import 'package:free_board/providers/auth_provider.dart';
import 'package:free_board/providers/memorial_provider.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:provider/provider.dart';

class MemorialEditScreen extends StatefulWidget {
  const MemorialEditScreen({super.key});

  @override
  State<MemorialEditScreen> createState() => _MemorialEditScreenState();
}

class MemorialEditArguments {
  const MemorialEditArguments({this.memorialId, this.initialName});

  final String? memorialId;
  final String? initialName;

  bool get isEdit => memorialId != null;
}

class _MemorialEditScreenState extends State<MemorialEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _relationController;
  late final TextEditingController _storyController;
  late final TextEditingController _anniversaryController;
  late final TextEditingController _notesController;
  bool _isPublic = true;
  bool _allowComments = true;
  bool _allowSharing = true;
  bool _initializedFromArgs = false;
  DateTime? _selectedAnniversary;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _relationController = TextEditingController();
    _storyController = TextEditingController();
    _anniversaryController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initializedFromArgs) return;

    final args =
        ModalRoute.of(context)?.settings.arguments as MemorialEditArguments?;

    if (args?.initialName != null && args!.initialName!.isNotEmpty) {
      _nameController.text = args.initialName!;
    }

    if (args?.isEdit == true && args!.memorialId != null) {
      final memorial =
          context.read<MemorialProvider>().findById(args.memorialId!);
      if (memorial != null) {
        _nameController.text = memorial.name;
        _relationController.text = memorial.relation ?? '';
        _storyController.text = memorial.story ?? '';
        _anniversaryController.text = memorial.anniversaryLabel ?? '';
        _notesController.text = memorial.notes ?? '';
        _isPublic = memorial.isPublic;
        _allowComments = memorial.allowComments;
        _allowSharing = memorial.allowSharing;
      }
    }

    _initializedFromArgs = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationController.dispose();
    _storyController.dispose();
    _anniversaryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as MemorialEditArguments?;
    final bool isEdit = args?.isEdit ?? false;
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: Text(isEdit ? '추모관 수정' : '새 추모관 만들기'),
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
            children: const [
              _BasicInfoSection(),
              SizedBox(height: 20),
              _MemorialMetaSection(),
              SizedBox(height: 20),
              _PrivacySection(),
              SizedBox(height: 20),
              _MediaSection(),
              SizedBox(height: 20),
              _NotesSection(),
              SizedBox(height: 24),
              _SaveButtonRow(),
            ],
          ),
        ),
      ),
    );
  }

  void updateIsPublic(bool value) {
    setState(() {
      _isPublic = value;
    });
  }

  void updateAllowComments(bool value) {
    setState(() {
      _allowComments = value;
    });
  }

  void updateAllowSharing(bool value) {
    setState(() {
      _allowSharing = value;
    });
  }

  Future<void> handleSave(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('필수 항목을 확인해 주세요.')),
      );
      return;
    }

    final memorialProvider = context.read<MemorialProvider>();
    final authProvider = context.read<AuthProvider>();

    final name = _nameController.text.trim();
    final relation = _relationController.text.trim();
    final story = _storyController.text.trim();
    final anniversary = _anniversaryController.text.trim();
    final notes = _notesController.text.trim();
    final createdBy = authProvider.currentUserId ?? 'anonymous';

    final categories = _deriveCategories(relation);
    final tags = _buildTags(
      isPublic: _isPublic,
      allowComments: _allowComments,
      allowSharing: _allowSharing,
      anniversary: anniversary,
      relation: relation,
    );

    final heroImageUrl = _heroImageUrlSeed(name, anniversary);

    final success = await memorialProvider.createMemorial(
      name: name,
      createdBy: createdBy,
      relation: relation.isEmpty ? null : relation,
      story: story,
      anniversaryLabel: anniversary.isEmpty ? null : anniversary,
      notes: notes.isEmpty ? null : notes,
      isPublic: _isPublic,
      allowComments: _allowComments,
      allowSharing: _allowSharing,
      categories: categories,
      tags: tags,
      heroImageUrl: heroImageUrl,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('새 추모관이 생성되었습니다.')),
      );
      Navigator.pop(context, true);
    } else {
      final errorMessage =
          memorialProvider.errorMessage ?? '추모관 생성 중 오류가 발생했습니다.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  List<String> _deriveCategories(String relation) {
    final normalized = relation.toLowerCase();
    if (normalized.contains('반려')) {
      return const ['반려동물'];
    }
    if (normalized.contains('어머니') ||
        normalized.contains('아버지') ||
        normalized.contains('가족') ||
        normalized.contains('형') ||
        normalized.contains('누나') ||
        normalized.contains('언니') ||
        normalized.contains('오빠') ||
        normalized.contains('동생') ||
        normalized.contains('자녀') ||
        normalized.contains('부모')) {
      return const ['가족'];
    }
    if (normalized.contains('친구') || normalized.contains('동기')) {
      return const ['친구'];
    }
    if (normalized.contains('선생') || normalized.contains('교수')) {
      return const ['스승'];
    }
    if (normalized.isEmpty) {
      return const ['기타'];
    }
    return const ['기타'];
  }

  List<String> _buildTags({
    required bool isPublic,
    required bool allowComments,
    required bool allowSharing,
    required String anniversary,
    required String relation,
  }) {
    final tags = <String>[
      isPublic ? '공개 추모관' : '비공개 추모관',
      allowComments ? '편지 허용' : '편지 제한',
      allowSharing ? '공유 허용' : '공유 제한',
    ];
    if (anniversary.trim().isNotEmpty) {
      tags.add('기념일 $anniversary');
    }
    if (relation.trim().isNotEmpty) {
      tags.add(relation.trim());
    }
    return tags;
  }

  String _heroImageUrlSeed(String name, String anniversary) {
    final seed =
        '${name.trim()}-${anniversary.trim()}-${DateTime.now().millisecondsSinceEpoch}';
    return 'https://picsum.photos/seed/${Uri.encodeComponent(seed)}/720/420';
  }
}

class _BasicInfoSection extends StatelessWidget {
  const _BasicInfoSection();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MemorialEditScreenState>()!;
    return AppSurfaceCard(
      title: '기본 정보',
      subtitle: '추모할 분의 이름과 관계를 입력해주세요.',
      icon: Icons.person_outline,
      accentColor: AppPalette.accentMint,
      child: Column(
        children: [
          AppTextField(
            controller: state._nameController,
            label: '추모 대상 이름',
            hint: '예: 박정윤',
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.badge_outlined),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '이름을 입력해주세요.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: state._relationController,
            label: '관계',
            hint: '예: 어머니, 친구, 반려동물 등',
            prefixIcon: const Icon(Icons.diversity_3_outlined),
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: state._anniversaryController,
            label: '기념일',
            hint: '예: 2024년 3월 15일',
            prefixIcon: const Icon(Icons.event_outlined),
            readOnly: true,
            onTap: () => _showDatePicker(context, state),
          ),
        ],
      ),
    );
  }
}

Future<void> _showDatePicker(
    BuildContext context, _MemorialEditScreenState state) async {
  final now = DateTime.now();
  final initialDate = state._selectedAnniversary ?? now;
  final firstDate = DateTime(1900);
  final lastDate = DateTime(now.year + 50);

  final picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    locale: const Locale('ko', 'KR'),
    helpText: '기념일 선택',
    cancelText: '취소',
    confirmText: '선택',
    fieldHintText: '예: 2024년 3월 15일',
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppPalette.warmBrown,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppPalette.ink,
              ),
        ),
        child: child ?? const SizedBox.shrink(),
      );
    },
  );

  if (picked != null) {
    state.setState(() {
      state._selectedAnniversary = picked;
      state._anniversaryController.text =
          '${picked.year}년 ${picked.month}월 ${picked.day}일';
    });
  }
}

class _MemorialMetaSection extends StatelessWidget {
  const _MemorialMetaSection();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MemorialEditScreenState>()!;
    return AppSurfaceCard(
      title: '추억 소개',
      subtitle: '추모관을 소개하는 이야기를 작성해주세요.',
      icon: Icons.menu_book_outlined,
      accentColor: AppPalette.accentLavender,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: state._storyController,
            label: '소개 문구',
            hint: '소중한 추억을 간단히 소개해주세요.',
            prefixIcon: const Icon(Icons.chat_bubble_outline),
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '소개 문구를 입력해주세요.';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          AppHelperText(
            icon: Icons.info_outline,
            text: '소개 문구는 추모관 목록과 공유 링크에서 함께 표시됩니다.',
          ),
        ],
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MemorialEditScreenState>()!;
    return AppSurfaceCard(
      title: '공개 범위 설정',
      subtitle: '추모관을 함께 나눌 사람들을 선택해주세요.',
      icon: Icons.lock_open_outlined,
      accentColor: AppPalette.accentGold,
      child: Column(
        children: [
          SwitchListTile.adaptive(
            title: const Text('공개 추모관으로 설정'),
            subtitle: const Text('누구나 검색하고 방문할 수 있습니다.'),
            value: state._isPublic,
            onChanged: state.updateIsPublic,
          ),
          const Divider(),
          SwitchListTile.adaptive(
            title: const Text('편지/댓글 작성 허용'),
            subtitle: const Text('방문자가 위로의 말을 남길 수 있습니다.'),
            value: state._allowComments,
            onChanged: state.updateAllowComments,
          ),
          SwitchListTile.adaptive(
            title: const Text('추모관 공유 허용'),
            subtitle: const Text('링크를 통해 다른 분들에게 추모관을 공유합니다.'),
            value: state._allowSharing,
            onChanged: state.updateAllowSharing,
          ),
        ],
      ),
    );
  }
}

class _MediaSection extends StatelessWidget {
  const _MediaSection();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '사진 및 콘텐츠',
      subtitle: '추억을 생생하게 담을 사진, 영상, 음성 메시지를 추가하세요.',
      icon: Icons.photo_camera_back_outlined,
      accentColor: AppPalette.accentPink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.photo_outlined),
                label: const Text('사진 추가'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.video_file_outlined),
                label: const Text('영상 추가'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mic_none_outlined),
                label: const Text('음성 메시지 추가'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppPalette.warmBeige, width: 1.3),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '업로드 가이드',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppPalette.warmBrown,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '· 사진은 최대 100장까지 올릴 수 있으며, 권장 해상도는 1080px 이상입니다.\n· 영상은 200MB 이하, 최대 5개까지 업로드 가능합니다.\n· 음성 메시지는 3분 이내 녹음 파일을 지원합니다.',
                  style: TextStyle(
                    height: 1.5,
                    color: AppPalette.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesSection extends StatelessWidget {
  const _NotesSection();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MemorialEditScreenState>()!;
    return AppSurfaceCard(
      title: '추가 메모',
      subtitle: '가족분들과 공유하고 싶은 상세 내용을 적어보세요.',
      icon: Icons.notes_outlined,
      accentColor: AppPalette.warmBrown,
      child: AppTextField(
        controller: state._notesController,
        label: '메모',
        hint: '예: 기념일에 준비할 꽃과 음악, 전하고 싶은 메시지 등',
        maxLines: 4,
        prefixIcon: const Icon(Icons.edit_note_outlined),
      ),
    );
  }
}

class _SaveButtonRow extends StatelessWidget {
  const _SaveButtonRow();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MemorialEditScreenState>()!;
    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            label: '임시 저장',
            leadingIcon: Icons.save_outlined,
            badgeText: '준비 중',
            onPressed: () {
              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('임시 저장 기능은 준비 중입니다.')),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Consumer<MemorialProvider>(
            builder: (context, provider, _) {
              return AppPrimaryButton(
                label: '추모관 저장하기',
                icon: Icons.check_circle_outline,
                isLoading: provider.isSubmitting,
                onPressed: provider.isSubmitting
                    ? null
                    : () => state.handleSave(context),
              );
            },
          ),
        ),
      ],
    );
  }
}
