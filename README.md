# Form&Fun Flutter Exercise

<p align="center">
  <img src="assets/images/ff_logo.png" alt="Form&Fun Logo" width="120"/>
</p>

<p align="center">
  <strong>Flutter UI Challenge - Interactive Cards & Animations</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#packages-used">Packages</a> •
  <a href="#project-structure">Structure</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#testing">Testing</a>
</p>

---

## Overview

This repository contains two UI exercises implemented in Flutter with focus on **pixel-perfect** design, smooth animations, and responsive behavior. The project follows DDD (Domain-Driven Design) architecture with a feature-first approach.

## Features

### General

- Custom Launcher Icon
- Custom App Name: "Form&Fun" (release) / "Form&Fun (Debug)" (debug)
- Responsive design system with custom sizing extensions (`.w`, `.h`, `.sp`)
- **Internationalization (i18n)**: PT-BR and EN-US support with GetX
- **Dynamic Dark Mode**: System-aware theme switching
- **Accessibility**: Semantics widgets for screen readers

### Exercise 1: Interactive Card with Percentage Border

- Lottie animated icon with continuous loop
- Animated border that fills based on elapsed time (0-100%)
- Background glow effect indicating active state
- Elapsed time counter display
- Accessibility labels with Semantics
- Dynamic colors for dark mode support

### Exercise 2: Scrollable Content with Animated Footer

- Scrollable page with main card (16:9 image)
- Content section with icon, title/subtitle, and button
- **Blur overlay** with hide animation when scroll reaches bottom
- **Animated footer card** that slides up based on main card visibility
- **Double-back-to-exit** with snackbar notification (2s window)
- **Micro-animations** with haptic feedback on button press (using GetX)
- **SVG adaptive colors**: Tag icon turns white in dark mode
- Error handling for URL launcher
- All text internationalized (PT-BR/EN-US)

## Design & Assets

| Resource | Link |
|----------|------|
| Figma Design | [View Design](https://www.figma.com/design/ObMbtPPyWu7VjjMaus2Hpx/Flutter-Dev---Exercice) |
| Assets | [Google Drive](https://drive.google.com/drive/folders/1_BeEUqMfPyeodtvOz2m-tJq4ieqaLi-C) |

## Packages Used

| Package | Version | Description |
|---------|---------|-------------|
| **get** | ^4.6.6 | State management, i18n, and navigation |
| **get_it** | ^8.0.3 | Dependency injection |
| **lottie** | ^3.3.1 | High-performance Lottie animations rendering |
| **flutter_svg** | ^2.0.16 | SVG rendering for scalable vector graphics |
| **url_launcher** | ^6.2.5 | Open URLs in browser |
| **golden_toolkit** | ^0.15.0 | Golden tests for visual regression testing |
| **widgetbook** | ^3.20.2 | Widget catalog and testing |

### Package Details

1. **get (GetX)**
   - State management with reactive observables (`.obs`, `Obx`)
   - Internationalization with `Translations` class
   - Used for micro-animations state and i18n

2. **lottie**
   - Renders After Effects animations exported as JSON
   - Used for animated icon in Exercise 1 (`searching.json`)
   - Used in Widgetbook home page (`formAndFun_lottie.json`)

3. **flutter_svg**
   - Renders SVG images maintaining quality at any scale
   - Supports `colorFilter` for dynamic theming (dark mode)

4. **golden_toolkit**
   - Multi-device golden testing support
   - Generates visual snapshots for regression testing
   - Tests across iPhone 6, iPhone 16 Pro/Max, and Tablets

## Project Structure

```plaintext
lib/
├── main.dart                      # Entry point
├── app/
│   ├── app.dart                   # GetMaterialApp with i18n config
│   └── routes.dart                # Named routes
├── core/
│   ├── l10n/
│   │   └── app_translations.dart  # PT-BR/EN-US translations
│   ├── theme/
│   │   ├── app_colors.dart        # Colors + AppColorsExtension (dark mode)
│   │   ├── app_typography.dart    # Aktiv Grotesk text styles
│   │   └── app_theme.dart         # Light/Dark ThemeData
│   ├── utils/
│   │   ├── assets.dart            # Asset paths helper
│   │   ├── measurements.dart      # Responsive sizing (.w, .h, .sp)
│   │   └── navigator.dart         # MState base class
│   ├── infrastructure/
│   │   └── injections/            # GetIt dependency injection
│   └── shared/
│       └── presentation/
│           ├── controller/
│           │   └── base_controller.dart
│           ├── backgrounds/
│           │   └── base_background.dart
│           └── widgets/           # Reusable widgets
├── features/
│   ├── exercise_1/
│   │   └── presentation/
│   │       ├── controller/
│   │       │   └── exercise_1_controller.dart
│   │       ├── pages/
│   │       │   └── exercise_1_page.dart
│   │       └── widgets/
│   │           └── exercise_1_card_widget.dart
│   └── exercise_2/
│       └── presentation/
│           ├── controller/
│           │   └── exercise_2_controller.dart
│           ├── pages/
│           │   └── exercise_2_page.dart
│           └── widgets/
│               ├── exercise_2_main_card_widget.dart
│               ├── exercise_2_footer_card_widget.dart
│               └── exercise_2_blur_overlay_widget.dart
widgetbook/                        # Separate Flutter app for widget catalog
├── lib/
│   ├── main.dart                  # Custom home with Lottie animation
│   ├── exercise_1.dart            # Exercise 1 use cases
│   └── exercise_2.dart            # Exercise 2 use cases
└── assets/                        # Local assets copy
assets/
├── fonts/                         # Aktiv Grotesk font family
├── images/                        # PNG images (ff_logo, ff_website)
├── svg/                           # SVG icons
└── animations/                    # Lottie JSON files
test/
├── unit/                          # Unit tests for controllers
├── widget/                        # Widget tests
└── golden/
    ├── base/
    │   └── base_test.dart         # Multi-device test base
    ├── exercise_1/
    └── exercise_2/
```

## Technical Highlights

### Responsive Sizing System

Custom extension-based responsive sizing (similar to `sizer` but manually configured):

```dart
extension Measurements on num {
  double get w => AppMeasurements.instance.deviceWidth * (this / 100);
  double get h => AppMeasurements.instance.deviceHeight * (this / 100);
  double get sp => this * (AppMeasurements.instance.deviceHeight / 844);
}

// Usage
Container(
  width: 91.79.w,  // 91.79% of screen width
  padding: EdgeInsets.all(16.sp),
)
```

### Animated Border with CustomPainter

The percentage-based border animation uses `CustomPainter` with path metrics:

```dart
class PercentageBorderPainter extends CustomPainter {
  final double percentage;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..addRRect(rect);
    final pathMetrics = path.computeMetrics().first;
    final extractPath = pathMetrics.extractPath(
      0,
      pathMetrics.length * (percentage / 100),
    );
    canvas.drawPath(extractPath, paint);
  }
}
```

### Internationalization (i18n)

Using GetX translations with automatic locale detection:

```dart
// lib/core/l10n/app_translations.dart
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'loading_file': 'Loading File',
      'view_button': 'View',
    },
    'pt_BR': {
      'loading_file': 'Carregando Arquivo',
      'view_button': 'Ver',
    },
  };
}

// Usage
Text('loading_file'.tr)  // Auto-translates based on system locale
```

### Dynamic Dark Mode

Context-based color extension for reactive theming:

```dart
// lib/core/theme/app_colors.dart
extension AppColorsExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get backgroundColor => isDark ? darkBackground : masterColorA;
  Color get cardColor => isDark ? darkCardBackground : cardBackground;
  Color get textPrimaryColor => isDark ? darkTextPrimary : darkColor;
}

// Usage - colors update automatically when system theme changes
Container(
  color: context.backgroundColor,
  child: Text('Hello', style: TextStyle(color: context.textPrimaryColor)),
)
```

### Micro-Animations with GetX

Button animations using GetX reactive state (no setState):

```dart
class _AnimatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPressed = false.obs;

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) {
        isPressed.value = false;
        HapticFeedback.lightImpact();
        onPressed?.call();
      },
      child: Obx(() => AnimatedScale(
        scale: isPressed.value ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(...),
      )),
    );
  }
}
```

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: `3.9.2` or higher

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/pedrodota/flutter_exercise.git
   cd flutter_exercise
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

## Usage

### Running the Application

```bash
flutter run
```

### Running Widgetbook

```bash
cd widgetbook
flutter run -d chrome
```

### Widgetbook Knobs

| Exercise | Knobs |
|----------|-------|
| Exercise 1 | `percentage`, `isActive`, `title`, `subtitle` |
| Exercise 2 | `title`, `restaurantName`, `description`, `showFooter` |

## Testing

### Running All Tests

```bash
flutter test
```

### Running Unit Tests

```bash
flutter test test/unit/
```

### Running Widget Tests

```bash
flutter test test/widget/
```

### Running Golden Tests

```bash
flutter test test/golden/
```

### Updating Golden Files

```bash
flutter test --update-goldens test/golden/
```

### Device Coverage

Golden tests run on multiple device sizes:
- iPhone 6 (375x667)
- iPhone 16 Pro (402x874)
- iPhone 16 Pro Max (440x956)
- Tablet (1024x768)
- Tablet Vertical (768x1024)

## Animations Overview

| Animation | Screen | Duration | Type |
|-----------|--------|----------|------|
| Logo fade-in | Splash | 800ms | FadeTransition |
| Lottie icon | Exercise 1 | Loop | Lottie |
| Border fill | Exercise 1 | 300ms | CustomPainter |
| Glow pulse | Exercise 1 | 200ms | AnimatedOpacity |
| Button slide-up | Exercise 1 | 400ms | SlideTransition + Fade |
| Hero transition | Ex1 → Ex2 | 300ms | Hero |
| Footer slide | Exercise 2 | 300ms | AnimatedPositioned |

## Color Palette

### Light Mode

| Name | Hex | Usage |
|------|-----|-------|
| Master Color A | `#E8E8E3` | Background |
| Master Color B | `#7E52F4` | Accent/Active border |
| Card Background | `#F1F1EF` | Card fill |
| Dark | `#0E0F10` | Primary text |
| Light | `#FAFAFA` | Button text |
| Tagline | `#808080` | Secondary text |

### Dark Mode

| Name | Hex | Usage |
|------|-----|-------|
| Dark Background | `#121212` | Background |
| Dark Card | `#1E1E1E` | Card fill |
| Dark Text Primary | `#E8E8E3` | Primary text |
| Dark Text Secondary | `#A0A0A0` | Secondary text |
| Dark Footer | `#2A2A2A` | Footer background |

## Screenshots

<!-- Add screenshots here after implementation -->
| Splash | Exercise 1 | Exercise 2 |
|--------|------------|------------|
| ![Splash](readme_files/splash.png) | ![Exercise 1](readme_files/exercise_1.png) | ![Exercise 2](readme_files/exercise_2.png) |

---

<p align="center">
  Made with ❤️ for Form&Fun
</p>
