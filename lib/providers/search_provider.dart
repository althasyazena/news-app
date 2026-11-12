// import '../data/models/article.dart';


// TODO 9: Implementasi SearchProvider
// 1. Buat class SearchNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), return [] sebagai nilai awal
// 3. Buat fungsi search(String query) untuk memanggil NewsRepository.searchArticles() dan menyimpan hasilnya di state
// 4. Buat searchProvider (AsyncNotifierProvider) untuk digunakan di UI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  // akan dijalankan ketika user menekan tombol enter
  void submit(String query) => state = query.trim(); // trim, memotong yang ga perlu
  void clear() => state = '';
}

// pendefinisian dari class ke variable
final SearchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

// hasil pencarian: otomatis fetch ulang setiap kali query berubah
// dia kana dijalankan ketika pencarian itu succes
final searchResultProvider = FutureProvider.autoDispose<List<Article>>((
  ref, // akan dijadikan parameter karena dia didalam anonimus function
) async {
  final query = ref.watch(SearchQueryProvider);
  if (query.isEmpty) return [];
  return ref.watch(newsRepositoryProvider).searchArticles(query);
});

// alias agar dapat diakses dengan nama searh result provider maupun search reasults provider
final searchResultsProvider = searchResultProvider;