import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';
import 'package:news_app/providers/theme_provider.dart';

import 'app.dart';

Future<void> main() async {
  // Selama proses inisialisasi ini, native splash screen tetap tampil.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(isOptional: true); // Mengambil APIkey
  await initializeDateFormatting('id_ID'); // menyesuaikan format tanggal bahasa indonesia
  final initialTheme = await ThemeStorage().load(); // load tema aplikasi sesuai sistem tema hp (light/dark)

  runApp(
    // TODO: Bungkus NewsApp dengan ProviderScope saat mengimplementasikan Riverpod
    ProviderScope(
      // Matikan auto-retry bawaan riverpod agar kuota API tidak cepat habis
      retry: (retryCount, error) => null,
      overrides: [
        // TODO: lengkapi pemanggilan provider
        initialThemeModeProvider.overrideWithValue(initialTheme) // kondisi dimana ada kemungkinan perubahan state
      ],
      child: NewsApp(),
    )
  );
}
