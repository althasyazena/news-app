
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(SearchQueryProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(SearchQueryProvider, (_, next) {
      if (_controller.text != next) {
        _controller.text = next;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });

    return SizedBox(
      height: 60,
      child: SearchBar(
        controller: _controller,
        hintText: 'Search articles...',
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
          isDark
              ? const Color(0xFF252538)
              : const Color(0xFFF2F2FA),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 18),
        ),
        hintStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: Color(0xFF9292A2),
            fontSize: 16,
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 15,
          ),
        ),
        leading: const Icon(
          Icons.search_rounded,
          color: Color(0xFF646477),
          size: 27,
        ),
        shape: const WidgetStatePropertyAll(
          StadiumBorder(),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          ref.read(SearchQueryProvider.notifier).submit(value);
        },
        trailing: [
          ListenableBuilder(
            listenable: _controller,
            builder: (_, _) => _controller.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: _clear,
                  ),
          ),
        ],
      ),
    );
  }
}