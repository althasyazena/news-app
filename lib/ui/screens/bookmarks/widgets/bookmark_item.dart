import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/ui/widgets/article_image.dart';

import '../../../../../data/models/article.dart';
import '../../../../../providers/bookmark_provider.dart';
import '../../../../core/utils/date_formatter.dart';

class BookmarkItem extends ConsumerWidget {
  const BookmarkItem({super.key, required this.article});

  final Article article;

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'science':
        return const Color(0xFF03CB08);
      case 'technology':
        return const Color(0xFF1749FF);
      case 'engineering':
        return const Color(0xFF03CB08);
      case 'mathematics':
        return const Color(0xFFFF2424);
      case 'space':
        return const Color(0xFFFFE600);
      default:
        return const Color(0xFF1749FF);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = article.sourceName;
    final categoryColor = _categoryColor(category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Article Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ArticleImage(
              url: article.imageUrl,
              width: 94,
              height: 100,
              radius: 12,
            ),
          ),

          const SizedBox(width: 12),

          // Article Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: category.toLowerCase() == 'space'
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Title
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),

                const SizedBox(height: 5),

                // Date
                Text(
                  DateFormatter.relative(article.publishedAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Remove Bookmark
          IconButton(
            onPressed: () {
              ref.read(bookmarksProvider.notifier).toggleBookmark(article);
            },
            icon: const Icon(
              Icons.bookmark_rounded,
              color: Color(0xFF03CB08),
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
