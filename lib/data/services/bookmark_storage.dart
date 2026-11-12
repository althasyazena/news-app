// penyimpanan lokal artikel yang di-bookmark(sharedprederences)
import 'dart:convert';

import 'package:news_app/data/models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkStorage {
  static const String _key = 'bookmarked_articles';
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<List<Article>> load() async {
    final raw = await _prefs.getStringList(_key) ?? [];
    return raw
        .map(
          (item) => Article.fromJson(jsonDecode(item) as Map<String, dynamic>),
        )
        .toList(); // mengubah format string menjadi json, dan untuk mencocokan tipe data yang sebelumnya Map
  }

  // function yang dijalankan ketika user mem-bookmark sebuah artikel
  Future<void> save(List<Article> article) {
    final raw = article.map((article) => jsonEncode(article.toJson())).toList();
    return _prefs.setStringList(_key, raw);
  }
}
