import 'package:flutter/material.dart';

import 'package:free_board/screens/emotion_post_create_screen.dart';
import 'package:free_board/screens/prayer_request_create_screen.dart';
import 'package:free_board/screens/regret_letter_create_screen.dart';
import 'package:free_board/screens/memorial_letter_screen.dart';
import 'package:free_board/widgets/board/board_theme.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class BoardThemes {
  BoardThemes._();

  static final BoardThemeData emotion = BoardThemeData(
    boardId: 'emotion',
    displayName: '감정 공유',
    backgroundColor: AppPalette.softCream,
    appBarColor: AppPalette.warmBrown,
    appBarForegroundColor: Colors.white,
    introSection: BoardIntroSection(
      title: '지금 마음을 나눠요',
      subtitle: '감사, 그리움, 위로, 기쁨 등 다양한 감정을 공유할 수 있어요.',
      icon: Icons.favorite_outline,
      accentColor: AppPalette.accentPink,
      helperMessages: const [
        BoardHelperMessage(
          icon: Icons.info_outline,
          text: '누군가의 이야기가 또 다른 누군가에게 큰 위로가 됩니다. 부드러운 언어와 배려를 담아주세요.',
        ),
        BoardHelperMessage(
          icon: Icons.tips_and_updates_outlined,
          text: '욕설이나 비방, 개인정보가 포함된 글은 비공개 처리될 수 있습니다.',
        ),
      ],
    ),
    emptyState: const BoardEmptyState(
      title: '검색 결과가 없어요',
      subtitle: '조건을 조정하거나 다른 키워드로 다시 검색해보세요.',
      icon: Icons.sentiment_dissatisfied_outlined,
      accentColor: AppPalette.accentPink,
      helperMessages: const [
        BoardHelperMessage(
          icon: Icons.info_outline,
          text: '감정을 변경하거나 키워드를 줄이면 더 많은 글을 볼 수 있습니다.',
        ),
      ],
    ),
    actions: const BoardActionLabels(
      primaryCta: '댓글 보기',
      primaryIcon: Icons.forum_outlined,
      secondaryCta: '공감 남기기',
      secondaryIcon: Icons.favorite_border,
      reactionLabel: '공감',
    ),
    createAction: BoardCreateAction(
      routeName: EmotionPostCreateScreen.routeName,
      label: '감정 글 작성',
      icon: Icons.add_comment_outlined,
      accentColor: AppPalette.accentLavender,
    ),
    tagSection: const BoardTagSection(
      title: '주간 인기 태그',
      subtitle: '많이 공감받은 태그로 글을 찾아보세요.',
      icon: Icons.tag_outlined,
      accentColor: AppPalette.accentGold,
      tags: [
        '#가족',
        '#위로',
        '#감사',
        '#추억',
        '#새로운시작',
        '#기쁨',
        '#회복중',
      ],
    ),
    filterSection: const BoardFilterSection(
      title: '감정으로 찾아보기',
      subtitle: '공유하고 싶은 감정 키워드를 선택해보세요.',
      icon: Icons.filter_alt_outlined,
      accentColor: AppPalette.accentMint,
      filterLabels: [
        '전체',
        '감사',
        '그리움',
        '위로',
        '기쁨',
        '슬픔',
        '응원',
      ],
      searchLabel: '키워드 검색',
      searchHint: '예: 위로, 감사, #가족',
    ),
    createForm: const BoardCreateFormTheme(
      introSection: BoardIntroSection(
        title: '마음을 나눠요',
        subtitle: '지금 느끼는 감정을 솔직하게 표현해보세요.',
        icon: Icons.favorite_border,
        accentColor: AppPalette.accentPink,
        helperMessages: [
          BoardHelperMessage(
            icon: Icons.info_outline,
            text: '따뜻한 언어와 배려를 담아 적어주세요. 욕설이나 개인정보는 포함되지 않도록 주의해 주세요.',
          ),
          BoardHelperMessage(
            icon: Icons.tips_and_updates_outlined,
            text: '감정 공유 글은 검토 후 공개되며, 필요한 경우 비공개 처리될 수 있습니다.',
          ),
        ],
      ),
      moodOptions: [
        '감사',
        '위로',
        '그리움',
        '기쁨',
        '슬픔',
        '응원',
        '따뜻함',
      ],
      tagFieldLabel: '태그 (쉼표로 구분)',
      tagFieldHint: '예: 감사, 위로, 가족',
      memoryFieldHint: '기억하고 싶은 문장이나 다짐을 남겨보세요.',
    ),
    mediaRules: const BoardMediaRules(
      supportedTypes: ['사진', '동영상'],
      maxAttachments: 5,
      maxFileSizeMb: 80,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.photo_library_outlined,
          text: '사진과 동영상은 각각 최대 5개까지, 파일당 80MB 이내로 업로드할 수 있어요.',
        ),
        BoardHelperMessage(
          icon: Icons.shield_outlined,
          text: '타인의 얼굴이 포함된 경우 공개 범위를 가족으로 설정하는 것을 권장합니다.',
        ),
      ],
    ),
    statsConfig: BoardStatsConfig(
      title: '감정 활동 현황',
      subtitle: '이번 주 가장 많이 교류된 지표예요.',
      items: [
        BoardStatDefinition(
          id: 'likes',
          label: '공감',
          icon: Icons.favorite,
          accentColor: AppPalette.accentPink,
        ),
        BoardStatDefinition(
          id: 'comments',
          label: '댓글',
          icon: Icons.forum_outlined,
          accentColor: AppPalette.accentLavender,
        ),
        BoardStatDefinition(
          id: 'supports',
          label: '응원',
          icon: Icons.self_improvement_outlined,
          accentColor: AppPalette.accentMint,
        ),
      ],
    ),
  );

  static final BoardThemeData prayer = BoardThemeData(
    boardId: 'prayer',
    displayName: '기도',
    backgroundColor: AppPalette.softCream,
    appBarColor: AppPalette.warmBrown,
    appBarForegroundColor: Colors.white,
    introSection: const BoardIntroSection(
      title: '함께 기도해요',
      subtitle: '오늘 올라온 기도 제목과 응답 현황을 한눈에 확인하세요.',
      icon: Icons.volunteer_activism_outlined,
      accentColor: AppPalette.accentLavender,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.tips_and_updates_outlined,
          text: '기도 요청은 매일 오전 9시와 오후 9시에 새로고침됩니다.',
        ),
      ],
    ),
    emptyState: const BoardEmptyState(
      title: '찾는 기도가 없어요',
      subtitle: '카테고리나 검색 조건을 조정해 다시 시도해 보세요.',
      icon: Icons.self_improvement_outlined,
      accentColor: AppPalette.accentMint,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.info_outline,
          text: '응답 완료 숨기기를 끄거나 전체 카테고리를 선택하면 더 많은 기도 제목을 볼 수 있어요.',
        ),
      ],
    ),
    actions: const BoardActionLabels(
      primaryCta: '자세히 보기',
      primaryIcon: Icons.arrow_forward,
      secondaryCta: '기도로 응답하기',
      secondaryIcon: Icons.pan_tool_alt_outlined,
      reactionLabel: '기도 참여',
    ),
    createAction: BoardCreateAction(
      routeName: PrayerRequestCreateScreen.routeName,
      label: '기도 요청 작성',
      icon: Icons.edit_note,
      accentColor: AppPalette.accentLavender,
    ),
    filterSection: const BoardFilterSection(
      title: '찾고 있는 기도 요청이 있나요?',
      subtitle: '카테고리와 검색을 이용해 빠르게 찾아보세요.',
      icon: Icons.filter_alt_outlined,
      accentColor: AppPalette.accentMint,
      filterLabels: [
        '전체',
        '가족',
        '건강',
        '진로',
        '위로',
        '재정',
        '관계',
        '기타',
      ],
      searchLabel: '기도 제목 검색',
      searchHint: '예: 항암 치료, 회복, 진로',
    ),
    createForm: const BoardCreateFormTheme(
      introSection: BoardIntroSection(
        title: '기도 제목을 등록해요',
        subtitle: '함께 기도받고 싶은 내용을 작성해 주세요.',
        icon: Icons.volunteer_activism_outlined,
        accentColor: AppPalette.accentPink,
        helperMessages: [
          BoardHelperMessage(
            icon: Icons.info_outline,
            text: '민감한 개인정보는 포함하지 않도록 주의해 주세요. 기도 제목은 커뮤니티 검토 후 노출됩니다.',
          ),
          BoardHelperMessage(
            icon: Icons.check_circle_outline,
            text: '응답 내용은 추후 다시 들어와 기록할 수 있어요. 함께 기도하는 분들에게 큰 위로가 됩니다.',
          ),
        ],
      ),
      additionalMediaGuidelines: [
        BoardHelperMessage(
          icon: Icons.photo_library_outlined,
          text: '사진은 최대 3장, 영상은 1개까지 등록할 수 있어요.',
        ),
      ],
    ),
    mediaRules: const BoardMediaRules(
      supportedTypes: ['사진', '동영상'],
      maxAttachments: 3,
      maxFileSizeMb: 60,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.lock_person_outlined,
          text: '의료 기록 등 민감 정보는 업로드 시 자동으로 모자이크 처리됩니다.',
        ),
      ],
    ),
    statsConfig: BoardStatsConfig(
      title: '기도 활동 현황',
      subtitle: '오늘의 기도 움직임을 살펴보세요.',
      items: [
        BoardStatDefinition(
          id: 'today_count',
          label: '오늘 등록',
          icon: Icons.pending_actions_outlined,
          accentColor: AppPalette.accentPink,
        ),
        BoardStatDefinition(
          id: 'total_prayers',
          label: '누적 기도 참여',
          icon: Icons.self_improvement_outlined,
          accentColor: AppPalette.accentMint,
        ),
        BoardStatDefinition(
          id: 'answered',
          label: '응답된 기도',
          icon: Icons.celebration_outlined,
          accentColor: AppPalette.accentGold,
        ),
      ],
    ),
  );

  static final BoardThemeData regretLetter = BoardThemeData(
    boardId: 'regret_letter',
    displayName: '후회 없는 편지',
    backgroundColor: AppPalette.softCream,
    appBarColor: AppPalette.warmBrown,
    appBarForegroundColor: Colors.white,
    introSection: const BoardIntroSection(
      title: '전하지 못한 마음을 편지로 남겨요',
      subtitle: '후회 없는 편지는 고인에게 전하지 못했던 말들을 나누는 공간입니다.',
      icon: Icons.mark_email_read_outlined,
      accentColor: AppPalette.accentLavender,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.info_outline,
          text: '편지는 관리자 검토 후 공개되며, 민감한 개인정보는 비공개 처리됩니다.',
        ),
        BoardHelperMessage(
          icon: Icons.tips_and_updates_outlined,
          text: '편지를 작성하려면 먼저 추모관을 선택한 뒤 상세 화면에서 편지 작성 버튼을 눌러주세요.',
        ),
      ],
    ),
    emptyState: const BoardEmptyState(
      title: '편지를 찾을 수 없어요',
      subtitle: '다른 톤이나 추모관을 선택해보세요.',
      icon: Icons.mark_email_unread_outlined,
      accentColor: AppPalette.accentPink,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.info_outline,
          text: '추모관 상세 화면에서 편지를 작성하면 이곳에 공유됩니다.',
        ),
      ],
    ),
    actions: const BoardActionLabels(
      primaryCta: '편지 자세히 보기',
      primaryIcon: Icons.arrow_forward,
      secondaryCta: '추모관 살펴보기',
      secondaryIcon: Icons.travel_explore,
      reactionLabel: '공감',
    ),
    createAction: BoardCreateAction(
      routeName: RegretLetterCreateScreen.routeName,
      label: '편지 쓰기',
      icon: Icons.mail_outline,
      accentColor: AppPalette.warmBrown,
    ),
    filterSection: const BoardFilterSection(
      title: '편지 찾기',
      subtitle: '카테고리와 검색을 활용해 공감하고 싶은 편지를 찾아보세요.',
      icon: Icons.filter_alt_outlined,
      accentColor: AppPalette.accentMint,
      filterLabels: [
        '전체',
        '사과',
        '그리움',
        '감사',
        '사랑',
        '다짐',
      ],
      searchLabel: '편지 검색',
      searchHint: '예: 감사, 사과, 추억',
    ),
    createForm: const BoardCreateFormTheme(
      introSection: BoardIntroSection(
        title: '전하지 못한 마음을 편지로 남겨요',
        subtitle: '차분하게 마음을 정리하고 고인께 전하고 싶은 이야기를 작성해보세요.',
        icon: Icons.mark_email_read_outlined,
        accentColor: AppPalette.accentLavender,
        helperMessages: [
          BoardHelperMessage(
            icon: Icons.info_outline,
            text: '편지는 관리자 검토 후 공개되며, 민감한 개인정보는 자동으로 가려집니다.',
          ),
          BoardHelperMessage(
            icon: Icons.tips_and_updates_outlined,
            text: '추모관을 선택하면 관련 정보가 자동으로 연결돼요.',
          ),
        ],
      ),
      additionalMediaGuidelines: [
        BoardHelperMessage(
          icon: Icons.color_lens_outlined,
          text: '편지 톤을 선택하면 목록에서 비슷한 편지를 빠르게 찾을 수 있어요.',
        ),
      ],
    ),
    mediaRules: const BoardMediaRules(
      supportedTypes: ['사진', '음성 편지', '영상'],
      maxAttachments: 4,
      maxFileSizeMb: 120,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.photo_outlined,
          text: '사진과 영상은 편지 하단의 추억 갤러리에 노출됩니다.',
        ),
        BoardHelperMessage(
          icon: Icons.mic_none_outlined,
          text: '음성 편지를 업로드하면 자동으로 텍스트로 전사돼요.',
        ),
      ],
    ),
    statsConfig: BoardStatsConfig(
      title: '편지 참여 현황',
      subtitle: '이번 주 가장 많은 공감을 받은 지표예요.',
      items: [
        BoardStatDefinition(
          id: 'letters',
          label: '등록된 편지',
          icon: Icons.mail_outline,
          accentColor: AppPalette.accentLavender,
        ),
        BoardStatDefinition(
          id: 'likes',
          label: '공감 수',
          icon: Icons.favorite_border,
          accentColor: AppPalette.accentPink,
        ),
        BoardStatDefinition(
          id: 'promises',
          label: '약속 노트',
          icon: Icons.sticky_note_2_outlined,
          accentColor: AppPalette.accentGold,
        ),
      ],
    ),
  );

  static final BoardThemeData memorial = BoardThemeData(
    boardId: 'memorial',
    displayName: '추모관',
    backgroundColor: AppPalette.softCream,
    appBarColor: AppPalette.warmBrown,
    appBarForegroundColor: Colors.white,
    introSection: const BoardIntroSection(
      title: '내 추모관 현황',
      subtitle: '필터와 검색을 활용해 추억을 빠르게 찾아보세요.',
      icon: Icons.auto_awesome,
      accentColor: AppPalette.warmBrown,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.calendar_today_outlined,
          text: '다가오는 기념일과 최근 업데이트된 추모관을 상단에서 바로 확인할 수 있어요.',
        ),
      ],
    ),
    emptyState: const BoardEmptyState(
      title: '추모관이 아직 없어요',
      subtitle: '새 추모관을 만들고 소중한 추억을 기록해보세요.',
      icon: Icons.park_outlined,
      accentColor: AppPalette.accentMint,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.tips_and_updates_outlined,
          text: '추모관을 만들면 사진, 영상, 편지, 방명록을 한곳에 모을 수 있습니다.',
        ),
      ],
    ),
    actions: const BoardActionLabels(
      primaryCta: '추모관 들어가기',
      primaryIcon: Icons.arrow_forward,
      secondaryCta: '즐겨찾기',
      secondaryIcon: Icons.favorite_border,
      reactionLabel: '헌화',
    ),
    createAction: const BoardCreateAction(
      routeName: MemorialLetterScreen.routeName,
      label: '새 추모관 만들기',
      icon: Icons.add,
      accentColor: AppPalette.warmBrown,
    ),
    filterSection: const BoardFilterSection(
      title: '추모관 찾기',
      subtitle: '필터와 검색으로 보고 싶은 추모관을 찾아보세요.',
      icon: Icons.filter_alt_outlined,
      accentColor: AppPalette.accentLavender,
      filterLabels: [
        '전체',
        '가족',
        '친구',
        '반려동물',
        '추억',
      ],
      searchLabel: '추모관 검색',
      searchHint: '예: 이름, 관계, 태그',
    ),
    mediaRules: const BoardMediaRules(
      supportedTypes: ['사진', '동영상', '음성', '문서'],
      maxAttachments: 20,
      maxFileSizeMb: 200,
      helperMessages: [
        BoardHelperMessage(
          icon: Icons.cloud_upload_outlined,
          text: '대용량 미디어는 업로드 후 자동으로 최적화되며 원본은 안전하게 보관됩니다.',
        ),
        BoardHelperMessage(
          icon: Icons.group_outlined,
          text: '가족 초대 기능을 사용하면 함께 추억을 관리할 수 있어요.',
        ),
      ],
    ),
    statsConfig: BoardStatsConfig(
      title: '추모관 활동 현황',
      subtitle: '최근 7일 기준으로 집계됩니다.',
      items: [
        BoardStatDefinition(
          id: 'visits',
          label: '방문 수',
          icon: Icons.trending_up,
          accentColor: AppPalette.accentGold,
        ),
        BoardStatDefinition(
          id: 'letters',
          label: '편지 수',
          icon: Icons.mail_outline,
          accentColor: AppPalette.accentLavender,
        ),
        BoardStatDefinition(
          id: 'media',
          label: '추억 콘텐츠',
          icon: Icons.collections_bookmark_outlined,
          accentColor: AppPalette.accentMint,
        ),
      ],
    ),
  );
}


