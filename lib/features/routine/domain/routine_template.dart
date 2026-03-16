import 'dart:collection';

import 'package:project2/features/routine/domain/desk_phase.dart';

class RoutineTemplate {
  RoutineTemplate({required List<DeskPhase> phaseOrder})
    : _phaseOrder = List<DeskPhase>.unmodifiable(phaseOrder);

  factory RoutineTemplate.defaultMvp() {
    return RoutineTemplate(
      phaseOrder: [DeskPhase.sitting, DeskPhase.standing, DeskPhase.walking],
    );
  }

  final List<DeskPhase> _phaseOrder;

  UnmodifiableListView<DeskPhase> get phaseOrder {
    return UnmodifiableListView<DeskPhase>(_phaseOrder);
  }
}
