import 'package:flutter/material.dart';

enum AppSurfaceTone { base, muted, accent, warm }

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.tone = AppSurfaceTone.base,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final AppSurfaceTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColor(theme.colorScheme),
        borderRadius: borderRadius,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(padding: padding, child: child),
    );
  }

  Color _backgroundColor(ColorScheme colorScheme) {
    return switch (tone) {
      AppSurfaceTone.base => colorScheme.surface,
      AppSurfaceTone.muted => colorScheme.surfaceContainer,
      AppSurfaceTone.accent => colorScheme.surfaceContainerHigh,
      AppSurfaceTone.warm => colorScheme.surfaceContainerHighest,
    };
  }
}
