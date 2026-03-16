import 'package:go_router/go_router.dart';
import 'package:project2/features/timer/presentation/timer_shell_page.dart';

GoRouter createAppRouter() {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const TimerShellPage()),
    ],
  );
}
