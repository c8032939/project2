import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/routine/data/routine_settings_repository.dart';
import 'package:project2/features/routine/domain/desk_phase.dart';
import 'package:project2/features/timer/domain/timer_snapshot.dart';

sealed class TimerEvent {
  const TimerEvent();
}

final class TimerStarted extends TimerEvent {
  const TimerStarted();
}

enum TimerStatus { initial, loading, ready }

class TimerState {
  const TimerState({this.status = TimerStatus.initial, this.snapshot});

  final TimerStatus status;
  final TimerSnapshot? snapshot;

  TimerState copyWith({TimerStatus? status, TimerSnapshot? snapshot}) {
    return TimerState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
    );
  }
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required RoutineSettingsRepository routineSettingsRepository})
    : _routineSettingsRepository = routineSettingsRepository,
      super(const TimerState()) {
    on<TimerStarted>(_onStarted);
  }

  final RoutineSettingsRepository _routineSettingsRepository;

  Future<void> _onStarted(TimerStarted event, Emitter<TimerState> emit) async {
    emit(state.copyWith(status: TimerStatus.loading));

    final template = await _routineSettingsRepository.loadRoutineTemplate();
    final currentPhase = template.phaseOrder.firstOrNull ?? DeskPhase.sitting;

    emit(
      state.copyWith(
        status: TimerStatus.ready,
        snapshot: TimerSnapshot(
          currentPhase: currentPhase,
          phaseOrder: template.phaseOrder,
        ),
      ),
    );
  }
}
