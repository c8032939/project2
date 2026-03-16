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
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            children: [
              Text('Settings', style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                'Routing is ready for routine preferences, reminder controls, '
                'and platform-specific options.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const SectionCard(
                title: 'Placeholder',
                child: Text(
                  'This route keeps the navigation structure in place for later '
                  'settings work without mixing that feature into the timer shell.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
