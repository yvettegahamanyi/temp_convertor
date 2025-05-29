# Temperature Conversion Application

temperature conversion application is a mobile app that allow the user to select either Fahrenheit-to-Celsius or Celsius-to-Fahrenheit conversions and convert a given temperature.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yvettegahamnayi/temp_convertor.git
   cd temp_convertor
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**

```bash
flutter build apk --release
```

**iOS (requires macOS):**

```bash
flutter build ios --release
```

## Conversion Formulas

The app uses the standard temperature conversion formulas:

**Fahrenheit to Celsius:**

```
°C = (°F - 32) × 5/9
```

**Celsius to Fahrenheit:**

```
°F = °C × 9/5 + 32
```
