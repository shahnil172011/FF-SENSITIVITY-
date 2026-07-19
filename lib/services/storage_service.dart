import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sensitivity_profile.dart';

class StorageService {
  static const String _profilesKey = 'profiles';
  static const String _historyKey = 'history';

  static Future<void> saveProfiles(List<SensitivityProfile> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    final json = profiles.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_profilesKey, json);
  }

  static Future<List<SensitivityProfile>> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_profilesKey) ?? [];
    return jsonList.map((j) {
      final data = jsonDecode(j) as Map<String, dynamic>;
      return SensitivityProfile(
        id: data['id'] as String,
        name: data['name'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String),
        general: Map<String, double>.from(data['general'] as Map),
        redDot: Map<String, double>.from(data['redDot'] as Map),
        scope2x: Map<String, double>.from(data['scope2x'] as Map),
        scope4x: Map<String, double>.from(data['scope4x'] as Map),
        sniperScope: Map<String, double>.from(data['sniperScope'] as Map),
        freeLook: Map<String, double>.from(data['freeLook'] as Map),
        graphicsSetting: data['graphicsSetting'] as String,
        fpsSetting: data['fpsSetting'] as int,
        deviceModel: data['deviceModel'] as String,
        playStyle: data['playStyle'] as String,
      );
    }).toList();
  }

  static Future<void> saveHistory(List<Map<String, dynamic>> history) async {
    final prefs = await SharedPreferences.getInstance();
    final json = history.map((h) => jsonEncode(h)).toList();
    await prefs.setStringList(_historyKey, json);
  }

  static Future<List<Map<String, dynamic>>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_historyKey) ?? [];
    return jsonList.map((j) => jsonDecode(j) as Map<String, dynamic>).toList();
  }
}