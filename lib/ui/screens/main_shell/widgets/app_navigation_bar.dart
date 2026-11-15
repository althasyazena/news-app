
import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bookmarkCount = 0;

    final destinations = [
      (
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        label: 'Beranda',
      ),
      (
        icon: Icons.explore_outlined,
        selectedIcon: Icons.explore_rounded,
        label: 'Jelajahi',
      ),
      (
        icon: Icons.bookmark_border_rounded,
        selectedIcon: Icons.bookmark_rounded,
        label: 'Tersimpan',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(
            color: scheme.outlineVariant.withOpacity(0.25),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            children: List.generate(destinations.length, (index) {
              final item = destinations[index];
              final isSelected = currentIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 58,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0015FF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              isSelected
                                  ? item.selectedIcon
                                  : item.icon,
                              size: 26,
                              color: isSelected
                                  ? Colors.white
                                  : scheme.onSurface,
                            ),
                            if (index == 2 && bookmarkCount > 0)
                              Positioned(
                                right: 5,
                                top: 2,
                                child: Text(
                                  '$bookmarkCount',
                                  style: const TextStyle(
                                    color: Color(0xFFFF0000),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}