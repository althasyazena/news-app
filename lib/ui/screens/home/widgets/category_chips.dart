
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import '../../../../core/constants/news_category.dart';

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(SelectedCategoryProvider);
    final theme = Theme.of(context);

    final categories = [
      (
        category: StemCategory.science,
        icon: Icons.science_outlined,
        color: theme.brightness == Brightness.dark
          ? Color(0xFFFFFF00)
          : Color(0xFFFFA500)
      ),
      (
        category: StemCategory.technology,
        icon: Icons.memory_outlined,
        color: const Color(0xFF0015FF),
      ),
      (
        category: StemCategory.engineering,
        icon: Icons.hub_outlined,
        color: const Color(0xFF03CB08),
      ),
      (
        category: StemCategory.mathematics,
        icon: Icons.calculate_outlined,
        color: const Color(0xFFFF0000),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        children: categories.map((item) {
          final isSelected = selected == item.category;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                ref
                    .read(SelectedCategoryProvider.notifier)
                    .select(item.category);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? item.color
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      item.icon,
                      size: 34,
                      color: item.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.category.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}