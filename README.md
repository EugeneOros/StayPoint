# StayPoint - Hotel Booking App

A modern Flutter hotel booking application built with Clean Architecture, BLoC state management, and comprehensive local storage. The app demonstrates best practices in Flutter development including dependency injection, localization, deep linking, and comprehensive testing.

[screen_recording.webm](https://github.com/user-attachments/assets/3bfc822f-9927-4ef0-87fe-364c62c6fe73)



## 📱 Features

### Core Features
- **🏨 Hotels Discovery**: Browse and explore hotels with detailed information
- **❤️ Favorites Management**: Save and manage favorite hotels with local persistence
- **🌍 Multi-language Support**: English, German (default), and Polish
- **🔗 Deep Linking**: Navigate directly to hotels or favorites tabs via deep links
- **🎨 Modern UI**: Beautiful, consistent design system with smooth animations
- **📱 Responsive Design**: Optimized for various screen sizes

### Technical Features
- **Clean Architecture**: Clear separation of concerns across layers
- **BLoC State Management**: Predictable state management with reactive updates
- **Dependency Injection**: Injectable for automatic DI setup
- **Local Storage**: Hive for fast, efficient local data persistence
- **Error Handling**: Comprehensive error handling with Result pattern
- **Stream-based Communication**: Reactive updates across the app
- **Comprehensive Testing**: Unit tests, widget tests, and cubit tests

## 🏗️ Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────┐
│                  Presentation Layer                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Pages      │  │   Widgets    │  │   Cubits     │  │
│  │              │  │              │  │              │  │
│  │ - HotelsPage │  │ - HotelCard  │  │ - HotelsCubit│  │
│  │ - Favorites  │  │ - ErrorWidget│  │ - Favorites  │  │
│  │ - Account    │  │ - Loading    │  │ - LocaleCubit│  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────┐
│                    Domain Layer                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Entities   │  │   Services   │  │  Exceptions  │  │
│  │              │  │              │  │              │  │
│  │ - Hotel      │  │ - HotelService│ │ - AppException│ │
│  │ - Rating     │  │ - LocaleService││ - HotelException││
│  │ - BestOffer  │  │ - MainStream │  │              │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────┐
│                     Data Layer                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │    DTOs      │  │ Data Sources │  │  Services    │  │
│  │              │  │              │  │              │  │
│  │ - HotelDto   │  │ - Remote     │  │ - HotelRepo  │  │
│  │ - RatingDto  │  │ - Local(Hive)│  │ - LocaleRepo │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

#### Presentation Layer
- **Pages**: UI screens that compose widgets and handle navigation
- **Widgets**: Reusable UI components (HotelCard, ErrorWidget, EmptyPageWidget)
- **Cubits**: State management using BLoC pattern
  - `HotelsCubit`: Manages hotel list state and favorite IDs
  - `FavoritesCubit`: Manages favorites state and operations
  - `LocaleCubit`: Manages app locale/language state

#### Domain Layer
- **Entities**: Pure business objects (Hotel, Rating, BestOffer)
- **Services**: Abstract interfaces defining business operations
- **Exceptions**: Domain-specific exceptions extending AppException
- **Result Pattern**: Type-safe error handling (`Result<T, E>`)

#### Data Layer
- **DTOs**: Data Transfer Objects with JSON serialization
- **Data Sources**: 
  - Remote: HTTP API calls
  - Local: Hive database for favorites
- **Service Implementations**: Concrete implementations of domain services

## 🎨 Design System

The app uses a comprehensive design system for consistency:

### Colors (`lib/theme/colors.dart`)
- **Primary**: `AppColors.blue`, `AppColors.backgroundBrand`
- **Semantic**: `AppColors.red` (errors), `AppColors.green` (success)
- **Content**: `AppColors.white`, `AppColors.dark`, `AppColors.contentSecondary`
- **Gradients**: Predefined gradients for visual effects

### Dimensions (`lib/theme/dimens.dart`)
- Consistent spacing values: `Dimens.xs` (4), `Dimens.s` (8), `Dimens.m` (16), etc.
- Border radius values
- Size constants

### Typography (`lib/theme/text_theme.dart`)
- Semantic text styles: `AppTextTheme.mainTitle`, `AppTextTheme.title`, `AppTextTheme.body`
- Consistent font sizes and weights
- Color variants for different contexts

## 🔑 Key Design Decisions

### 1. Clean Architecture
**Why**: Separation of concerns, testability, maintainability
- Domain layer is independent of frameworks
- Easy to swap data sources (API, local storage)
- Business logic is isolated and testable

### 2. BLoC Pattern with Cubits
**Why**: Predictable state management, reactive UI updates
- Clear data flow: UI → Cubit → Service → Repository
- Easy to test state transitions
- Built-in support for async operations

### 3. Result Pattern
**Why**: Type-safe error handling without exceptions
```dart
Future<Result<T, Exception>> method() async {
  try {
    return Success(value);
  } catch (e) {
    return Failure(Exception(e.toString()));
  }
}
```
- Forces explicit error handling
- No hidden exceptions
- Pattern matching with switch expressions

### 4. Injectable for Dependency Injection
**Why**: Automatic DI setup, reduces boilerplate
- Annotations-based: `@injectable`, `@lazySingleton`
- Code generation handles wiring
- Easy to mock for testing

### 5. Hive for Local Storage
**Why**: Fast, lightweight, type-safe
- No SQL needed for simple key-value storage
- Type adapters for complex objects
- Efficient for favorites persistence

### 6. Stream-based Communication
**Why**: Reactive updates across the app
- `MainStreamService` broadcasts events (e.g., favorite updates)
- Cubits listen and react automatically
- Decoupled communication between features

### 7. HookWidget for Stateful UI
**Why**: Less boilerplate, cleaner code
- `useBloc`, `useBlocBuilder` for BLoC integration
- `useState`, `useEffect` for local state
- No need for StatefulWidget in most cases

### 8. Comprehensive Localization
**Why**: Internationalization from the start
- All UI strings in `.arb` files
- Three languages: English, German (default), Polish
- Easy to add more languages

## 📁 Project Structure

```
lib/
├── core/
│   ├── assets/              # Asset paths (icons, illustrations)
│   └── injection/           # Dependency injection setup
│       ├── injection.dart   # Main DI configuration
│       └── injection_module.dart
│
├── data/
│   ├── hotels/
│   │   ├── data_source/     # Remote and local data sources
│   │   ├── models/          # DTOs with JSON serialization
│   │   └── service/         # Repository implementations
│   ├── locale/              # Locale data sources and services
│   └── main_stream/         # Stream service implementation
│
├── domain/
│   ├── hotels/
│   │   ├── models/          # Business entities (Hotel, Rating, etc.)
│   │   └── service/         # Service interfaces
│   ├── locale/              # Locale service interface
│   └── main_stream/         # Stream service interface
│
├── presentation/
│   ├── pages/
│   │   ├── hotels/         # Hotels page with cubit
│   │   ├── favorites/      # Favorites page with cubit
│   │   ├── account/        # Account page with locale cubit
│   │   ├── overview/       # Overview/welcome page
│   │   └── home/           # Main navigation page
│   └── widgets/
│       ├── hotel_card/     # Hotel card components
│       ├── empty_page_widget.dart
│       ├── error_widget.dart
│       └── loading_widget.dart
│
├── shared/
│   ├── exceptions/          # Custom exceptions
│   ├── result.dart         # Result pattern
│   └── utils/              # Utilities (logger, etc.)
│
├── theme/                   # Design system
│   ├── colors.dart
│   ├── dimens.dart
│   ├── text_theme.dart
│   └── theme.dart
│
└── l10n/                    # Localization files
    ├── app_en.arb
    ├── app_de.arb
    ├── app_pl.arb
    └── app_localizations.dart (generated)

test/
├── helpers/
│   └── test_helpers.dart   # Test utilities
└── presentation/
    ├── pages/              # Page and cubit tests
    └── widgets/            # Widget tests
```

## 🚀 Setup Instructions

### Prerequisites

- **Flutter SDK**: 3.9.2 or higher
- **Dart SDK**: 3.9.2 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development on macOS)
- **Android SDK** (for Android development)

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd checklist_app
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code** (required for JSON serialization and dependency injection):
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```
   
   This generates:
   - JSON serialization code for DTOs
   - Injectable dependency injection configuration
   - Localization files

4. **Generate localization files**:
   ```bash
   flutter gen-l10n
   ```
   
   This generates `app_localizations.dart` from `.arb` files.

5. **Configure launcher icons** (optional):
   ```bash
   flutter pub run flutter_launcher_icons
   ```

6. **Configure splash screen** (optional):
   ```bash
   flutter pub run flutter_native_splash:create
   ```

## 🏃 Running the App

### Run on Connected Device/Emulator

```bash
# List available devices
flutter devices

# Run on default device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

### Platform-Specific Commands

**Android**:
```bash
flutter run -d android
```

**iOS** (macOS only):
```bash
flutter run -d ios
```

### Hot Reload & Hot Restart

- **Hot Reload**: Press `r` in the terminal (preserves state)
- **Hot Restart**: Press `R` in the terminal (resets state)
- **Quit**: Press `q` in the terminal

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/presentation/pages/hotels/cubit/hotels_cubit_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in watch mode (auto-rerun on changes)
flutter test --watch
```

### Test Structure

#### Unit Tests (Cubits)
Located in `test/presentation/pages/*/cubit/`:
- Test state transitions
- Test business logic
- Mock dependencies using `mocktail`

Example:
```dart
blocTest<HotelsCubit, HotelsState>(
  'emits [loading, success] when loadHotels succeeds',
  build: () => HotelsCubit(mockService, mockStreamService),
  act: (cubit) => cubit.loadHotels(),
  expect: () => [
    HotelsState(status: HotelsStatus.loading),
    HotelsState(status: HotelsStatus.loaded, hotels: testHotels),
  ],
);
```

#### Widget Tests
Located in `test/presentation/widgets/`:
- Test UI rendering
- Test user interactions
- Test widget behavior

Example:
```dart
testWidgets('displays hotel name', (tester) async {
  await tester.pumpWidget(
    createTestApp(HotelCard(hotel: testHotel)),
  );
  expect(find.text(testHotel.name), findsOneWidget);
});
```

### Test Coverage

The app includes comprehensive test coverage:
- ✅ Cubit state management tests
- ✅ Widget rendering tests
- ✅ User interaction tests
- ✅ Error handling tests
- ✅ Localization tests

## 🔗 Deep Linking

The app supports deep linking to navigate directly to specific tabs:

### Supported Links

- `hotelbooking://hotels` - Opens Hotels tab
- `hotelbooking://favorites` - Opens Favorites tab

### Testing Deep Links

**Android**:
```bash
adb shell am start -W -a android.intent.action.VIEW -d "hotelbooking://hotels" com.example.checklist_app
```

**iOS** (Simulator):
```bash
xcrun simctl openurl booted "hotelbooking://hotels"
```

**From Browser/HTML**:
```html
<a href="hotelbooking://hotels">Open Hotels</a>
<a href="hotelbooking://favorites">Open Favorites</a>
```

See `DEEPLINK_GUIDE.md` for detailed instructions.

## 📦 Dependencies

### Core Dependencies

- **`flutter_bloc`** (^8.1.6): State management
- **`hooked_bloc`** (^1.5.0): BLoC hooks for HookWidget
- **`bloc_presentation`** (^1.0.1): One-time events from cubits
- **`injectable`** (^1.7.0): Dependency injection
- **`hive`** / **`hive_flutter`** (^2.2.3): Local storage
- **`http`** (^1.2.2): HTTP client
- **`equatable`** (^2.0.5): Value equality
- **`flutter_svg`** (^2.0.10+1): SVG support
- **`package_info_plus`** (^9.0.0): App version info

### Dev Dependencies

- **`build_runner`**: Code generation
- **`json_serializable`**: JSON code generation
- **`bloc_test`**: BLoC testing utilities
- **`mocktail`**: Mocking for tests
- **`flutter_launcher_icons`**: Icon generation
- **`flutter_native_splash`**: Splash screen generation

## 🌍 Localization

The app supports three languages:
- **English (en)**
- **German (de)** - Default language
- **Polish (pl)**

### Adding New Strings

1. Add to `lib/l10n/app_en.arb`:
   ```json
   {
     "myNewString": "My New String",
     "@myNewString": {
       "description": "Description of the string"
     }
   }
   ```

2. Add translations to `app_de.arb` and `app_pl.arb`

3. Generate localization:
   ```bash
   flutter gen-l10n
   ```

4. Use in code:
   ```dart
   Text(AppLocalizations.of(context)!.myNewString)
   ```

## 🎯 State Management Flow

### Hotels Page Flow

```
User Action
    ↓
HotelsPage (UI)
    ↓
HotelsCubit.loadHotels()
    ↓
HotelService.getHotels()
    ↓
HotelRepositoryImpl (Data Layer)
    ↓
HotelRemoteDataSource (API Call)
    ↓
Success/Failure Result
    ↓
HotelsCubit emits new state
    ↓
HotelsPage rebuilds with new state
```

### Favorites Flow

```
User Taps Heart Icon
    ↓
HotelCard.onToggleFavorite()
    ↓
HotelsCubit.toggleFavorite()
    ↓
HotelService.toggleFavorite()
    ↓
HotelRepositoryImpl (Hive operations)
    ↓
MainStreamService.add(UpdateFavoritesItemsEvent)
    ↓
FavoritesCubit listens → loadFavorites()
HotelsCubit listens → _loadFavoriteIds()
    ↓
Both cubits update their states
    ↓
UI updates reactively
```

## 🔧 Code Generation

The app uses code generation for:
- JSON serialization (DTOs)
- Dependency injection (Injectable)
- Localization (Flutter l10n)

### Regenerating Code

```bash
# Generate all code
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on changes)
flutter packages pub run build_runner watch --delete-conflicting-outputs

# Generate localization
flutter gen-l10n
```

## 🐛 Troubleshooting

### Common Issues

1. **Build Runner Errors**:
   ```bash
   flutter clean
   flutter pub get
   flutter packages pub run build_runner clean
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

2. **Localization Not Working**:
   ```bash
   flutter gen-l10n
   flutter clean
   flutter run
   ```

3. **Dependency Injection Errors**:
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Tests Failing**:
   ```bash
   flutter test --no-pub
   ```

## 📝 Code Style

The app follows Flutter/Dart best practices:
- **Package imports** (not relative imports)
- **Const constructors** where possible
- **Semantic naming** for clarity
- **Design system** usage (no hardcoded values)
- **Result pattern** for error handling
- **Comprehensive comments** only when necessary

## 🚧 Future Enhancements

- [ ] Hotel detail page with booking functionality
- [ ] Search and filter hotels
- [ ] User authentication
- [ ] Booking history
- [ ] Push notifications
- [ ] Offline mode with sync
- [ ] Image caching optimization
- [ ] Pull-to-refresh
- [ ] Infinite scroll pagination
- [ ] Advanced filtering (price, rating, location)

## 📄 License

This project is part of a coding assignment.

## 👤 Author

Built as a demonstration of Flutter best practices including:
- Clean Architecture
- BLoC State Management
- Dependency Injection
- Comprehensive Testing
- Localization
- Deep Linking
- Modern UI/UX Design

---

**StayPoint** - Your gateway to amazing hotel experiences! 🏨✨
