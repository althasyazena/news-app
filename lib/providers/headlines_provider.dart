
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/constants/news_category.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/providers/dependency_provider.dart';

class SelectedCategoryNotifier extends Notifier<StemCategory> {
  @override
  StemCategory build() => StemCategory.science;

  void select(StemCategory category) {
    state = category;
  }
}

final SelectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, StemCategory>(
  SelectedCategoryNotifier.new,
);

// Mengambil berita berdasarkan kategori STEMSpace
final headlinesProvider =
    FutureProvider.family<List<Article>, StemCategory>(
  (ref, category) {
    return ref
        .watch(newsRepositoryProvider)
        .getStemArticles(category);
  },
);