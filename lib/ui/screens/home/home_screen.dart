
import 'package:flutter/material.dart';

import 'widgets/category_chips.dart';
import 'widgets/headlines_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/welcome_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refresh() async {
    // TODO: Refresh provider
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const HomeAppBar(),

          const SliverToBoxAdapter(
            child: WelcomeBanner(),
          ),

          // SEARCH WIDGET AKAN DILETAKKAN DI SINI

          const SliverToBoxAdapter(
            child: CategoryChips(),
          ),

          const HeadlinesSection(),
        ],
      ),
    );
  }
}
