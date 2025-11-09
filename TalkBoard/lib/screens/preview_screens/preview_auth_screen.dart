import 'package:flutter/material.dart';

import 'widgets/preview_auth_components.dart';

class PreviewAuthScreen extends StatelessWidget {
  const PreviewAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color loginAccent = PreviewPalette.warmBrown;
    const Color signUpAccent = Color(0xFFF06292);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '로그인 / 회원가입 프리뷰',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        backgroundColor: PreviewPalette.warmBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: PreviewPalette.softCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth >= 960;
            final double itemWidth = isWide
                ? (constraints.maxWidth - 20) / 2
                : constraints.maxWidth;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewCard(),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    SizedBox(
                      width: itemWidth,
                      child: PreviewFormCard(
                        icon: Icons.login_rounded,
                        title: '로그인 화면',
                        subtitle:
                            '기존 사용자가 이메일과 비밀번호로 빠르게 입장할 수 있는 화면입니다. 보조 행동으로 비밀번호 재설정과 이메일 인증 재발송, 소셜 로그인을 제공합니다.',
                        accentColor: loginAccent,
                        children: const [
                          PreviewInputRow(
                            icon: Icons.email_outlined,
                            label: '이메일',
                            hint: 'example@email.com',
                          ),
                          PreviewInputRow(
                            icon: Icons.lock_outline,
                            label: '비밀번호',
                            hint: '••••••••',
                            isSensitive: true,
                          ),
                          SizedBox(height: 12),
                          PreviewPrimaryButton(
                            label: '로그인',
                            accentColor: loginAccent,
                          ),
                          SizedBox(height: 16),
                          PreviewHelperText(
                            icon: Icons.lock_reset,
                            text:
                                '하단 보조 버튼으로 비밀번호 재설정 다이얼로그를 호출하고, 입력 이메일로 재설정 링크를 전송합니다.',
                          ),
                          PreviewHelperText(
                            icon: Icons.mark_email_unread_outlined,
                            text:
                                '인증되지 않은 계정은 로그인 후 이메일 인증 안내와 재발송 버튼을 노출합니다.',
                          ),
                          SizedBox(height: 18),
                          PreviewOutlinedButton(
                            label: 'Google로 계속하기',
                            icon: Icons.g_mobiledata,
                            badge: '준비 중',
                          ),
                          PreviewOutlinedButton(
                            label: 'Apple로 계속하기',
                            icon: Icons.apple,
                            badge: '준비 중',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: PreviewFormCard(
                        icon: Icons.person_add_alt_1,
                        title: '회원가입 화면',
                        subtitle:
                            '기본 프로필과 약관 동의를 입력받아 신규 계정을 생성합니다. 가입 완료 즉시 이메일 인증 메일을 전송하고, 안내 스낵바를 노출합니다.',
                        accentColor: signUpAccent,
                        children: const [
                          PreviewInputRow(
                            icon: Icons.person_outline,
                            label: '닉네임',
                            hint: '기억지기 / 우리 가족',
                          ),
                          PreviewInputRow(
                            icon: Icons.email_outlined,
                            label: '이메일',
                            hint: '가입할 이메일 주소',
                          ),
                          PreviewInputRow(
                            icon: Icons.lock_outline,
                            label: '비밀번호',
                            hint: '영문 + 숫자 조합 6자 이상',
                            isSensitive: true,
                          ),
                          PreviewInputRow(
                            icon: Icons.lock_outline,
                            label: '비밀번호 확인',
                            hint: '동일한 비밀번호를 다시 입력',
                            isSensitive: true,
                          ),
                          SizedBox(height: 12),
                          PreviewChecklist(
                            items: [
                              '필수 약관 2종(서비스 이용 약관, 개인정보 처리방침) 동의',
                              '선택 약관(마케팅 수신)은 토글 스위치로 분리',
                              '회원가입 버튼 활성화 조건: 필수 필드 + 필수 약관 동의 완료',
                            ],
                          ),
                          SizedBox(height: 16),
                          PreviewPrimaryButton(
                            label: '회원가입',
                            accentColor: signUpAccent,
                          ),
                          SizedBox(height: 16),
                          PreviewHelperText(
                            icon: Icons.mark_email_read_outlined,
                            text:
                                '가입 직후 Firebase Auth 이메일 인증 메일 전송 → 인증 완료 시까지 전체 기능 일부 제약',
                          ),
                          PreviewHelperText(
                            icon: Icons.info_outline,
                            text:
                                '회원가입 완료 스낵바: "이메일 인증 메일을 확인해주세요." 문구와 파스텔 그린 배경',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildFlowSummary(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PreviewPalette.warmBeige,
            PreviewPalette.warmBeige.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PreviewPalette.warmBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: PreviewPalette.warmBrown.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '로그인 · 회원가입 화면 개요',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PreviewPalette.warmBrown,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '기억의 정원 전체 디자인 시스템(각지고 무거운 테두리, 파스텔 톤 배경, 그림자)을 그대로 적용했습니다. '
            '실제 기능 구현과 분리된 프리뷰 화면으로, 기획 검토 및 디자인 조율에 활용할 수 있습니다.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Color(0xFF5C5C5C),
            ),
          ),
          SizedBox(height: 12),
          PreviewHelperText(
            icon: Icons.tips_and_updates_outlined,
            text:
                '공통 컴포넌트(폼 필드, 주요 버튼, 체크리스트, 소셜 버튼)를 별도 위젯으로 구성해 다른 프리뷰 화면에서도 재사용할 수 있습니다.',
          ),
        ],
      ),
    );
  }

  Widget _buildFlowSummary() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: PreviewPalette.warmBeige, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '사용자 여정 요약',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PreviewPalette.warmBrown,
            ),
          ),
          SizedBox(height: 12),
          PreviewChecklist(
            items: [
              '로그인 시 이메일 인증 여부를 확인하고, 미완료 계정은 오렌지 스낵바로 안내',
              '비밀번호 재설정 버튼을 통해 이메일 입력 다이얼로그 → Firebase Auth reset 메일 전송',
              '회원가입 직후 이메일 인증 메일 자동 발송 + 완료 전까지 일부 기능 제한 공지',
              '소셜 로그인 버튼은 추후 구현을 대비해 UI/UX 위치 및 스타일만 선반영',
            ],
          ),
        ],
      ),
    );
  }
}


