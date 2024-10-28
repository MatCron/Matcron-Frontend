
# Matcron-Frontend

**Matcron-Frontend** is a Flutter-based mobile application designed to manage and track specific data or functionalities (e.g., scheduling, monitoring, or other app-specific tasks). The app is developed using the Flutter framework and can run on both emulators and physical devices. This README provides instructions for setting up the project in Visual Studio Code (VS Code), connecting emulators, and deploying to physical devices.

---

## Table of Contents
- [Getting Started](#getting-started)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the App](#running-the-app)
  - [Using an Emulator](#using-an-emulator)
  - [Using a Physical Device](#using-a-physical-device)
- [Project Structure](#project-structure)
- [Troubleshooting](#troubleshooting)

---

## Getting Started

These instructions will guide you through setting up and running *Matcron-Frontend* on your local machine.

### Requirements

- **Flutter SDK**: [Install Flutter SDK](https://flutter.dev/docs/get-started/install) and ensure it's added to your PATH.
- **Visual Studio Code**: Install [VS Code](https://code.visualstudio.com/).
  - Required extensions:
    - Flutter
    - Dart
- **Android Studio (for Android emulators)**: [Install Android Studio](https://developer.android.com/studio) and set up an Android emulator if you need to test on virtual devices.
- **iOS Device or Simulator** (Optional): Only required for macOS users targeting iOS devices.

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/matcron-frontend.git
   cd matcron-frontend
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

---

## Running the App

### Using an Emulator

1. **Launch an Emulator**:
   - Open Android Studio.
   - Go to **AVD Manager** under **Configure**.
   - Select an emulator and click **Start**.

2. **Run the App in VS Code**:
   - Open the *Matcron-Frontend* project in VS Code.
   - Ensure the emulator is running.
   - Open the command palette (`Ctrl + Shift + P` or `Cmd + Shift + P` on macOS) and type `Flutter: Select Device`.
   - Choose your emulator from the list.
   - Run the app using `F5` or by clicking on **Run > Start Debugging**.

### Using a Physical Device

1. **Enable Developer Mode** (Android):
   - Go to **Settings > About Phone** and tap **Build Number** seven times to enable developer mode.
   - Go to **Developer Options** and enable **USB Debugging**.

2. **Connect Device via USB**:
   - Plug your device into your computer using a USB cable.
   - Ensure you trust the computer on your device if prompted.

3. **Run the App in VS Code**:
   - Open the *Matcron-Frontend* project in VS Code.
   - Open the command palette (`Ctrl + Shift + P` or `Cmd + Shift + P` on macOS) and type `Flutter: Select Device`.
   - Select your physical device from the list.
   - Run the app using `F5` or by clicking on **Run > Start Debugging**.


## Troubleshooting

- **Device Not Detected**:
  - Ensure that your emulator or physical device is connected and recognized by your computer.
  - Run `flutter devices` in the terminal to check if Flutter detects your device.

- **Hot Reload/Restart Not Working**:
  - Ensure that the VS Code Flutter and Dart extensions are installed.
  - Try restarting the debugging session.

- **Other Issues**:
  - Run `flutter doctor` to identify and resolve environment setup issues.
---
