
import 'package:flutter/material.dart';

import '../../../../core/utils/url_helper.dart';

class ReadMoreBar extends StatelessWidget {
  const ReadMoreBar({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      child: SizedBox(
        height: 58,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF0015FF),
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () => UrlHelper.open(context, url),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.open_in_new_rounded, size: 20, color: Colors.white,),
              SizedBox(width: 10),
              Text(
                'Read full article',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}