//
//  GameOverScene.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class GameOverScene: SKScene {
    
    private let message: String
    
    init(size: CGSize, message: String) {
        self.message = message
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
        
        // Title
        let titleLabel = SKLabelNode(text: "💀 Game Over")
        titleLabel.fontName = "Inter-Bold"
        titleLabel.fontSize = 48
        titleLabel.fontColor = GameColors.accentDanger
        titleLabel.position = CGPoint(x: centerX, y: centerY + 100)
        titleLabel.zPosition = ZPositions.ui
        addChild(titleLabel)
        
        // Message
        let messageLabel = SKLabelNode.createLabel(text: message, fontSize: 20, color: GameColors.textSecondary)
        messageLabel.position = CGPoint(x: centerX, y: centerY + 20)
        messageLabel.preferredMaxLayoutWidth = size.width - 80
        messageLabel.numberOfLines = 0
        messageLabel.zPosition = ZPositions.ui
        addChild(messageLabel)
        
        // Restart Button
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 60
        let buttonRect = CGRect(x: -buttonWidth/2, y: -buttonHeight/2, width: buttonWidth, height: buttonHeight)
        let restartButton = SKShapeNode(rect: buttonRect, cornerRadius: 12)
        restartButton.fillColor = GameColors.gradientPurple1
        restartButton.strokeColor = .clear
        restartButton.position = CGPoint(x: centerX, y: centerY - 80)
        restartButton.zPosition = ZPositions.buttons
        restartButton.name = "restartButton"
        
        let buttonLabel = SKLabelNode.createLabel(text: "Try Again", fontSize: 22, color: .white)
        buttonLabel.fontName = "Inter-Bold"
        buttonLabel.verticalAlignmentMode = .center
        restartButton.addChild(buttonLabel)
        
        addChild(restartButton)
        
        // Animate entrance
        titleLabel.alpha = 0
        messageLabel.alpha = 0
        restartButton.alpha = 0
        
        titleLabel.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
        
        messageLabel.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.4),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
        
        restartButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.6),
            SKAction.fadeIn(withDuration: 0.5)
        ]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        if touchedNode.name == "restartButton" || touchedNode.parent?.name == "restartButton" {
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
