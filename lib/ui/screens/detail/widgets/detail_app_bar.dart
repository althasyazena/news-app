
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';

class DetailAppBar extends ConsumerWidget {
  const DetailAppBar({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 12, 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                          children: [
                            TextSpan(
                              text: 'S',
                              style: TextStyle(
                                color: theme.brightness == Brightness.dark
                                    ? Color(0xFFFFFF00)
                                    : Color(0xFFFFA500)
                              ),
                            ),
                            const TextSpan(
                              text: 'T',
                              style: TextStyle(
                                color: Color(0xFF0015FF),
                              ),
                            ),
                            const TextSpan(
                              text: 'E',
                              style: TextStyle(
                                color: Color(0xFF03CB08),
                              ),
                            ),
                            const TextSpan(
                              text: 'M',
                              style: TextStyle(
                                color: Color(0xFFFF0000),
                              ),
                            ),
                            TextSpan(
                              text: ' Space',
                              style: TextStyle(
                                color: scheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                BookmarkButton(
                  article: article,
                  tonal: false,
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 205,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ArticleImage(
                url: article.imageUrl,
                radius: 0,
              ),

              Positioned(
                left: 20,
                bottom: 18,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF03CB08),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    article.category?.label ?? 'STEM',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}