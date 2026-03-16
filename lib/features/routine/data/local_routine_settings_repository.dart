import 'package:project2/features/routine/data/routine_settings_repository.dart';
import 'package:project2/features/routine/domain/routine_template.dart';

class LocalRoutineSettingsRepository implements RoutineSettingsRepository {
  @override
  Future<RoutineTemplate> loadRoutineTemplate() async {
    return RoutineTemplate.defaultMvp();
  }
}
