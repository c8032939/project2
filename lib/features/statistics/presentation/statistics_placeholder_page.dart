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
            padding: const EdgeInsets.all(24),
            children: [
              Text('Statistics', style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                'Daily summaries and phase totals will attach to this route in '
                'a later task.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const SectionCard(
                title: 'Navigation target',
                child: Text(
                  'The route exists now so web URLs and mobile navigation can '
                  'stay stable as the statistics feature grows.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
