import 'package:flutter/material.dart';
import 'package:project2/shared/widgets/section_card.dart';

class StatisticsPlaceholderPage extends StatelessWidget {
  const StatisticsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            children: [
              Text('Statistics', style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                'The navigation foundation now has a dedicated destination for '
                'daily standing, sitting, and walking summaries.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const SectionCard(
                title: 'Placeholder',
                child: Text(
                  'Later statistics work can land here without rewiring app-level '
                  'navigation on web or mobile.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
