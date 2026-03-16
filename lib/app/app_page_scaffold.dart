import 'package:flutter/material.dart';
import 'package:project2/core/constants/app_constants.dart';
import 'package:project2/shared/widgets/app_surface_card.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    required this.title,
    required this.description,
    required this.child,
    this.action,
    super.key,
  });

  final String title;
  final String description;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppConstants.pageContentMaxWidth,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            children: [
              AppSurfaceCard(
                padding: const EdgeInsets.all(24),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppConstants.featureHeaderRadius),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool stackContent =
                        constraints.maxWidth <
                        AppConstants.compactHeaderBreakpoint;

                    if (stackContent) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeaderText(title: title, description: description),
                          if (action != null) ...[
                            const SizedBox(height: 20),
                            action!,
                          ],
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _HeaderText(
                            title: title,
                            description: description,
                          ),
                        ),
                        if (action != null) ...[
                          const SizedBox(width: 24),
                          Flexible(child: action!),
                        ],
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.appShellEyebrow, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(title, style: theme.textTheme.displaySmall),
        const SizedBox(height: 12),
        Text(description, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
