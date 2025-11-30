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
    
    /// Initialize from saved data
    init(savedData: SaveManager.SaveData) {
        self.totalScenarios = GameData.scenarios.count
        self.currentScenarioIndex = savedData.currentScenarioIndex
        self.health = savedData.health
        self.isGameActive = true
        self.hasWon = false
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
        
        // Auto-save progress
        saveGame()
    }
    
    /// Check if the game is over
    func isGameOver() -> Bool {
        return !isGameActive
    }
    
    /// Save current game state
    func saveGame() {
        SaveManager.shared.saveGame(scenarioIndex: currentScenarioIndex, health: health)
    }
    
    /// Load game from save
    static func loadFromSave() -> GameState? {
        guard let saveData = SaveManager.shared.loadGame() else {
            return nil
        }
        return GameState(savedData: saveData)
    }
}
