
import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final description = article.description?.trim() ?? '';
    final content = article.cleanContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description.isNotEmpty)
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 17,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
          ),

        if (content.isNotEmpty && content != description) ...[
          const SizedBox(height: 20),
          Text(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.65,
            ),
          ),
        ],
      ],
    );
  }
}