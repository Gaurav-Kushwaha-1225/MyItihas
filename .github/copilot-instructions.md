# MyItihas - AI Coding Agent Instructions

## Project Overview
Flutter app for cultural/historical stories, featuring social feeds, chat, story generation, and map features. Uses **Supabase** backend with offline-first local storage via **Hive**.

## Architecture: Clean Architecture + DDD

### Feature Structure (follow strictly)
```
lib/features/<feature_name>/
├── domain/           # Pure Dart, NO external dependencies
│   ├── entities/     # Immutable with @freezed (no fromJson)
│   ├── repositories/ # Abstract contracts only
│   └── usecases/     # Single-purpose, extends UseCase<T, Params>
├── data/
│   ├── models/       # @freezed with fromJson/toJson, toDomain() method
│   ├── datasources/  # Local (Hive) & Remote (Supabase) implementations
│   └── repositories/ # Implements domain interface, handles Either<Failure, T>
└── presentation/
    ├── bloc/         # @injectable, events/states use @freezed sealed classes
    ├── pages/
    └── widgets/
```

### Key Patterns

**Use Cases**: Always return `Future<Either<Failure, T>>` using fpdart:
```dart
@lazySingleton
class GetStories implements UseCase<List<Story>, GetStoriesParams> {
  final StoryRepository repository;
  GetStories(this.repository);
  
  @override
  Future<Either<Failure, List<Story>>> call(GetStoriesParams params) async {
    return await repository.getStories(...);
  }
}
```

**BLoC Events/States**: Use freezed sealed classes with factory constructors:
```dart
@freezed
sealed class StoriesEvent with _$StoriesEvent {
  const factory StoriesEvent.loadStories() = _LoadStories;
  const factory StoriesEvent.searchStories(String query) = _SearchStories;
}
```

**Error Handling**: Throw `AppException` subtypes in data layer → catch and return `Failure` subtypes from `lib/core/errors/`

## Dependency Injection
- Uses **injectable** + **get_it** with auto-registration
- Annotate: `@injectable` (transient), `@lazySingleton`, `@LazySingleton(as: Interface)`
- Entry point: `lib/core/di/injection_container.dart`
- Third-party deps registered in `ThirdPartyModule`

## Code Generation (CRITICAL)
Run after modifying `@freezed`, `@injectable`, i18n files, or routes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files: `*.freezed.dart`, `*.g.dart`, `injection_container.config.dart`, `routes.g.dart`, `strings.g.dart`

## Internationalization (Slang)
- Translation files: `lib/i18n/strings_<locale>.i18n.json` (en, hi, ta, te)
- Access: `context.t.key` or import `strings.g.dart` → `t.key`
- Config: `slang.yaml` (uses double_braces interpolation)

## Routing (go_router + TypedGoRoute)
- Define routes in `lib/config/routes.dart` using `@TypedGoRoute` annotations
- Routes generate to `routes.g.dart`
- Navigate: `const HomeRoute().go(context)` or `context.go('/home')`

## Logging (Talker)
Use global `talker` instance from `lib/core/logging/talker_setup.dart`:
```dart
talker.info('Loading stories...');
talker.error('Failed to load', exception, stackTrace);
talker.good('Successfully completed');
```

## Theming
- Material 3 with seed-based ColorScheme
- Theme files: `lib/config/theme/` (app_theme, color_schemes, component_themes)
- Access custom gradients via `Theme.of(context).extension<GradientExtension>()`

## Services Layer
Global services in `lib/services/` (not Clean Architecture features):
- `SupabaseService`: Static singleton, initialize in main before runApp
- `AuthService`: Handles auth flows, deep links
- `ProfileService`, `FollowService`: Social features

## Key Commands
```bash
flutter pub get                                    # Install dependencies
dart run build_runner build --delete-conflicting-outputs  # Generate code
dart run build_runner watch --delete-conflicting-outputs  # Watch mode
flutter run                                        # Run app
```

## File Naming Conventions
- Entities: `story.dart` → generates `story.freezed.dart`
- Models: `story_model.dart` → generates `*.freezed.dart`, `*.g.dart`
- BLoC: `stories_bloc.dart`, `stories_event.dart`, `stories_state.dart`
- Pages: `story_detail_page.dart`
