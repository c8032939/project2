import 'package:flutter/material.dart';
import 'package:project2/app/app_page_scaffold.dart';
import 'package:project2/shared/widgets/app_info_panel.dart';
import 'package:project2/shared/widgets/app_surface_card.dart';
import 'package:project2/shared/widgets/section_card.dart';

class SettingsPlaceholderPage extends StatelessWidget {
  const SettingsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      title: 'Routine settings',
      description:
          'This route is reserved for routine order, phase lengths, and future reminder controls.',
      action: const AppInfoPanel(
        title: 'Settings posture',
        body: 'Settings will stay local-first and calm by default.',
        tone: AppSurfaceTone.warm,
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
