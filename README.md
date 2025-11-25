# Flutter UI Exercises

This repository contains two UI exercises to be implemented using Flutter and Widgetbook.

## Requirements

- Dart SDK: `3.9.2`
- Flutter SDK

## Getting Started

Fork this repository

**Important:** Commit your progress regularly throughout the development process.

## Design & Assets

**Design:** [Figma](https://www.figma.com/design/ObMbtPPyWu7VjjMaus2Hpx/Flutter-Dev---Exercice?node-id=1-1326&t=FtXZZ0dtQZZxLNjj-0)

**Assets:** [Google Drive](https://drive.google.com/drive/folders/1_BeEUqMfPyeodtvOz2m-tJq4ieqaLi-C)

## Exercises

### Exercise 1: Interactive Card with Percentage Border

**File:** `lib/exercise_1.dart`

Implement a card component with:
- Lottie animated icon
- Primary text and subtext
- A square with an animated border that fills based on slider percentage (0-100%)
- Background glow that indicate that card is active.
- Interactive slider control with KNOBS.

### Exercise 2: Scrollable Content Card with Bottom Blur and Footer Card

**File:** `lib/exercise_2.dart`

Create a scrollable page with the following structure:
- Title at the top
- Card containing a 16:9 aspect ratio image
- Content section below the image with icon, title/subtitle, and button
- Description text
- Add a **blur overlay fixed at the bottom of the viewport**, independent of scroll.
- Add an additional card in the footer area.
  
Implement an animation for the **footer card**:

- The footer card should start **fully off-screen**, positioned below the viewport.
- As the user **scrolls down**, the footer card should **slide up into view** using a smooth translation animation.
- As the user **scrolls back up**, the footer card should **slide down and hide again**, returning to its off-screen position.


## Submission Guidelines

- Follow the Figma design specifications
- Ensure responsive behavior across different screen sizes
- Components must be functional in the Widgetbook environment
- Commit regularly throughout your development process
- Submit the link to your forked repository when complete by email
