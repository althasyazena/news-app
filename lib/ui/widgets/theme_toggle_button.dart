import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/theme_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEBE9E7), width: 2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: IconButton(
        tooltip: isDark ? 'Mode terang' : 'Mode gelap',
        onPressed: () {
          ref.read(themeModeProvider.notifier).toggle(brightness);
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => RotationTransition(
            turns: Tween(begin: 0.75, end: 1.0).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Icon(
            isDark ? Icons.wb_sunny_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            color: isDark ? const Color(0xFFFFFF00) : const Color(0xFF0015FF),
            size: 28,
          ),
        ),
      ),
    );
  }
}
