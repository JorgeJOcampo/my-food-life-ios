//
//  WinScene.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class WinScene: SKScene {
    
    private let finalHealth: Int
    
    init(size: CGSize, finalHealth: Int) {
        self.finalHealth = finalHealth
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUI()
    }
    
    private func setupBackground() {
        backgroundColor = SKColor(hex: "#0a0e1a", alpha: 0.95)
        
        // Add blur effect simulation
        let overlay = SKSpriteNode(color: GameColors.bgPrimary, size: size)
        overlay.position = CGPoint(x: size.width/2, y: size.height/2)
        overlay.alpha = 0.95
        overlay.zPosition = ZPositions.background
        addChild(overlay)
    }
    
    private func setupUI() {
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        // Determine title and message based on health
        let (emoji, title, message) = getWinMessage()
        
        // Title
        let titleLabel = SKLabelNode(text: "\(emoji) \(title)")
        titleLabel.fontName = "Inter-Bold"
        titleLabel.fontSize = 48
        titleLabel.fontColor = GameColors.accentSuccess
        titleLabel.position = CGPoint(x: centerX, y: centerY + 150)
        titleLabel.zPosition = ZPositions.ui
        addChild(titleLabel)
        
        // Message
        let messageLabel = SKLabelNode.createLabel(text: message, fontSize: 18, color: GameColors.textSecondary)
        messageLabel.position = CGPoint(x: centerX, y: centerY + 60)
        messageLabel.preferredMaxLayoutWidth = size.width - 80
        messageLabel.numberOfLines = 0
        messageLabel.zPosition = ZPositions.ui
        addChild(messageLabel)
        
        // Final Health Display
        let healthContainer = SKNode()
        healthContainer.position = CGPoint(x: centerX, y: centerY - 20)
        healthContainer.zPosition = ZPositions.ui
        
        let heartSpacing: CGFloat = 50
        let startX = -CGFloat(finalHealth - 1) * heartSpacing / 2
        
        for i in 0..<finalHealth {
            let heart = SKLabelNode(text: "❤️")
            heart.fontSize = 40
            heart.position = CGPoint(x: startX + CGFloat(i) * heartSpacing, y: 0)
            healthContainer.addChild(heart)
        }
        
        addChild(healthContainer)
        
        // Play Again Button
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 60
        let buttonRect = CGRect(x: -buttonWidth/2, y: -buttonHeight/2, width: buttonWidth, height: buttonHeight)
        let playAgainButton = SKShapeNode(rect: buttonRect, cornerRadius: 12)
        playAgainButton.fillColor = GameColors.gradientPurple1
        playAgainButton.strokeColor = .clear
        playAgainButton.position = CGPoint(x: centerX, y: centerY - 120)
        playAgainButton.zPosition = ZPositions.buttons
        playAgainButton.name = "playAgainButton"
        
        let buttonLabel = SKLabelNode.createLabel(text: "Play Again", fontSize: 22, color: .white)
        buttonLabel.fontName = "Inter-Bold"
        buttonLabel.verticalAlignmentMode = .center
        playAgainButton.addChild(buttonLabel)
        
        addChild(playAgainButton)
        
        // Animate entrance
        titleLabel.alpha = 0
        messageLabel.alpha = 0
        healthContainer.alpha = 0
        playAgainButton.alpha = 0
        
        titleLabel.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
        
        messageLabel.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.4),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
        
        healthContainer.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.6),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
        
        playAgainButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.8),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
    }
    
    private func getWinMessage() -> (String, String, String) {
        switch finalHealth {
        case 3:
            return ("🏆", "Flawless Victory!", "Perfect! You made all the right choices and kept your health intact. You're a food safety expert!")
        case 2:
            return ("🎉", "You Survived!", "Great job! You made it through with only minor setbacks. Your food safety skills are strong!")
        default:
            return ("😅", "Barely Made It!", "Phew! That was close! You survived by the skin of your teeth. Maybe review those food safety tips!")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        if touchedNode.name == "playAgainButton" || touchedNode.parent?.name == "playAgainButton" {
            restartGame()
        }
    }
    
    private func restartGame() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        view?.presentScene(gameScene, transition: transition)
    }
}
