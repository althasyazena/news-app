
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/bookmark_provider.dart';
import '../../data/models/article.dart';

class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({
    super.key,
    required this.article,
    this.color,
    this.tonal = false,
  });

  final Article article;
  final Color? color;

  /// Pakai gaya filled tonal (cocok di atas gambar).
  final bool tonal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(
      isBookmarkedProvider(article.url),
    );

    void onPressed() {
      ref.read(bookmarksProvider.notifier).toggleBookmark(article);
    }

    final tooltip = isSaved ? 'Hapus dari Tersimpan' : 'Simpan';

    final icon = Icon(
      Icons.bookmark_border_rounded,
      color: color,
    );

    final selectedIcon = Icon(
      Icons.bookmark_rounded,
      color: color,
    );

    if (tonal) {
      return IconButton.filledTonal(
        tooltip: tooltip,
        isSelected: isSaved,
        icon: icon,
        selectedIcon: selectedIcon,
        onPressed: onPressed,
      );
    }

    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      isSelected: isSaved,
      icon: icon,
      selectedIcon: selectedIcon,
      onPressed: onPressed,
    );
  }
}