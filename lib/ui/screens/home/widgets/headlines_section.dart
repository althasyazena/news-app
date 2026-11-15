import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_tile.dart';
import 'featured_article_card.dart';

/// TODO: Ubah HeadlinesSection menjadi ConsumerWidget
/// TODO: Gunakan AsyncValue.when dari headlinesProvider
class HeadlinesSection extends ConsumerWidget {
  const HeadlinesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(SelectedCategoryProvider);

    final headlines = ref.watch(headlinesProvider(selectedCategory));

    return headlines.when(
      loading: () {
        debugPrint('[HOME] Berita sedang loading');

        return const SliverToBoxAdapter(child: LoadingSkeleton());
      },
      error: (error, stack) {
        debugPrint('[HOME] ERROR: $error');
        debugPrint('$stack');

        return SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorState(
            error: error,
            onRetry: () => ref.invalidate(headlinesProvider(selectedCategory)),
          ),
        );
      },
      data: (articles) {
        debugPrint('[HOME] Jumlah berita: ${articles.length}');

        if (articles.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.newspaper_rounded,
              title: 'belum ada berita',
              message:
                  'coba pilih kategori lain atau tarik ke atas untuk reload',
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Now!',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Color(0xFF0015FF)),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (index == 1) {
              return FeaturedArticleCard(article: articles.first);
            }

            return ArticleTile(article: articles[index - 1]);
          }, childCount: articles.length + 1),
        );
      },
    );
  }
}
