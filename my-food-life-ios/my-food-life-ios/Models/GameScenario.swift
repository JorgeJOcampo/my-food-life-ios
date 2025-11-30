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
            imageName: "apple",
            dateLocation: "01/98",
            choice1: Choice(
                text: "Take a bite of the shiny apple",
                isSafe: true
            ),
            choice2: Choice(
                text: "Skip it, maybe find something sweeter later",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "flan",
            dateLocation: "02/98",
            choice1: Choice(
                text: "Eat the flan—it looks perfectly caramelized",
                isSafe: true
            ),
            choice2: Choice(
                text: "Leave it untouched, you're not in a dessert mood",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "french_toast",
            dateLocation: "03/98",
            choice1: Choice(
                text: "Eat the warm french toast dripping with syrup",
                isSafe: true
            ),
            choice2: Choice(
                text: "Avoid it, the sweetness feels overwhelming today",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "mushroom",
            dateLocation: "04/98",
            choice1: Choice(
                text: "Eat the lone mushroom you found in the woods",
                isSafe: false,
                damage: 2,
                message: "Turns out… it wasn’t the edible kind. -2 ❤️"
            ),
            choice2: Choice(
                text: "Leave the mushroom untouched—better safe than sorry",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "pie",
            dateLocation: "05/98",
            choice1: Choice(
                text: "Eat a generous slice of the freshly baked pie",
                isSafe: true
            ),
            choice2: Choice(
                text: "Save it for later, you're too full right now",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "rotten_apple",
            dateLocation: "06/98",
            choice1: Choice(
                text: "Eat it anyway—the rot is only on the surface… right?",
                isSafe: false,
                damage: 2,
                message: "The rotten apple was a terrible choice. -2 ❤️"
            ),
            choice2: Choice(
                text: "Toss it before the worms say hello",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "rotten_french_toast",
            dateLocation: "07/98",
            choice1: Choice(
                text: "Eat the spoiled french toast—it might still be good",
                isSafe: false,
                damage: 3,
                message: "That bite tasted like regret. And poison. 💀"
            ),
            choice2: Choice(
                text: "Throw it away before it starts moving on its own",
                isSafe: true
            )
        ),

        GameScenario(
            imageName: "screw",
            dateLocation: "08/98",
            choice1: Choice(
                text: "Eat the metal screw to prove your bravery",
                isSafe: false,
                damage: 3,
                message: "It tore your insides apart. Why would you eat that?? 💀"
            ),
            choice2: Choice(
                text: "Leave the screw on the table—it’s definitely not food",
                isSafe: true
            )
        )
    ]

}
