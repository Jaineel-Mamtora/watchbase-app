# WatchBase Architecture

## Product Snapshot

- **Product**: WatchBase
- **Current implemented user-facing feature**: Home screen with two horizontally scrollable TMDB sections:
  - Popular Movies
  - Top Rated Movies
- **Runtime targets**: Flutter app (Android, iOS, Web scaffolding present)
- **Routing**: Single route (`/`) to `HomePage`

## Tech Stack

- **Framework**: Flutter
- **State management**: `bloc` + `flutter_bloc`
- **Navigation**: `go_router`
- **Dependency injection**: `get_it`
- **Networking**: `dio`
- **Functional result type**: `fpdart` (`Either`)
- **Data modeling/codegen**: `freezed`, `json_serializable`
- **Image loading/caching**: `cached_network_image`
- **Theming**: Material 3 + Cupertino theme wrapper + `dynamic_color`

## High-Level Architecture

The codebase follows a feature-first, clean-ish layering pattern:

- `presentation` (UI + Bloc)
- `domain` (entities, repository contracts, use cases)
- `data` (remote data source, DTO models, repository implementation)
- `core` (networking, config, failures/utilities, DI)

Top-rated request flow:

1. `HomePage` subscribes to `TopRatedMoviesBloc`.
2. `TopRatedMoviesBloc` handles `TopRatedMoviesFetch` and emits loading.
3. Bloc calls `GetTopRatedMovies`.
4. Use case calls `MoviesRepository.getTopRatedMovies()`.
5. `MoviesRepositoryImpl` calls `MoviesRemoteDataSource.fetchTopRatedMovies()`.
6. Data source resolves `MovieListCategory.topRated` to `GET /3/movie/top_rated` and calls `DioClient`.
7. Response JSON is parsed as `PopularMoviesModel` (aliased as `TopRatedMoviesModel`) and mapped to `List<TopRatedMovie>`.
8. Bloc emits `TopRatedMoviesSuccess` or `TopRatedMoviesError`.

## App Bootstrap and Composition

- `lib/main.dart`
  - Initializes Flutter bindings and DI (`initDependencies()`).
  - Provides both `PopularMoviesBloc` and `TopRatedMoviesBloc`.
  - Immediately dispatches `PopularMoviesFetch` and `TopRatedMoviesFetch`.

- `lib/app/app.dart`
  - Root shell via `MaterialApp.router`.
  - Resolves dynamic/fallback color schemes asynchronously.
  - Wraps subtree with `CupertinoTheme` on iOS.

- `lib/app/router.dart`
  - Single `GoRoute`: `/` -> `HomePage`.

## Dependency Injection Graph

Configured in `lib/core/di/di.dart`:

- Singleton: `DioClient`
- Lazy singleton: `MoviesRemoteDataSource`
- Lazy singleton: `MoviesRepository` -> `MoviesRepositoryImpl`
- Lazy singleton: `GetPopularMovies`
- Lazy singleton: `GetTopRatedMovies`
- Factory: `PopularMoviesBloc`
- Factory: `TopRatedMoviesBloc`

Chains:

- `PopularMoviesBloc -> GetPopularMovies -> MoviesRepository -> MoviesRemoteDataSource -> DioClient`
- `TopRatedMoviesBloc -> GetTopRatedMovies -> MoviesRepository -> MoviesRemoteDataSource -> DioClient`

## Feature: Home (Popular + Top Rated)

### Presentation Layer

- `lib/features/home/presentation/pages/home_page.dart`
  - Renders a `ListView` with two sections:
    - `_PopularMoviesSectionView`
    - `_TopRatedMoviesSectionView`
  - Each section shows loader, movie list, or inline error state.

- `lib/features/home/presentation/bloc/popular_movies_bloc.dart`
  - Event: `PopularMoviesFetch`
  - States: `Initial`, `Loading`, `Success(List<PopularMovie>)`, `Error(String)`

- `lib/features/home/presentation/bloc/top_rated_movies_bloc.dart`
  - Event: `TopRatedMoviesFetch`
  - States: `Initial`, `Loading`, `Success(List<TopRatedMovie>)`, `Error(String)`

- `lib/features/home/presentation/widgets/movie_list_section.dart`
  - Shared horizontal section widget for both categories.
  - Uses `MovieListItem` interface so it can render `PopularMovie` and `TopRatedMovie`.

- `lib/features/home/presentation/widgets/movie_card.dart`
  - Reusable poster card with `CachedNetworkImage` and platform-aware shaping.

### Domain Layer

- `lib/features/home/domain/entities/movie_list_item.dart`
  - Common interface used by list UI.

- `lib/features/home/domain/entities/popular_movie.dart`
- `lib/features/home/domain/entities/top_rated_movie.dart`
  - Category-specific entities implementing `MovieListItem`.

- `lib/features/home/domain/entities/movie_list_category.dart`
  - Enum used by data source path selection (`popular`, `topRated`).

- `lib/features/home/domain/repositories/movies_repository.dart`
  - Contract for both `getPopularMovies()` and `getTopRatedMovies()`.

- `lib/features/home/domain/usecases/get_popular_movies.dart`
- `lib/features/home/domain/usecases/get_top_rated_movies.dart`

### Data Layer

- `lib/features/home/data/datasources/movies_remote_data_source.dart`
  - Exposes:
    - `fetchPopularMovies()`
    - `fetchTopRatedMovies()`
    - shared `fetchMovies(MovieListCategory category)`
  - Maps category to TMDB endpoints:
    - `/3/movie/popular`
    - `/3/movie/top_rated`
  - Validates status code and `results`; throws `Failure` types on invalid responses.

- `lib/features/home/data/models/movies_list_model.dart`
  - Type aliases:
    - `MoviesListModel = PopularMoviesModel`
    - `TopRatedMoviesModel = PopularMoviesModel`

- `lib/features/home/data/models/popular_movies_model.dart`
  - DTO + mappers:
    - `toPopularEntity()`
    - `toTopRatedEntity()`

- `lib/features/home/data/models/movie_model.dart`
  - Per-item DTO used in `results`.

- `lib/features/home/data/repositories/movies_repository_impl.dart`
  - Converts datasource output to entities and wraps errors into `Either<Failure, ...>`.

## Core Infrastructure

- `lib/core/config/app_config.dart`
  - Runtime config from `--dart-define`.

- `lib/core/network/dio_client.dart`
  - Centralized HTTP client:
    - base URL from config
    - timeout defaults
    - JSON response type
    - automatic `api_key` query injection

- `lib/core/network/tmdb_image_url_builder.dart`
  - Builds poster URLs from TMDB image base defines.

- `lib/core/utils/failure.dart`
  - Shared failures:
    - `ServerFailure`
    - `ConnectionFailure`
    - `ParsingFailure`
    - `NotFoundFailure`

## Configuration Requirements

Required `--dart-define` values:

- `TMDB_API_BASE_URL`
- `TMDB_API_KEY`
- `TMDB_IMAGE_BASE_URL_W500`
- `TMDB_IMAGE_BASE_URL_ORIGINAL`

## Testing Architecture

Current tests cover both popular and top-rated paths in home feature:

- `movies_remote_data_source_test.dart`
  - popular fetch validations
  - top-rated endpoint success path
- `movies_repository_impl_test.dart`
  - popular and top-rated mapping/error behavior
- `get_popular_movies_test.dart`, `get_top_rated_movies_test.dart`
  - use-case pass-through behavior
- `popular_movies_bloc_test.dart`, `top_rated_movies_bloc_test.dart`
  - bloc state transitions for success/failure

## Current Scope and Gaps

- Home feature supports read-only listing for popular and top-rated movies.
- No auth, search, detail page navigation, pagination UI, or local/offline persistence yet.
- Router remains single-route.
