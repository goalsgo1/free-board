import 'package:flutter/material.dart';

/// Central configuration for a discussion board surface. Each themed board
/// (예: 기도, 감정공유, 후회 없는 편지, 추모관) can provide its own copy tone,
/// 색상, 아이콘, 버튼 라벨 등을 정의해 공통 레이아웃 위에 감정선을 부여합니다.
class BoardThemeData {
  const BoardThemeData({
    required this.boardId,
    required this.displayName,
    required this.backgroundColor,
    required this.appBarColor,
    required this.appBarForegroundColor,
    required this.introSection,
    required this.emptyState,
    required this.actions,
    required this.createAction,
    this.tagSection,
    this.filterSection,
    this.createForm,
    this.mediaRules,
    this.statsConfig,
  });

  /// 내부 식별자 (예: `emotion`, `prayer`, `regret_letter`)
  final String boardId;

  /// 앱바와 FAB 등에 노출되는 보드명.
  final String displayName;

  /// Scaffold 배경색.
  final Color backgroundColor;

  /// AppBar 배경색.
  final Color appBarColor;

  /// AppBar 전경색 (text/icon).
  final Color appBarForegroundColor;

  /// 상단 안내 카드 구성.
  final BoardIntroSection introSection;

  /// 게시물이 없을 때 보여줄 상태 카드 구성.
  final BoardEmptyState emptyState;

  /// 리스트 하단 버튼/리액션 등 라벨 구성.
  final BoardActionLabels actions;

  /// FAB 및 작성 흐름 관련 라벨/아이콘/라우트 구성.
  final BoardCreateAction createAction;

  /// 주간 태그, 카테고리 등 보조 섹션 정보 (선택).
  final BoardTagSection? tagSection;

  /// 검색/필터 카드 구성 (선택).
  final BoardFilterSection? filterSection;

  /// 작성 화면 구성 정보 (선택).
  final BoardCreateFormTheme? createForm;

  /// 미디어 업로드 관련 안내 및 제한.
  final BoardMediaRules? mediaRules;

  /// 보드 통계/지표 구성.
  final BoardStatsConfig? statsConfig;
}

class BoardIntroSection {
  const BoardIntroSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    this.helperMessages = const [],
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final List<BoardHelperMessage> helperMessages;
}

class BoardHelperMessage {
  const BoardHelperMessage({
    required this.text,
    this.icon = Icons.info_outline,
  });

  final String text;
  final IconData icon;
}

class BoardEmptyState {
  const BoardEmptyState({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    this.helperMessages = const [],
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final List<BoardHelperMessage> helperMessages;
}

class BoardActionLabels {
  const BoardActionLabels({
    required this.primaryCta,
    required this.primaryIcon,
    required this.secondaryCta,
    required this.secondaryIcon,
    required this.reactionLabel,
  });

  final String primaryCta;
  final IconData primaryIcon;
  final String secondaryCta;
  final IconData secondaryIcon;
  final String reactionLabel;
}

class BoardCreateAction {
  const BoardCreateAction({
    required this.routeName,
    required this.label,
    required this.icon,
    required this.accentColor,
  });

  final String routeName;
  final String label;
  final IconData icon;
  final Color accentColor;
}

class BoardTagSection {
  const BoardTagSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.tags,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final List<String> tags;
}

class BoardFilterSection {
  const BoardFilterSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.filterLabels,
    required this.searchLabel,
    required this.searchHint,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final List<String> filterLabels;
  final String searchLabel;
  final String searchHint;
}

class BoardCreateFormTheme {
  const BoardCreateFormTheme({
    required this.introSection,
    this.helperMessages = const [],
    this.moodOptions = const [],
    this.memoryFieldHint,
    this.tagFieldHint,
    this.tagFieldLabel,
    this.additionalMediaGuidelines = const [],
  });

  final BoardIntroSection introSection;
  final List<BoardHelperMessage> helperMessages;
  final List<String> moodOptions;
  final String? tagFieldLabel;
  final String? tagFieldHint;
  final String? memoryFieldHint;
  final List<BoardHelperMessage> additionalMediaGuidelines;
}

class BoardMediaRules {
  const BoardMediaRules({
    this.supportedTypes = const [],
    this.maxAttachments,
    this.maxFileSizeMb,
    this.helperMessages = const [],
  });

  /// 예: ['사진', '동영상']
  final List<String> supportedTypes;
  final int? maxAttachments;
  final double? maxFileSizeMb;
  final List<BoardHelperMessage> helperMessages;
}

class BoardStatsConfig {
  const BoardStatsConfig({
    required this.items,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;
  final List<BoardStatDefinition> items;
}

class BoardStatDefinition {
  const BoardStatDefinition({
    required this.id,
    required this.label,
    required this.icon,
    required this.accentColor,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color accentColor;
}



