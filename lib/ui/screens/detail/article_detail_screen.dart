
import 'package:flutter/material.dart';

import '../../../data/models/article.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/detail_header.dart';
import 'widgets/detail_content.dart';
import 'widgets/read_more_bar.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailAppBar(article: article),
            Transform.translate(
              offset: const Offset(0, -12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailHeader(article: article),
                    const SizedBox(height: 26),
                    DetailContent(article: article),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ReadMoreBar(url: article.url),
    );
  }
}