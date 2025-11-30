# My Food Life - iOS Game

A food safety decision game for iOS built with SpriteKit and GameplayKit. Port of the web-based version to native iOS.

## Overview

Navigate through 7 food safety scenarios and make the right choices to survive! Each decision matters - choose wisely or lose health. Can you make it through all scenarios with your health intact?

## Features

- **7 Unique Scenarios**: From fresh apples to suspicious drinks, test your food safety knowledge
- **Health System**: Start with 3 hearts - make wrong choices and lose health
- **Beautiful UI**: Gradient-based design with smooth animations matching the web version
- **Touch Controls**: Native iOS touch interactions
- **Win/Lose Conditions**: Multiple endings based on your performance

## Technical Stack

- **Language**: Swift
- **Framework**: SpriteKit for graphics and animations
- **State Management**: GameplayKit for game logic
- **Target**: iOS 15.0+

## Project Structure

```
my-food-life-ios/
├── Models/
│   ├── GameScenario.swift    # Scenario data models
│   └── GameState.swift        # Game state management
├── Scenes/
│   ├── GameScene.swift        # Main game scene
│   ├── GameOverScene.swift    # Game over screen
│   └── WinScene.swift         # Victory screen
├── Components/
│   ├── HealthDisplay.swift    # Health hearts UI
│   ├── DateTimeDisplay.swift  # Date/location display
│   └── ChoiceButton.swift     # Interactive choice buttons
├── Helpers/
│   ├── Constants.swift        # Game constants and colors
│   └── Extensions.swift       # Swift extensions
└── Assets.xcassets/           # Game images and assets
```

## How to Run

1. Open `my-food-life-ios.xcodeproj` in Xcode
2. Select a simulator or device (iPhone recommended)
3. Press `Cmd + R` to build and run
4. Start making food safety decisions!

## Gameplay

- Each scenario presents you with a food item and two choices
- Tap on choice 1 or 2 to make your decision
- Safe choices let you progress without penalty
- Unsafe choices damage your health (1-3 hearts depending on severity)
- Survive all 7 scenarios to win!
- Lose all 3 hearts and it's game over

## Scenarios

1. **Fresh Apple** (Monday 7:30 AM) - Kitchen breakfast decision
2. **Fresh Sandwich** (Monday 1:00 PM) - Office cafeteria lunch
3. **Moldy Bread** (Tuesday 8:00 AM) - Kitchen counter dilemma
4. **Fresh Milk** (Tuesday 9:00 AM) - Refrigerator check
5. **Old Yogurt** (Wednesday 2:00 PM) - Office desk snack
6. **Rotten Apple** (Thursday 6:00 PM) - Fruit bowl inspection
7. **Suspicious Drink** (Friday 11:00 PM) - Party challenge

## Design

The iOS version maintains the premium aesthetic of the web version:
- Dark gradient background with radial effects
- Glassmorphism card design
- Smooth fade transitions between scenarios
- Animated health hearts with heartbeat effect
- Success/failure button animations
- Dynamic win messages based on performance

## Credits

Based on the web version created for food safety education.
iOS port created with SpriteKit and GameplayKit.

## License

Educational project - feel free to learn from and modify!
