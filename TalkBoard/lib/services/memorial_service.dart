import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_board/models/memorial.dart';

class MemorialService {
  MemorialService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  static const String _collection = 'memorials';

  Stream<List<Memorial>> streamMemorials() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Memorial.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String?> createMemorial(Memorial memorial) async {
    try {
      final data = memorial.toFirestore();
      final docRef = await _firestore.collection(_collection).add(data);
      return docRef.id;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to create memorial: $error',
        name: 'MemorialService',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<Memorial?> getMemorial(String memorialId) async {
    try {
      final doc =
          await _firestore.collection(_collection).doc(memorialId).get();
      final data = doc.data();
      if (data == null) return null;
      return Memorial.fromFirestore(data, doc.id);
    } catch (error, stackTrace) {
      developer.log(
        'Failed to get memorial: $error',
        name: 'MemorialService',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<bool> updateMemorial(String memorialId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(_collection).doc(memorialId).update({
        ...updates,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      return true;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to update memorial: $error',
        name: 'MemorialService',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}


