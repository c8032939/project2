import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/routine/data/routine_settings_repository.dart';
import 'package:project2/features/routine/domain/routine_template.dart';

sealed class RoutineSettingsEvent {
  const RoutineSettingsEvent();
}

final class RoutineSettingsRequested extends RoutineSettingsEvent {
  const RoutineSettingsRequested();
}

enum RoutineSettingsStatus { initial, loading, loaded, failure }

class RoutineSettingsState {
  RoutineSettingsState({
    this.status = RoutineSettingsStatus.initial,
    RoutineTemplate? template,
  }) : template = template ?? RoutineTemplate(phaseOrder: const []);

  final RoutineSettingsStatus status;
  final RoutineTemplate template;

  RoutineSettingsState copyWith({
    RoutineSettingsStatus? status,
    RoutineTemplate? template,
  }) {
    return RoutineSettingsState(
      status: status ?? this.status,
      template: template ?? this.template,
    );
  }
}

class RoutineSettingsBloc
    extends Bloc<RoutineSettingsEvent, RoutineSettingsState> {
  RoutineSettingsBloc({
    required RoutineSettingsRepository routineSettingsRepository,
  }) : _routineSettingsRepository = routineSettingsRepository,
       super(RoutineSettingsState()) {
    on<RoutineSettingsRequested>(_onRequested);
  }

  final RoutineSettingsRepository _routineSettingsRepository;

  Future<void> _onRequested(
    RoutineSettingsRequested event,
    Emitter<RoutineSettingsState> emit,
  ) async {
    emit(state.copyWith(status: RoutineSettingsStatus.loading));

    final template = await _routineSettingsRepository.loadRoutineTemplate();

    emit(
      state.copyWith(status: RoutineSettingsStatus.loaded, template: template),
    );
  }
}
