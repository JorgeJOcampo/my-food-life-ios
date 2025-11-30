//
//  SaveManager.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import Foundation

/// Manages game save/load functionality using UserDefaults
class SaveManager {
    static let shared = SaveManager()
    
    private let saveKey = "MyFoodLifeSaveData"
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Save Data Structure
    
    struct SaveData: Codable {
        let currentScenarioIndex: Int
        let health: Int
        let timestamp: Date
        
        init(scenarioIndex: Int, health: Int) {
            self.currentScenarioIndex = scenarioIndex
            self.health = health
            self.timestamp = Date()
        }
    }
    
    // MARK: - Public Methods
    
    /// Save the current game state
    func saveGame(scenarioIndex: Int, health: Int) {
        let saveData = SaveData(scenarioIndex: scenarioIndex, health: health)
        
        if let encoded = try? JSONEncoder().encode(saveData) {
            defaults.set(encoded, forKey: saveKey)
            defaults.synchronize()
            print("✅ Game saved: Scenario \(scenarioIndex), Health \(health)")
        } else {
            print("❌ Failed to save game")
        }
    }
    
    /// Load the saved game state
    func loadGame() -> SaveData? {
        guard let savedData = defaults.data(forKey: saveKey),
              let decoded = try? JSONDecoder().decode(SaveData.self, from: savedData) else {
            print("ℹ️ No saved game found")
            return nil
        }
        
        print("✅ Game loaded: Scenario \(decoded.currentScenarioIndex), Health \(decoded.health)")
        return decoded
    }
    
    /// Check if a saved game exists
    func hasSavedGame() -> Bool {
        return defaults.data(forKey: saveKey) != nil
    }
    
    /// Delete the saved game
    func deleteSave() {
        defaults.removeObject(forKey: saveKey)
        defaults.synchronize()
        print("🗑️ Save deleted")
    }
    
    /// Get the timestamp of the last save
    func getLastSaveDate() -> Date? {
        return loadGame()?.timestamp
    }
}
