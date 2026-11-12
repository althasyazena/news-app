// TODO 6: Implementasi ThemeProvider
// 1. Install Riverpod: `flutter pub add flutter_riverpod`
// 2. Import 'package:flutter_riverpod/flutter_riverpod.dart';
// 3. Buat class ThemeNotifier extends Notifier<bool> (menyimpan state isDarkMode)
// 4. Implementasikan fungsi toggle Theme() untuk mengubah state dan menyimpannya di SharedPreferences
// 5. Buat themeProvider (NotifierProvider) untuk digunakan di UI

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';

final themeStorageProvider = Provider<ThemeStorage>((ref) => ThemeStorage());

// tema awal yg dibaca di main.dart sebelum app tampil (berjalan secara async)
// nilainya di-override lewat 'ProviderScope.overrides'.

final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

// mode tema aktif: terang / gelap (default mengikuti sistem)
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(initialThemeModeProvider);

  // beralih ke kebalikan dari tema yang sedang tampil / aktif
  void toggle(Brightness currentBrightness) {
    state = currentBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    ref.read(themeStorageProvider).save(state);
  }
}

// TODO: Deklarasi sebuah notofier untuk memberi tahukan perubahan yg terjadi agar aplikasi 
// dapat mengetahui ada perubahan yang akan terjadi pada theme
final themeModeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
