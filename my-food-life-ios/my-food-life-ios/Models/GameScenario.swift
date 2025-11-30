//
//  GameScenario.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import Foundation

/// Represents a choice option in a game scenario
struct Choice {
    let text: String
    let isSafe: Bool
    let damage: Int
    let message: String?
    
    init(text: String, isSafe: Bool, damage: Int = 0, message: String? = nil) {
        self.text = text
        self.isSafe = isSafe
        self.damage = damage
        self.message = message
    }
}

/// Represents a food safety scenario in the game
struct GameScenario {
    let imageName: String
    let dateLocation: String
    let choice1: Choice
    let choice2: Choice
}

/// All game scenarios
class GameData {
    static let scenarios: [GameScenario] = [
        GameScenario(
            imageName: "fresh_apple",
            dateLocation: "Monday, 7:30 AM - Kitchen",
            choice1: Choice(text: "Eat the apple for breakfast", isSafe: true),
            choice2: Choice(text: "Skip breakfast and rush to work", isSafe: true)
        ),
        GameScenario(
            imageName: "fresh_sandwich",
            dateLocation: "Monday, 1:00 PM - Office Cafeteria",
            choice1: Choice(text: "Eat the fresh sandwich", isSafe: true),
            choice2: Choice(text: "Save it for later", isSafe: true)
        ),
        GameScenario(
            imageName: "moldy_bread",
            dateLocation: "Tuesday, 8:00 AM - Kitchen Counter",
            choice1: Choice(
                text: "Eat it anyway, just a little mold",
                isSafe: false,
                damage: 1,
                message: "The moldy bread made you sick! -1 ❤️"
            ),
            choice2: Choice(text: "Throw it away and make toast instead", isSafe: true)
        ),
        GameScenario(
            imageName: "fresh_milk",
            dateLocation: "Tuesday, 9:00 AM - Refrigerator",
            choice1: Choice(text: "Pour a glass and drink it", isSafe: true),
            choice2: Choice(text: "Check the expiration date first", isSafe: true)
        ),
        GameScenario(
            imageName: "old_yogurt",
            dateLocation: "Wednesday, 2:00 PM - Office Desk",
            choice1: Choice(
                text: "Eat it, yogurt lasts forever right?",
                isSafe: false,
                damage: 1,
                message: "The expired yogurt upset your stomach! -1 ❤️"
            ),
            choice2: Choice(text: "Check the date and toss it", isSafe: true)
        ),
        GameScenario(
            imageName: "rotten_apple",
            dateLocation: "Thursday, 6:00 PM - Fruit Bowl",
            choice1: Choice(
                text: "Cut off the bad parts and eat it",
                isSafe: false,
                damage: 2,
                message: "The rotten apple was worse than it looked! -2 ❤️"
            ),
            choice2: Choice(text: "Throw it in the compost", isSafe: true)
        ),
        GameScenario(
            imageName: "suspicious_drink",
            dateLocation: "Friday, 11:00 PM - Mysterious Party",
            choice1: Choice(
                text: "Drink it without asking",
                isSafe: false,
                damage: 3,
                message: "That was NOT safe to drink! 💀"
            ),
            choice2: Choice(text: "Politely decline and get water", isSafe: true)
        )
    ]
}
