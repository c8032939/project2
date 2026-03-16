import 'package:flutter/material.dart';
import 'package:project2/shared/widgets/section_card.dart';

class SettingsPlaceholderPage extends StatelessWidget {
  const SettingsPlaceholderPage({super.key});

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
              Text('Routine settings', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(
                'This route is reserved for routine order, phase lengths, and '
                'future reminder controls.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const SectionCard(
                title: 'Navigation foundation',
                child: Text(
                  'The route exists now so settings work can be added without '
                  'changing the app shell structure later.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
