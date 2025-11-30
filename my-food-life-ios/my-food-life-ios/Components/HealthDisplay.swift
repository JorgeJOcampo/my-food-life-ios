//
//  HealthDisplay.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class HealthDisplay: SKNode {
    private var hearts: [SKSpriteNode] = []
    private let maxHealth: Int = 3
    
    override init() {
        super.init()
        setupHearts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHearts() {
        let spacing: CGFloat = 10
        let startX: CGFloat = 0
        
        for i in 0..<maxHealth {
            let heart = SKSpriteNode(imageNamed: "heart_full")
            // Scale to match design size (approx 32-40pt)
            heart.size = CGSize(width: GameLayout.heartSize, height: GameLayout.heartSize)
            heart.position = CGPoint(x: startX + CGFloat(i) * (GameLayout.heartSize + spacing), y: 0)
            heart.name = "heart_\(i)"
            
            addChild(heart)
            hearts.append(heart)
        }
    }
    
    func updateHealth(_ currentHealth: Int) {
        for (index, heart) in hearts.enumerated() {
            if index < currentHealth {
                // Filled heart
                heart.texture = SKTexture(imageNamed: "heart_full")
                heart.alpha = 1.0
                
                // Only animate if it's not already animating
                if heart.action(forKey: "heartbeat") == nil {
                    heart.run(SKAction.heartbeat(), withKey: "heartbeat")
                }
            } else {
                // Empty heart
                heart.texture = SKTexture(imageNamed: "heart_empty")
                heart.removeAction(forKey: "heartbeat")
                
                // Reset scale if it was beating
                heart.setScale(1.0)
                
                // Optional: Add a small shake or flash effect when losing health
                // For now, just switching texture is enough as per design
            }
        }
    }
}
