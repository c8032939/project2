import 'package:flutter/material.dart';
import 'package:project2/app/app_page_scaffold.dart';
import 'package:project2/shared/widgets/section_card.dart';

class SettingsPlaceholderPage extends StatelessWidget {
  const SettingsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPageScaffold(
      title: 'Routine settings',
      description:
          'This route is reserved for routine order, phase lengths, and future reminder controls.',
      action: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Settings will stay local-first and calm by default.',
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ),
      child: const SectionCard(
        title: 'Navigation foundation',
        child: Text(
          'The route exists now so settings work can be added without changing '
          'the app shell structure later.',
        ),
      ),
    );
  }
}
