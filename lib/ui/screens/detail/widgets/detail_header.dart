
import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.article,
  });

  final Article article;

  int get readingTime {
    final text = '${article.description ?? ''} ${article.cleanContent}';
    final words = text.trim().isEmpty
        ? 0
        : text.trim().split(RegExp(r'\s+')).length;

    return (words / 200).ceil().clamp(1, 99);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 27,
            fontWeight: FontWeight.w900,
            height: 1.15,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 16),

        Wrap(
          spacing: 9,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              DateFormatter.full(article.publishedAt),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '•',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            Icon(
              Icons.access_time_rounded,
              size: 17,
              color: scheme.onSurfaceVariant,
            ),
            Text(
              '$readingTime min read',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}