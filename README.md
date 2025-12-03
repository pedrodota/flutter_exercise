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
- Custom Splash Screen with fade-in animation
- Hero animations between screens
- Responsive design system with custom sizing extensions

### Exercise 1: Interactive Card with Percentage Border

- Lottie animated icon with continuous loop
- Animated border that fills based on slider percentage (0-100%)
- Background glow effect indicating active state
- Interactive slider control with Widgetbook KNOBS
- Slide-up button animation for navigation

### Exercise 2: Scrollable Content with Animated Footer

- Scrollable page with restaurant card (16:9 image)
- Content section with icon, title/subtitle, and button
- **Blur overlay fixed at bottom** - independent of scroll
- **Animated footer card**:
  - Starts off-screen below viewport
  - Slides up on scroll down
  - Slides down (hides) on scroll up
  - Smooth translation animation

## Design & Assets

| Resource | Link |
|----------|------|
| Figma Design | [View Design](https://www.figma.com/design/ObMbtPPyWu7VjjMaus2Hpx/Flutter-Dev---Exercice) |
| Assets | [Google Drive](https://drive.google.com/drive/folders/1_BeEUqMfPyeodtvOz2m-tJq4ieqaLi-C) |

## Packages Used

| Package | Version | Description |
|---------|---------|-------------|
| **lottie** | ^3.3.1 | High-performance Lottie animations rendering |
| **flutter_svg** | ^2.0.16 | SVG rendering for scalable vector graphics |
| **golden_toolkit** | ^0.15.0 | Golden tests for visual regression testing |

### Package Details

1. **lottie**
   - Renders After Effects animations exported as JSON
   - Used for the animated icon in Exercise 1 (`searching.json`)
   - Supports looping, progress control, and dynamic updates

2. **flutter_svg**
   - Renders SVG images maintaining quality at any scale
   - Used for icons and vector graphics throughout the app

3. **golden_toolkit**
   - Multi-device golden testing support
   - Generates visual snapshots for regression testing
   - Tests across iPhone, iPad, and various screen sizes

## Project Structure

```plaintext
lib/
├── main.dart                      # Entry point
├── app/
│   ├── app.dart                   # MaterialApp configuration
│   └── routes.dart                # Named routes
├── core/
│   ├── theme/
│   │   ├── app_colors.dart        # Color palette (#E8E8E3, #7E52F4, etc.)
│   │   ├── app_typography.dart    # Aktiv Grotesk text styles
│   │   └── app_theme.dart         # ThemeData configuration
│   ├── utils/
│   │   ├── assets.dart            # Asset paths helper
│   │   ├── measurements.dart      # Responsive sizing (.w, .h, .sp)
│   │   └── extensions/            # Dart extensions
│   └── shared/
│       └── presentation/
│           └── widgets/           # Reusable widgets
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── pages/
│   │           └── splash_page.dart
│   ├── exercise_1/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── exercise_1_page.dart
│   │       └── widgets/
│   │           ├── animated_card_widget.dart
│   │           ├── percentage_border_widget.dart
│   │           └── lottie_icon_widget.dart
│   └── exercise_2/
│       └── presentation/
│           ├── pages/
│           │   └── exercise_2_page.dart
│           └── widgets/
│               ├── restaurant_card_widget.dart
│               ├── footer_widget.dart
│               └── blur_overlay_widget.dart
├── widgetbook/
│   └── lib/
│       ├── exercise_1.dart        # Widgetbook stories with knobs
│       └── exercise_2.dart
assets/
├── fonts/                         # Aktiv Grotesk font family
├── images/                        # PNG images (ff_logo, ff_website)
├── svg/                           # SVG icons
└── animations/                    # Lottie JSON files
test/
├── flutter_test_config.dart       # Golden test configuration
└── golden/
    ├── base/
    │   └── base_test.dart         # Multi-device test base
    ├── exercise_1/
    │   └── exercise_1_golden_test.dart
    └── exercise_2/
        └── exercise_2_golden_test.dart
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

### Scroll-Triggered Footer Animation

Footer visibility is controlled by scroll direction detection:

```dart
NotificationListener<ScrollNotification>(
  onNotification: (notification) {
    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      if (delta > 0) _showFooter();  // Scrolling down
      else if (delta < 0) _hideFooter();  // Scrolling up
    }
    return false;
  },
  child: ListView(...),
)
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

| Name | Hex | Usage |
|------|-----|-------|
| Master Color A | `#E8E8E3` | Background |
| Master Color B | `#7E52F4` | Accent/Active border |
| Card Background | `#F1F1EF` | Card fill |
| Dark | `#0E0F10` | Primary text |
| Light | `#FAFAFA` | Button text |
| Tagline | `#808080` | Secondary text |

## Screenshots

<!-- Add screenshots here after implementation -->
| Splash | Exercise 1 | Exercise 2 |
|--------|------------|------------|
| ![Splash](readme_files/splash.png) | ![Exercise 1](readme_files/exercise_1.png) | ![Exercise 2](readme_files/exercise_2.png) |

---

<p align="center">
  Made with ❤️ for Form&Fun
</p>
