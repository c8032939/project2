import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project2/features/routine/data/local_routine_settings_repository.dart';
import 'package:project2/features/routine/domain/desk_phase.dart';
import 'package:project2/features/timer/application/timer_bloc.dart';

void main() {
  group('TimerBloc', () {
    blocTest<TimerBloc, TimerState>(
      'loads the default sitting, standing, walking order on startup',
      build: () => TimerBloc(
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
      act: (bloc) => bloc.add(const TimerStarted()),
      verify: (bloc) {
        expect(bloc.state.status, TimerStatus.ready);
        expect(bloc.state.snapshot?.currentPhase, DeskPhase.sitting);
        expect(bloc.state.snapshot?.phaseOrder, [
          DeskPhase.sitting,
          DeskPhase.standing,
          DeskPhase.walking,
        ]);
      },
    );
  });
}
