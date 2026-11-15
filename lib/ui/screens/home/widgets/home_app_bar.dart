import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/navigation_provider.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../widgets/theme_toggle_button.dart';

// TODO: Ubah HomeAppBar menjadi ConsumerWidget
class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SliverAppBar(
      floating: true,
      snap: true,
      toolbarHeight: 76,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.today(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              style: theme.textTheme.headlineMedium,
              children: [
                TextSpan(
                  text: 'S',
                  style: TextStyle(color: Color(0xFFFFFF00)), // Yellow
                ),
                TextSpan(
                  text: 'T',
                  style: TextStyle(color: Color(0xFF0015FF)), // Blue
                ),
                TextSpan(
                  text: 'E',
                  style: TextStyle(color: Color(0xFF03CB08)), // Green
                ),
                TextSpan(
                  text: 'M',
                  style: TextStyle(color: Color(0xFFFF0000)), // Red
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
    );
  }
}
