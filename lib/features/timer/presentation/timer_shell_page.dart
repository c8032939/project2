import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/app/app_page_scaffold.dart';
import 'package:project2/core/constants/app_constants.dart';
import 'package:project2/core/constants/app_strings.dart';
import 'package:project2/features/routine/application/routine_settings_bloc.dart';
import 'package:project2/features/timer/application/timer_bloc.dart';
import 'package:project2/shared/widgets/app_info_panel.dart';
import 'package:project2/shared/widgets/section_card.dart';

class TimerShellPage extends StatelessWidget {
  const TimerShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPageScaffold(
      title: AppConstants.appName,
      description: AppStrings.shellHeading,
      action: const AppInfoPanel(
        title: 'Today\'s rhythm',
        body: AppStrings.shellBody,
      ),
      child: Column(
        children: [
          BlocBuilder<TimerBloc, TimerState>(
            builder: (context, timerState) {
              final snapshot = timerState.snapshot;
              final currentPhaseLabel =
                  snapshot?.currentPhase.label ?? 'Loading...';
              final phaseOrder = snapshot?.phaseOrder ?? const [];

              return SectionCard(
                title: 'Current phase',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPhaseLabel,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: phaseOrder
                          .map((phase) => Chip(label: Text(phase.label)))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<RoutineSettingsBloc, RoutineSettingsState>(
            builder: (context, routineState) {
              final sequence = routineState.template.phaseOrder
                  .map((phase) => phase.label)
                  .join(' -> ');

              return SectionCard(
                title: 'Routine defaults',
                child: Text(
                  sequence.isEmpty
                      ? 'Loading the default sitting, standing, and walking flow.'
                      : sequence,
                  style: theme.textTheme.bodyLarge,
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const SectionCard(
            title: 'Feature map',
            child: Text(
              'The shell separates timer, routine, settings, statistics, and '
              'notifications so later tasks can add behavior without collapsing '
              'the app into a single screen file.',
            ),
          ),
        ],
      ),
    );
  }
}
