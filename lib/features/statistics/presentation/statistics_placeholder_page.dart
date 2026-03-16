import 'package:flutter/material.dart';
import 'package:project2/app/app_page_scaffold.dart';
import 'package:project2/shared/widgets/section_card.dart';

class StatisticsPlaceholderPage extends StatelessWidget {
  const StatisticsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPageScaffold(
      title: 'Statistics',
      description:
          'Daily sitting, standing, and walking insights will land on this route in a later task.',
      action: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Trends will build on timestamped activity data, not day-only counters.',
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ),
      child: const SectionCard(
        title: 'Prepared for growth',
        child: Text(
          'Keeping statistics behind a dedicated route gives web and mobile a '
          'consistent navigation model from the start.',
        ),
      ),
    );
  }
}
