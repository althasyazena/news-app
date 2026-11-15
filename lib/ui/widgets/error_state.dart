
import 'package:flutter/material.dart';

import '../../data/services/news_api_exception.dart';
import 'empty_state.dart';

/// Tampilan error dengan tombol coba lagi.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final friendly = error is NewsApiException
        ? error as NewsApiException
        : NewsApiException.unknown;

    final isOffline =
        identical(friendly, NewsApiException.offline);

    return EmptyState(
      icon: isOffline
          ? Icons.wifi_off_rounded
          : Icons.cloud_off_outlined,
      title: friendly.title,
      message: friendly.message,
      actionLabel: 'Coba lagi',
      onAction: onRetry,
    );
  }
}