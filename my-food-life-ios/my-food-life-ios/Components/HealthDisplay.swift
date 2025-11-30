//
//  HealthDisplay.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class HealthDisplay: SKNode {
    private var hearts: [SKLabelNode] = []
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
            let heart = SKLabelNode(text: "❤️")
            heart.fontSize = GameLayout.heartSize
            heart.position = CGPoint(x: startX + CGFloat(i) * (GameLayout.heartSize + spacing), y: 0)
            heart.name = "heart_\(i)"
            heart.alpha = 0.3
            
            // Add grayscale effect for empty hearts (simulated with alpha)
            addChild(heart)
            hearts.append(heart)
        }
    }
    
    func updateHealth(_ currentHealth: Int) {
        for (index, heart) in hearts.enumerated() {
            if index < currentHealth {
                // Filled heart
                heart.alpha = 1.0
                heart.removeAllActions()
                heart.run(SKAction.heartbeat())
            } else {
                // Lost heart
                heart.removeAllActions()
                let loseAnimation = SKAction.sequence([
                    SKAction.scale(to: 1.3, duration: 0.25),
                    SKAction.group([
                        SKAction.scale(to: 0.8, duration: 0.25),
                        SKAction.fadeAlpha(to: 0.3, duration: 0.25)
                    ])
                ])
                heart.run(loseAnimation)
            }
        }
    }
}
