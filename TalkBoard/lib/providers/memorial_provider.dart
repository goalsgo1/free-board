import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:free_board/models/memorial.dart';
import 'package:free_board/services/memorial_service.dart';

class MemorialProvider extends ChangeNotifier {
  MemorialProvider({MemorialService? memorialService})
      : _memorialService = memorialService ?? MemorialService() {
    _subscription = _memorialService.streamMemorials().listen(
      (memorials) {
        _memorials = memorials;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  final MemorialService _memorialService;
  StreamSubscription<List<Memorial>>? _subscription;

  List<Memorial> _memorials = const [];
  bool _isSubmitting = false;
  String? _errorMessage;

  List<Memorial> get memorials => _memorials;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  Memorial? findById(String memorialId) {
    try {
      return _memorials.firstWhere((memorial) => memorial.id == memorialId);
    } catch (_) {
      return null;
    }
  }

  Future<bool> createMemorial({
    required String name,
    required String createdBy,
    String? relation,
    String? story,
    String? anniversaryLabel,
    bool isPublic = true,
    bool allowComments = true,
    bool allowSharing = true,
    String? notes,
    List<String> categories = const <String>[],
    List<String> tags = const <String>[],
    String? heroImageUrl,
  }) async {
    if (_isSubmitting) return false;

    try {
      _isSubmitting = true;
      _errorMessage = null;
      notifyListeners();

      final now = DateTime.now();
      final memorial = Memorial(
        id: '',
        name: name,
        createdBy: createdBy,
        relation: relation,
        story: story,
        anniversaryLabel: anniversaryLabel,
        isPublic: isPublic,
        allowComments: allowComments,
        allowSharing: allowSharing,
        notes: notes,
        categories: categories,
        tags: tags,
        heroImageUrl: heroImageUrl,
        createdAt: now,
        updatedAt: now,
      );

      final createdId = await _memorialService.createMemorial(memorial);
      _isSubmitting = false;
      notifyListeners();
      return createdId != null;
    } catch (error) {
      _errorMessage = error.toString();
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<bool> updatePinned(String memorialId, bool isPinned) async {
    final success = await _memorialService.updateMemorial(
      memorialId,
      {'isPinned': isPinned},
    );
    if (success) {
      _memorials = _memorials
          .map(
            (memorial) => memorial.id == memorialId
                ? memorial.copyWith(isPinned: isPinned)
                : memorial,
          )
          .toList();
      notifyListeners();
    } else {
      _errorMessage = '추모관 고정 상태를 변경하지 못했습니다.';
      notifyListeners();
    }
    return success;
  }

  Future<bool> updateFavorite(String memorialId, bool isFavorite) async {
    final success = await _memorialService.updateMemorial(
      memorialId,
      {'isFavorite': isFavorite},
    );
    if (success) {
      _memorials = _memorials
          .map(
            (memorial) => memorial.id == memorialId
                ? memorial.copyWith(isFavorite: isFavorite)
                : memorial,
          )
          .toList();
      notifyListeners();
    } else {
      _errorMessage = '즐겨찾기 상태를 변경하지 못했습니다.';
      notifyListeners();
    }
    return success;
  }
}


