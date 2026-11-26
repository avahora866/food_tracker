import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'weight_entry.dart';

/// Persists weight entries on the device.
class WeightRepository {
  static const _key = 'weight_entries';

  /// Returns all entries, newest first.
  Future<List<WeightEntry>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List)
        .map((e) => WeightEntry.fromJson(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<void> add(WeightEntry entry) async {
    final entries = await load();
    entries.add(entry);
    await _save(entries);
  }

  Future<void> delete(String id) async {
    final entries = await load();
    entries.removeWhere((e) => e.id == id);
    await _save(entries);
  }

  Future<void> _save(List<WeightEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(entries.map((e) => e.toJson()).toList()),
    );
  }
}
