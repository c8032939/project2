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
              Text('Settings', style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                'Routine and reminder configuration will live here once those '
                'features are implemented.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const SectionCard(
                title: 'Routing foundation',
                child: Text(
                  'This placeholder confirms the app can deep link into '
                  'feature areas without hard-coding navigation in widgets.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
