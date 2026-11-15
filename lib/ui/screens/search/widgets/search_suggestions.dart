

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/ui/widgets/article_tile.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';


import 'search_banner.dart';


class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({super.key});


  static const _topics = [
    ('Artificial Intelligence', Icons.smart_toy_outlined, Color(0xFF0015FF)),
    ('Biotechnology', Icons.biotech_outlined, Color(0xFF03CB08)),
    ('Robotics', Icons.precision_manufacturing_outlined, Color(0xFFFF0000)),
    ('Space & Astronomy', Icons.rocket_launch_outlined, Color(0xFF0015FF)),
    ('Climate & Environment', Icons.eco_outlined, Color(0xFF03CB08)),
    ('Health Technology', Icons.health_and_safety_outlined, Color(0xFFFF0000)),
  ];


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;


    final selectedCategory = ref.watch(SelectedCategoryProvider);
    final headlines = ref.watch(headlinesProvider(selectedCategory));


    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 28),
      children: [
        // Topics
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Popular Topics',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),


        const SizedBox(height: 14),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 10) / 2;


              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final topic in _topics)
                    SizedBox(
                      width: cardWidth,
                      height: 66,
                      child: Material(
                        color: isDark
                            ? theme.colorScheme.surfaceContainer
                            : const Color(0xFFF7F7F9),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            ref
                                .read(SearchQueryProvider.notifier)
                                .submit(topic.$1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: topic.$3.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Icon(
                                    topic.$2,
                                    color: topic.$3,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Expanded(
                                  child: Text(
                                    topic.$1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),


        const SizedBox(height: 25),


        // Banner
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SearchBanner(),
        ),


        const SizedBox(height: 28),


        // Trending
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Trending Now!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: See all
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF0015FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),


        const SizedBox(height: 8),


        headlines.when(
          loading: () => const LoadingSkeleton(),
          error: (error, _) => ErrorState(
            error: error,
            onRetry: () {
              ref.invalidate(headlinesProvider(selectedCategory));
            },
          ),
          data: (articles) {
            if (articles.isEmpty) {
              return const EmptyState(
                icon: Icons.newspaper_rounded,
                title: 'Belum ada berita',
                message: 'Berita terbaru belum tersedia.',
              );
            }


            return Column(
              children: [
                for (final article in articles.take(5))
                  ArticleTile(article: article),
              ],
            );
          },
        ),
      ],
    );
  }
}