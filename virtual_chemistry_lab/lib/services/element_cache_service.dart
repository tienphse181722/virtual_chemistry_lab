import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_chemistry_lab/models/element_model.dart';
import 'package:virtual_chemistry_lab/services/firestore_service.dart';

class ElementCacheService {
  static const String _cacheKey = 'cached_elements';
  static const String _cacheTimeKey = 'cached_elements_time';
  static const Duration _cacheExpiry = Duration(days: 7);

  final FirestoreService _firestoreService = FirestoreService();

  // COMBO BEST: Local JSON + Cache + Firebase fallback
  Future<List<ElementModel>> getElements() async {
    try {
      // 1. Load từ cache trước (nhanh nhất)
      final cachedElements = await _loadFromCache();
      if (cachedElements != null && cachedElements.isNotEmpty) {
        print('✅ Loaded ${cachedElements.length} elements from cache');
        
        // Background: fetch từ Firebase để update cache
        _updateCacheInBackground();
        
        return cachedElements;
      }

      // 2. Load từ JSON local (không cần internet)
      print('📦 Loading from local JSON...');
      final localElements = await _loadFromLocalJson();
      if (localElements.isNotEmpty) {
        print('✅ Loaded ${localElements.length} elements from local JSON');
        
        // Save to cache
        await _saveToCache(localElements);
        
        // Background: fetch từ Firebase để update
        _updateCacheInBackground();
        
        return localElements;
      }

      // 3. Fallback: fetch từ Firebase
      print('📥 Fetching from Firebase...');
      final firebaseElements = await _firestoreService.getElements();
      await _saveToCache(firebaseElements);
      return firebaseElements;
      
    } catch (e) {
      print('❌ Error: $e');
      
      // Last resort: try local JSON
      try {
        return await _loadFromLocalJson();
      } catch (e2) {
        print('❌ All methods failed: $e2');
        return [];
      }
    }
  }

  // Load từ JSON trong assets (0ms, không cần internet)
  Future<List<ElementModel>> _loadFromLocalJson() async {
    try {
      final jsonString = await rootBundle.loadString('assets/periodic_table.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ElementModel.fromMap(json)).toList();
    } catch (e) {
      print('Error loading from local JSON: $e');
      return [];
    }
  }

  // Update cache in background (không block UI)
  void _updateCacheInBackground() {
    Future.delayed(Duration(milliseconds: 100), () async {
      try {
        final elements = await _firestoreService.getElements();
        await _saveToCache(elements);
        print('🔄 Cache updated from Firebase');
      } catch (e) {
        print('Background update failed: $e');
      }
    });
  }

  // Load from SharedPreferences
  Future<List<ElementModel>?> _loadFromCache({bool ignoreExpiry = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check cache time
      if (!ignoreExpiry) {
        final cacheTime = prefs.getInt(_cacheTimeKey);
        if (cacheTime != null) {
          final cachedDate = DateTime.fromMillisecondsSinceEpoch(cacheTime);
          final now = DateTime.now();
          if (now.difference(cachedDate) > _cacheExpiry) {
            print('⏰ Cache expired');
            return null;
          }
        }
      }
      
      // Load cached data
      final cachedJson = prefs.getString(_cacheKey);
      if (cachedJson == null) return null;
      
      final List<dynamic> jsonList = json.decode(cachedJson);
      return jsonList.map((json) => ElementModel.fromMap(json)).toList();
    } catch (e) {
      print('Error loading from cache: $e');
      return null;
    }
  }

  // Save to SharedPreferences
  Future<void> _saveToCache(List<ElementModel> elements) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert to JSON
      final jsonList = elements.map((e) => e.toMap()).toList();
      final jsonString = json.encode(jsonList);
      
      // Save data and timestamp
      await prefs.setString(_cacheKey, jsonString);
      await prefs.setInt(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('Error saving to cache: $e');
    }
  }

  // Clear cache (for testing or refresh)
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    await prefs.remove(_cacheTimeKey);
    print('🗑️ Cache cleared');
  }
}
