import 'package:flutter/material.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class RegretLetterDetailScreen extends StatelessWidget {
  const RegretLetterDetailScreen({super.key, this.arguments});

  static const routeName = '/regret-letter/detail';

  final RegretLetterDetailArguments? arguments;

  @override
  Widget build(BuildContext context) {
    final letter =
        arguments ?? ModalRoute.of(context)?.settings.arguments as RegretLetterDetailArguments? ?? _sampleArguments;
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('후회 없는 편지'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.reply_outlined),
        label: const Text('공감 댓글 남기기'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('댓글 작성 기능은 추후 구현 예정입니다.'),
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: letter.title,
            subtitle:
                '${letter.author} · ${letter.relation} · ${letter.postedAgoLabel}',
            icon: Icons.mark_email_read_outlined,
            accentColor: letter.accentColor,
            titleColor: AppPalette.warmBrown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _LetterTagChip(
                      label: letter.memorialName,
                      icon: Icons.park_outlined,
                      color: AppPalette.accentGold,
                    ),
                    for (final category in letter.categories)
                      _LetterTagChip(
                        label: '#$category',
                        icon: Icons.sell_outlined,
                        color: letter.accentColor,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  letter.fullContent,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: AppPalette.ink,
                      ),
                ),
                if (letter.promiseNote?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: letter.accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: letter.accentColor.withOpacity(0.4),
                        width: 1.4,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.flag_outlined,
                            color: AppPalette.warmBrown.withOpacity(0.9)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            letter.promiseNote!,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      height: 1.6,
                                      fontWeight: FontWeight.w600,
                                      color: AppPalette.warmBrown,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildEngagementSection(context, letter),
          const SizedBox(height: 24),
          _buildCommunityNotes(context),
          const SizedBox(height: 24),
          _buildCommentPreview(context),
        ],
      ),
    );
  }

  Widget _buildEngagementSection(
    BuildContext context,
    RegretLetterDetailArguments letter,
  ) {
    return AppSurfaceCard(
      title: '공감과 응원',
      subtitle: '따뜻한 마음들이 모여 이 편지를 함께 지켜보고 있어요.',
      icon: Icons.favorite_outline,
      accentColor: AppPalette.accentPink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _LetterStatChip(
                icon: Icons.favorite_border,
                label: '공감',
                value: '${letter.likeCount}',
              ),
              _LetterStatChip(
                icon: Icons.mode_comment_outlined,
                label: '댓글',
                value: '${letter.commentCount}',
              ),
              _LetterStatChip(
                icon: Icons.ios_share_outlined,
                label: '공유',
                value: '${letter.shareCount}',
              ),
            ],
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 520;
              final buttons = [
                AppOutlinedButton(
                  label: '추모관으로 이동',
                  leadingIcon: Icons.travel_explore_outlined,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '"${letter.memorialName}" 추모관 이동은 준비 중입니다.',
                        ),
                      ),
                    );
                  },
                  color: AppPalette.warmBrown,
                ),
                AppPrimaryButton(
                  label: '이 편지에 공감하기',
                  icon: Icons.favorite,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('"${letter.title}" 편지에 공감했습니다.'),
                      ),
                    );
                  },
                  accentColor: AppPalette.accentPink,
                ),
              ];
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final button in buttons) ...[
                      button,
                      const SizedBox(height: 12),
                    ],
                  ],
                );
              }
              return Row(
                children: [
                  for (var i = 0; i < buttons.length; i++) ...[
                    Expanded(child: buttons[i]),
                    if (i != buttons.length - 1) const SizedBox(width: 12),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityNotes(BuildContext context) {
    return AppSurfaceCard(
      title: '관리자 안내',
      subtitle: '따뜻한 추모 문화를 위해 남겨드리는 안내입니다.',
      icon: Icons.info_outline,
      accentColor: AppPalette.accentGold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppHelperText(
            icon: Icons.verified_outlined,
            text: '등록된 편지는 운영팀 검토 후 공개되며, 민감한 표현은 비공개 처리될 수 있습니다.',
          ),
          SizedBox(height: 12),
          AppHelperText(
            icon: Icons.handshake_outlined,
            text: '댓글에서는 따뜻한 언어를 사용해 주세요. 위로와 공감의 마음을 나눠주세요.',
          ),
        ],
      ),
    );
  }

  Widget _buildCommentPreview(BuildContext context) {
    final sampleComments = [
      const _CommentPreview(
        author: '정수빈',
        relation: '동생',
        postedAgoLabel: '2시간 전',
        content: '글을 읽으니 눈물이 납니다. 용기 내어 마음을 전하신 모습이 참 아름답습니다.',
      ),
      const _CommentPreview(
        author: '한지민',
        relation: '기억의 정원 친구',
        postedAgoLabel: '어제',
        content: '저도 비슷한 후회를 가지고 있었는데 큰 위로가 되었습니다. 당신의 마음이 잘 전해졌을 거예요.',
      ),
    ];

    return AppSurfaceCard(
      title: '공감 댓글 미리 보기',
      subtitle: '비슷한 경험을 가진 분들의 응원 메시지가 도착했어요.',
      icon: Icons.chat_bubble_outline,
      accentColor: AppPalette.accentLavender,
      child: Column(
        children: [
          for (final comment in sampleComments) ...[
            _CommentBubble(comment: comment),
            const SizedBox(height: 12),
          ],
          AppTextField(
            label: '댓글 작성 (준비 중)',
            hint: '따뜻한 마음을 담아 응원 메시지를 남겨주세요.',
            maxLines: 3,
            enabled: false,
            prefixIcon: const Icon(Icons.lock_outline),
          ),
        ],
      ),
    );
  }
}

class _CommentPreview {
  const _CommentPreview({
    required this.author,
    required this.relation,
    required this.postedAgoLabel,
    required this.content,
  });

  final String author;
  final String relation;
  final String postedAgoLabel;
  final String content;
}

class _CommentBubble extends StatelessWidget {
  const _CommentBubble({required this.comment});

  final _CommentPreview comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppPalette.accentLavender.withOpacity(0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle,
                  color: AppPalette.accentLavender.withOpacity(0.8), size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppPalette.warmBrown,
                          ),
                    ),
                    Text(
                      '${comment.relation} · ${comment.postedAgoLabel}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppPalette.caption,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            comment.content,
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

class RegretLetterDetailArguments {
  const RegretLetterDetailArguments({
    required this.letterId,
    required this.title,
    required this.author,
    required this.relation,
    required this.postedAgoLabel,
    required this.memorialName,
    required this.fullContent,
    required this.categories,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    this.promiseNote,
    required this.accentColor,
  });

  final String letterId;
  final String title;
  final String author;
  final String relation;
  final String postedAgoLabel;
  final String memorialName;
  final String fullContent;
  final List<String> categories;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final String? promiseNote;
  final Color accentColor;
}

const _sampleArguments = RegretLetterDetailArguments(
  letterId: 'letter-sample',
  title: '샘플 편지 제목',
  author: '김예림',
  relation: '친구',
  postedAgoLabel: '1일 전',
  memorialName: '샘플 추모관',
  fullContent:
      '이 화면은 샘플 데이터로 표시되고 있습니다. 흐름 확인을 위해 추모관에서 연동된 편지 데이터를 전달하면 실제 편지가 보여집니다.',
  categories: ['샘플', '안내'],
  likeCount: 0,
  commentCount: 0,
  shareCount: 0,
  promiseNote: '공감 댓글과 공유 기능은 추후 연동됩니다.',
  accentColor: AppPalette.accentLavender,
);

class _LetterTagChip extends StatelessWidget {
  const _LetterTagChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.warmBrown,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _LetterStatChip extends StatelessWidget {
  const _LetterStatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppPalette.accentLavender.withOpacity(0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppPalette.accentLavender),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppPalette.warmBrown,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppPalette.caption,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

