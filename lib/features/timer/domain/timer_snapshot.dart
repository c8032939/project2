import 'dart:collection';

import 'package:project2/features/routine/domain/desk_phase.dart';

class TimerSnapshot {
  TimerSnapshot({
    required this.currentPhase,
    required List<DeskPhase> phaseOrder,
  }) : _phaseOrder = List<DeskPhase>.unmodifiable(phaseOrder);

  final DeskPhase currentPhase;
  final List<DeskPhase> _phaseOrder;

  UnmodifiableListView<DeskPhase> get phaseOrder {
    return UnmodifiableListView<DeskPhase>(_phaseOrder);
  }
}
