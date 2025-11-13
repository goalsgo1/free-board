import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  static const routeName = '/profile-edit';

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: '임다은');
  final TextEditingController _nicknameController =
      TextEditingController(text: '기억을모으는사람');
  final TextEditingController _emailController =
      TextEditingController(text: 'remember@example.com');
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController(
    text: '엄마와의 추억을 기록하며, 나와 같은 경험을 가진 사람들과 위로를 나누고 싶습니다.',
  );
  final TextEditingController _memorialFocusController = TextEditingController(
    text: '추억 앨범 정리, AI 기억 답장, 감사 혜택 참여',
  );
  bool _showPublicProfile = true;
  bool _allowTimelineTagging = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _introductionController.dispose();
    _memorialFocusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('정보 수정'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.mypage),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              AppSurfaceCard(
                title: '기본 정보',
                subtitle: '실명과 연락처는 관리자 검토 목적 외에는 공개되지 않습니다.',
                icon: Icons.person_outline,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _nameController,
                      label: '이름',
                      hint: '예: 임다은',
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
                      controller: _nicknameController,
                      label: '닉네임',
                      hint: '커뮤니티에 표시될 이름을 입력하세요.',
                      prefixIcon: const Icon(Icons.person_pin_circle_outlined),
                      validator: (value) {
                        if (value == null || value.trim().length < 2) {
                          return '2자 이상의 닉네임을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _emailController,
                      label: '이메일',
                      hint: '예: remember@example.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '이메일을 입력해주세요.';
                        }
                        if (!value.contains('@')) {
                          return '올바른 이메일 주소를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _phoneController,
                      label: '연락처 (선택)',
                      hint: '하이픈 없이 숫자만 입력',
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '프로필 소개',
                subtitle: '다른 이웃들에게 어떤 사람인지 소개하고 싶은 내용을 적어주세요.',
                icon: Icons.menu_book_outlined,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _introductionController,
                      label: '자기소개',
                      hint: '추모 여정이나 커뮤니티 활동 계획을 자유롭게 남겨주세요.',
                      prefixIcon: const Icon(Icons.article_outlined),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _memorialFocusController,
                      label: '요즘 집중하는 추모 활동',
                      hint: '예: 추억 앨범 정리, 기념일 식사 준비',
                      prefixIcon: const Icon(Icons.star_outline),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '공개 설정',
                subtitle: '어떤 정보까지 커뮤니티와 공유할지 선택할 수 있어요.',
                icon: Icons.lock_open_outlined,
                child: Column(
                  children: [
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('프로필을 커뮤니티에 공개'),
                      subtitle: const Text('비활성화하면 추모 친구에게만 프로필이 노출됩니다.'),
                      value: _showPublicProfile,
                      onChanged: (value) => setState(() => _showPublicProfile = value),
                      activeColor: Colors.black,
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('타임라인에서 태그 허용'),
                      subtitle: const Text('친구가 추모 타임라인에 나를 태그할 수 있습니다.'),
                      value: _allowTimelineTagging,
                      onChanged: (value) => setState(() => _allowTimelineTagging = value),
                      activeColor: Colors.black,
                    ),
                    const SizedBox(height: 8),
                    AppHelperText(
                      icon: Icons.info_outline,
                      text: _showPublicProfile
                          ? '프로필을 공개하면 상호 위로 매칭 추천에도 도움이 됩니다.'
                          : '현재는 추모 친구에게만 프로필이 보여집니다.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '보안 확인',
                subtitle: '개인 정보를 안전하게 보호하기 위해 확인 절차를 안내합니다.',
                icon: Icons.security_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    AppHelperText(
                      icon: Icons.lock_outline,
                      text: '민감 정보는 모두 암호화되어 저장되며, 관리자 외에는 열람할 수 없습니다.',
                    ),
                    SizedBox(height: 8),
                    AppHelperText(
                      icon: Icons.verified_user_outlined,
                      text: '정보 변경 내역은 30일간 기록되며, 요청 시 복구를 도와드립니다.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: AppOutlinedButton(
                      label: '변경 취소',
                      leadingIcon: Icons.close,
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      label: '변경 내용 저장',
                      icon: Icons.save_outlined,
                      onPressed: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('필수 항목을 확인해 주세요.')),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('프로필이 임시 저장되었습니다. 검토 후 반영됩니다.')),
                        );
                        Navigator.pop(context, true);
                      },
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
}
