<img width="1280" height="640" alt="Add a heading" src="https://github.com/user-attachments/assets/f95ec8e4-6071-4877-8edb-c5e764abcabe" />

# Learning Journal

Learning Journal is a productivity app designed to aid users in tracking their goals through streaks and freezes.

## Overview

You pick something you want to learn and how long you want to take (a week, a month or a year). Each day you log it as learned to build a streak, or use a freeze to protect your streak on a day you can't study. A calendar shows your full history, and you can change your goal at any time.

## Features

- **Goal setting:** choose a topic and a duration (Week, Month or Year).
- **Daily streaks:** log each day as learned to grow your streak.
- **Freezes:** skip a day without losing your streak, with a limit based on the goal duration.
- **Calendar history:** see every previous day you learned or froze, month by month.
- **Goal outcomes:** a goal ends as completed or failed, and you can set a new one.
- **Editable goal:** change your topic or duration whenever you like.
- **Local storage:** everything is saved on the device, with no account or network needed.

<img width="1280" height="640" alt="Add a heading-2" src="https://github.com/user-attachments/assets/a3d3cc80-4234-4d31-a383-49a61b7ce306" />

## Screens

| Screen | Purpose |
|---|---|
| **Onboarding** | Enter a topic and pick a duration to start your first goal. |
| **Activity** | Home screen: current week, learned and freezed counts, and the Log as Learned and Freeze buttons. |
| **Goal completed / failed** | Replaces the buttons on Activity when a goal ends, with a prompt to set a new goal. |
| **Learning Goal** | Edit the current goal, or set a new one after a goal ends. |
| **Update goal dialog** | Warns that changing an active goal restarts your streak. |
| **Calendar (Activities)** | Scrollable history of logged and frozen days. |

## How It Works

### Days
Each day has one status: **learned** or **frozen**. You can switch today between the two, and the counts update accordingly.

### Freeze limits
The number of freezes depends on the goal duration:

| Duration | Days to complete | Freezes allowed |
|---|---|---|
| Week | 7 | 2 |
| Month | 30 | 8 |
| Year | 365 | 96 |

### Streak rules
- A goal is **completed** when the number of logged days (learned plus frozen) reaches the goal length.
- A goal **fails** if more than **32 hours** pass without logging a day as learned or using a freeze.
- **Updating the goal** restarts the streak. Previous days stay visible in the calendar.
- A new goal after a completed or failed one starts from a blank form.

## Tech Stack

- **Language:** Swift
- **UI framework:** SwiftUI
- **IDE:** Xcode
- **Architecture:** MVVM (Model-View-ViewModel)
- **Design:** native iOS Liquid Glass (`glassEffect` and the built-in glass button styles)
- **Persistence:** `Codable` data saved as JSON in `UserDefaults`
- **State management:** the Observation framework (`@Observable`)

## Getting Started

### Requirements
- A Mac with the latest version of Xcode
- iOS 26 or later (required for the native glass effects)
- iPhone only

### Run the app
1. Clone this repository.
2. Open the `.xcodeproj` file in Xcode.
3. Select an iPhone simulator or a connected iPhone.
4. Press **⌘R** to build and run.

The app uses dark mode only.

## Notes

- All data is stored locally. Deleting the app removes your goal and history.
- The app has no backend, accounts or notifications.
