import 'package:project2/features/routine/domain/routine_template.dart';

abstract interface class RoutineSettingsRepository {
  Future<RoutineTemplate> loadRoutineTemplate();
}
