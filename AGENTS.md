# AGENTS.md

This file defines the working rules for Codex and other coding agents working on **Standaholic**.

Standaholic is a Flutter web/mobile app that helps people with standing desks build healthier work routines by switching between **sitting**, **standing**, and **walking**.

## Product Constraints
* The app has exactly **3 fixed phases**: `sitting`, `standing`, `walking`.
* The default phase order is: **sitting → standing → walking**.
* The default MVP is **local-first** with **no account** and **no cloud sync**.
* Use **date + time based persistence**, not day-only counters.
* The app should feel **calm, minimal, and unobtrusive**.

## Interaction Guidelines
* Assume the user is technical and comfortable with software concepts.
* Explain Dart- or Flutter-specific concepts only when useful.
* Ask for clarification when product or technical intent is ambiguous.
* When suggesting new dependencies from `pub.dev`, explain why they are needed.
* Use `dart format` for formatting, `dart fix` when useful, and keep the project compatible with `flutter_lints`.

## Architecture Rules
* Use a **feature-oriented architecture**.
* Separate **presentation**, **Bloc state management**, **domain logic**, and **data access**.
* UI code must not directly contain business logic, persistence logic, or notification logic.
* Prefer a lightweight repository/data source separation instead of overengineering.
* Keep dependencies explicit through constructor injection.

## Feature Structure
Use a feature-based structure similar to:

```text
lib/
  app/
    app.dart
    router.dart
    theme/

  core/
    constants/
    utils/
    services/

  features/
    timer/
      domain/
      application/
      presentation/
    routine/
      domain/
      application/
      presentation/
    settings/
      domain/
      application/
      presentation/
    statistics/
      domain/
      application/
      presentation/
    notifications/
      application/

  shared/
    widgets/
    models/
```

## State Management
* Use **Bloc** as the default app state management solution.
* Do **NOT** use Cubit, Riverpod, Provider, ChangeNotifier, GetX, or other app-level state solutions unless explicitly requested.
* Keep short-lived widget-local UI state local to the widget when appropriate.
* Use **one Bloc per feature or clear use case**, not one giant global Bloc.
* Typical examples for this project are `TimerBloc`, `RoutineSettingsBloc`, `TransitionConfirmationBloc`, and `DailyStatsBloc`.

## Routing
* Use **`go_router`** for app navigation.
* Keep route setup centralized once the app grows beyond the first screens.
* Use routing in a way that works cleanly on both **web** and **mobile**.
* Do not fall back to ad-hoc navigation patterns if `go_router` already covers the use case.

## Persistence
* Use **SQLite** as the local persistence layer.
* The schema should be structured in a way that can later evolve toward a backend-backed model.
* Do not scatter raw persistence logic throughout the UI.
* Access persistent data through repository/data source abstractions.

## Notifications
* On **mobile**, use **`flutter_local_notifications`** for local notifications.
* On **web**, use a **best-effort browser/in-app reminder approach**.
* Do not assume web notifications have feature parity with mobile background notification behavior.
* Notification behavior should remain calm and functional, not noisy.

## Code Quality
* Apply SOLID principles where they help maintainability.
* Prefer composition over inheritance.
* Prefer immutable data structures and immutable widgets.
* Keep functions short and single-purpose.
* Avoid abbreviations; use `PascalCase` for classes, `camelCase` for members, and `snake_case` for files.
* Use `dart:developer` `log` instead of `print`.
* Avoid expensive operations in `build()`.
* Use `const` constructors wherever possible.

## Dart & Flutter Best Practices
* Follow Effective Dart.
* Use sound null-safe code.
* Use `async`/`await` for asynchronous logic.
* Use pattern matching, records, and modern Dart features when they improve clarity.
* Prefer smaller reusable widgets over large widget trees in a single file.
* Use builder constructors for long lists and grids.
* Use `compute()` for expensive parsing or calculations when needed.

## Serialization
* Use `json_serializable` and `json_annotation` when model serialization is needed.
* Keep serialized models explicit and predictable.

## Design Rules
* The product should feel **quiet**, **minimal**, **supportive**, and **not pushy**.
* Prioritize clarity over visual complexity.
* Use icons only when they improve understanding.
* Keep interactive feedback subtle.
* Maintain visual consistency across timer, settings, confirmation, and statistics flows.

## Jira Workflow Rules
* Jira is the source of truth for planning and execution tracking.
* Use the matching Jira issue for every meaningful coding task.
* Codex is allowed to:
  * move Jira tasks between statuses,
  * write Jira comments,
  * work from Jira-defined priorities and backlog order.
* Do not write parallel planning files in the repo when Jira already holds the task planning.

## Git Workflow
* Use **one branch per Jira task**.
* The branch name must be exactly the **Jira key** (for example: `P2-11`).
* After implementation, open a **PR** instead of pushing unfinished work directly to `master`.
* PRs may be opened by Codex.
* Keep commits focused and traceable to the Jira task being worked on.
* Merge should happen only after explicit human approval.

## Review Workflow
* Before opening any PR, Codex must perform a **self-review** of the implemented work.
* After the PR is opened, run a **separate review pass** before merge.
* The implementation pass and the review pass should be treated as different steps.
* Move the Jira task to **Review** when the PR is open and ready for checking.
* Move the Jira task to **Done** only after review is complete and the change is merged.

## Testing Requirements
* Follow test-driven development whenever practical.
* Every Jira task should include appropriate tests.
* Use the most suitable test type for the problem:
  * **unit tests** for pure logic,
  * **Bloc tests** for state transitions and event handling,
  * **integration/widget tests** where behavior spans UI and app flow.
* New business logic must not be added without tests.
* Bug fixes should include a regression test whenever possible.
* A task is only considered done when implementation and relevant tests are complete and passing.

## Analysis Options
Strictly follow `flutter_lints`.

```yaml
include: package:flutter_lints/flutter.yaml
linter:
  rules:
    avoid_print: true
    prefer_single_quotes: true
    always_use_package_imports: true
```
