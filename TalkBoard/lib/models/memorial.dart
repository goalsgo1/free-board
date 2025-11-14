import 'package:cloud_firestore/cloud_firestore.dart';

class Memorial {
  const Memorial({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.relation,
    this.story,
    this.anniversaryLabel,
    this.isPublic = true,
    this.allowComments = true,
    this.allowSharing = true,
    this.notes,
    this.categories = const <String>[],
    this.tags = const <String>[],
    this.heroImageUrl,
    this.isPinned = false,
    this.isFavorite = false,
    this.featuredAt,
    this.visitCount = 0,
    this.letterCount = 0,
    this.photoCount = 0,
    this.videoCount = 0,
    this.prayerCount = 0,
  });

  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? relation;
  final String? story;
  final String? anniversaryLabel;
  final bool isPublic;
  final bool allowComments;
  final bool allowSharing;
  final String? notes;
  final List<String> categories;
  final List<String> tags;
  final String? heroImageUrl;
  final bool isPinned;
  final bool isFavorite;
  final DateTime? featuredAt;
  final int visitCount;
  final int letterCount;
  final int photoCount;
  final int videoCount;
  final int prayerCount;

  Memorial copyWith({
    String? id,
    String? name,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? relation,
    String? story,
    String? anniversaryLabel,
    bool? isPublic,
    bool? allowComments,
    bool? allowSharing,
    String? notes,
    List<String>? categories,
    List<String>? tags,
    String? heroImageUrl,
    bool? isPinned,
    bool? isFavorite,
    DateTime? featuredAt,
    int? visitCount,
    int? letterCount,
    int? photoCount,
    int? videoCount,
    int? prayerCount,
  }) {
    return Memorial(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      relation: relation ?? this.relation,
      story: story ?? this.story,
      anniversaryLabel: anniversaryLabel ?? this.anniversaryLabel,
      isPublic: isPublic ?? this.isPublic,
      allowComments: allowComments ?? this.allowComments,
      allowSharing: allowSharing ?? this.allowSharing,
      notes: notes ?? this.notes,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      featuredAt: featuredAt ?? this.featuredAt,
      visitCount: visitCount ?? this.visitCount,
      letterCount: letterCount ?? this.letterCount,
      photoCount: photoCount ?? this.photoCount,
      videoCount: videoCount ?? this.videoCount,
      prayerCount: prayerCount ?? this.prayerCount,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'relation': relation,
      'story': story,
      'anniversaryLabel': anniversaryLabel,
      'isPublic': isPublic,
      'allowComments': allowComments,
      'allowSharing': allowSharing,
      'notes': notes,
      'categories': categories,
      'tags': tags,
      'heroImageUrl': heroImageUrl,
      'isPinned': isPinned,
      'isFavorite': isFavorite,
      'featuredAt': featuredAt != null ? Timestamp.fromDate(featuredAt!) : null,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'visitCount': visitCount,
      'letterCount': letterCount,
      'photoCount': photoCount,
      'videoCount': videoCount,
      'prayerCount': prayerCount,
    };
  }

  factory Memorial.fromFirestore(Map<String, dynamic> data, String id) {
    final createdAtTimestamp = data['createdAt'] as Timestamp?;
    final updatedAtTimestamp = data['updatedAt'] as Timestamp?;
    final featuredTimestamp = data['featuredAt'] as Timestamp?;

    return Memorial(
      id: id,
      name: (data['name'] as String?) ?? '이름 미정',
      relation: data['relation'] as String?,
      story: data['story'] as String?,
      anniversaryLabel: data['anniversaryLabel'] as String?,
      isPublic: (data['isPublic'] as bool?) ?? true,
      allowComments: (data['allowComments'] as bool?) ?? true,
      allowSharing: (data['allowSharing'] as bool?) ?? true,
      notes: data['notes'] as String?,
      categories: (data['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[],
      tags: (data['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[],
      heroImageUrl: data['heroImageUrl'] as String?,
      isPinned: (data['isPinned'] as bool?) ?? false,
      isFavorite: (data['isFavorite'] as bool?) ?? false,
      featuredAt: featuredTimestamp?.toDate(),
      createdBy: (data['createdBy'] as String?) ?? 'unknown',
      createdAt: createdAtTimestamp?.toDate() ?? DateTime.now(),
      updatedAt: updatedAtTimestamp?.toDate() ?? DateTime.now(),
      visitCount: (data['visitCount'] as num?)?.toInt() ?? 0,
      letterCount: (data['letterCount'] as num?)?.toInt() ?? 0,
      photoCount: (data['photoCount'] as num?)?.toInt() ?? 0,
      videoCount: (data['videoCount'] as num?)?.toInt() ?? 0,
      prayerCount: (data['prayerCount'] as num?)?.toInt() ?? 0,
    );
  }
}


