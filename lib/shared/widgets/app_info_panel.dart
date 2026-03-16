import 'package:flutter/material.dart';
import 'package:project2/shared/widgets/app_surface_card.dart';

class AppInfoPanel extends StatelessWidget {
  const AppInfoPanel({
    required this.title,
    required this.body,
    this.tone = AppSurfaceTone.accent,
    super.key,
  });

  final String title;
  final String body;
  final AppSurfaceTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSurfaceCard(
      tone: tone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(body, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
