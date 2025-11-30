//
//  GameState.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import Foundation

/// Manages the current state of the game
class GameState: ObservableObject {
    @Published var currentScenarioIndex: Int = 0
    @Published var health: Int = 3
    @Published var isGameActive: Bool = true
    @Published var hasWon: Bool = false
    
    let maxHealth: Int = 3
    let totalScenarios: Int
    
    init() {
        self.totalScenarios = GameData.scenarios.count
    }
    
    /// Reset the game to initial state
    func reset() {
        currentScenarioIndex = 0
        health = maxHealth
        isGameActive = true
        hasWon = false
    }
    
    /// Get the current scenario
    func getCurrentScenario() -> GameScenario? {
        guard currentScenarioIndex < totalScenarios else { return nil }
        return GameData.scenarios[currentScenarioIndex]
    }
    
    /// Process a choice made by the player
    func processChoice(_ choice: Choice) {
        if !choice.isSafe {
            health -= choice.damage
            if health <= 0 {
                isGameActive = false
                hasWon = false
            }
        }
    }
    
    /// Move to the next scenario
    func nextScenario() {
        currentScenarioIndex += 1
        if currentScenarioIndex >= totalScenarios {
            isGameActive = false
            hasWon = true
        }
    }
    
    /// Check if the game is over
    func isGameOver() -> Bool {
        return !isGameActive
    }
}
