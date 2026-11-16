 
import 'package:flutter/material.dart';

import 'widgets/search_input.dart';
import 'widgets/search_results.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
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
                  TextSpan(
                    text: 'T',
                    style: TextStyle(color: Color(0xFF0015FF)),
                  ),
                  TextSpan(
                    text: 'E',
                    style: TextStyle(color: Color(0xFF03CB08)),
                  ),
                  TextSpan(
                    text: 'M',
                    style: TextStyle(color: Color(0xFFFF0000)),
                  ),
                  TextSpan(text: ' Space'),
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SearchInput(),
          ),

          const SizedBox(height: 8),

          const Expanded(
            child: SearchResults(),
          ),
        ],
      ),
    );
  }
}