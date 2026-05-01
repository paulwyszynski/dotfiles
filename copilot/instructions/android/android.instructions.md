---
applyTo: "**/*.kt,**/*.kts,**/AndroidManifest.xml,**/build.gradle.kts,**/build.gradle"
---

# Android Expert Instructions

## Architecture

- MVVM + clean architecture; strict layer separation: data → domain → presentation (UI)
- SOLID principles in all layers
- Unidirectional data flow (UDF): events flow up (UI → ViewModel), state flows down (ViewModel → UI)
- No business logic in Composables or Activities/Fragments

## ViewModel + UI State

- Every screen has one ViewModel with a single `UiState` sealed class or data class
- Expose state as `StateFlow<UiState>` (never `LiveData`)
- Expose one-shot events (navigation, snackbars) via `Channel<UiEvent>` collected as `Flow`
- UI collects state with `collectAsStateWithLifecycle()`
- ViewModel only exposes `fun onEvent(event: UiEvent)` or specific intent functions — UI never writes state directly

Example pattern:
```kotlin
data class MyScreenState(
    val isLoading: Boolean = false,
    val items: List<Item> = emptyList(),
    val error: String? = null,
)

class MyViewModel(private val useCase: GetItemsUseCase) : ViewModel() {
    private val _state = MutableStateFlow(MyScreenState())
    val state: StateFlow<MyScreenState> = _state.asStateFlow()

    fun loadItems() {
        viewModelScope.launch {
            _state.update { it.copy(isLoading = true) }
            useCase().fold(
                onSuccess = { items -> _state.update { it.copy(isLoading = false, items = items) } },
                onFailure = { e -> _state.update { it.copy(isLoading = false, error = e.message) } },
            )
        }
    }
}
```

## Language

- Kotlin only; idiomatic Kotlin throughout
- Data classes for models and UI state
- Sealed classes/interfaces for events, results, and navigation
- Extension functions over utility classes
- `when` must be exhaustive (no else on sealed types)
- No nullable types without explicit justification; prefer `Result<T>` or `Either`

## UI

- Jetpack Compose only (no XML layouts unless maintaining legacy code)
- Stateless Composables; hoist all state to ViewModel
- `collectAsStateWithLifecycle()` for state collection (not `collectAsState()`)
- Separate screen Composable (wires ViewModel) from content Composable (pure UI, previewable)

## Async

- Kotlin Coroutines + Flow everywhere
- `viewModelScope.launch` in ViewModel; `lifecycleScope` in UI layer only when necessary
- No RxJava, no raw threads, no `GlobalScope`
- Use `callbackFlow` to wrap callback-based APIs

## Dependency Injection

- Hilt only
- `@HiltViewModel` for all ViewModels
- `@Singleton` for repository/data-source scope; `@ActivityRetainedScoped` for ViewModel-scoped deps

## Networking

- Retrofit + OkHttp
- `kotlinx.serialization` (not Gson, not Moshi)
- Repository pattern: network calls never exposed outside data layer
- Wrap responses in `Result<T>` before crossing the domain boundary

## Navigation

- Jetpack Navigation with Compose destinations
- Type-safe routes via `@Serializable` data classes (Navigation 2.8+)
- Navigation events emitted from ViewModel via `Channel`, collected in UI

## Testing

- JUnit5 + MockK for unit tests
- Turbine for Flow testing
- Compose UI test APIs for UI tests
- Test ViewModels in isolation; inject fake repositories

## Context7

Use context7 MCP for all Jetpack/Android library API lookups (Compose, Hilt, Navigation, Coroutines, Retrofit, etc.).
