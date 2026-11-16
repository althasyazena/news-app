
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/core/utils/date_formatter.dart';
import '../../../../providers/bookmark_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/theme_toggle_button.dart';
import 'widgets/bookmark_item.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() =>
      _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Science',
    'Technology',
    'Engineering',
    'Mathematics',
    'Space',
  ];

  @override
  Widget build(BuildContext context) {
    final bookmarksAsync = ref.watch(bookmarksProvider);
    final theme = Theme.of(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 76,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.headlineMedium,
                    children: [
                      TextSpan(
                        text: 'S',
                        style: TextStyle(
                          color: theme.brightness == Brightness.dark
                              ? Color(0xFFFFFF00)
                              : Color(0xFFFFA500)
                        ),
                      ),
                      TextSpan(
                        text: 'T',
                        style: TextStyle(color: Color(0xFF0015FF)),
                      ),
                      TextSpan(
                        text: 'E',
                        style: TextStyle(color: Color(0xFF03CB08)),
                      ),
                      TextSpan(
                        text: 'M',
                        style: TextStyle(color: Color(0xFFFF0000)),
                      ),
                      TextSpan(
                        text: ' Space',
                        style: TextStyle(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: const [
              ThemeToggleButton(),
              SizedBox(width: 16),
            ],
          ),

          // Title and Description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Your Bookmarks',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.bookmark_border_rounded,
                        size: 38,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Save articles for later and keep exploring!',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      height: 1.4,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    showCheckmark: false,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: const Color(0xFFFF0000),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF646464),
                    ),
                    shape: const StadiumBorder(),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : const Color(0xFFEBE9E7),
                      width: 2,
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 14),
          ),

          // Bookmark List
          bookmarksAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

            error: (error, stackTrace) => SliverFillRemaining(
              child: Center(
                child: Text('Gagal memuat bookmark: $error'),
              ),
            ),

            data: (bookmarks) {
              final filteredBookmarks = selectedCategory == 'All'
                  ? bookmarks
                  : bookmarks.where((article) {
                      return article.sourceName.toLowerCase() ==
                          selectedCategory.toLowerCase();
                    }).toList();

              if (filteredBookmarks.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyState(
                    icon: Icons.bookmark_border_rounded,
                    title: bookmarks.isEmpty
                        ? 'Belum ada berita tersimpan'
                        : 'Tidak ada artikel',
                    message: bookmarks.isEmpty
                        ? 'Ketuk ikon bookmark pada berita untuk menyimpannya.'
                        : 'Belum ada artikel dalam kategori ini.',
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return BookmarkItem(
                      key: ValueKey(filteredBookmarks[index].url),
                      article: filteredBookmarks[index],
                    );
                  },
                  childCount: filteredBookmarks.length,
                ),
              );
            },
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}