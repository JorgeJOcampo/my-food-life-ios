//
//  GameScene.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Game state
    private var gameState: GameState!
    
    // UI Components
    private var healthDisplay: HealthDisplay!
    private var dateTimeDisplay: DateTimeDisplay!
    private var foodImageNode: SKSpriteNode!
    private var choice1Button: ChoiceButton!
    private var choice2Button: ChoiceButton!
    
    // Background
    private var backgroundNode: SKSpriteNode!
    private var cardBackground: SKShapeNode!
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUI()
        gameState = GameState()
        loadScenario()
    }
    
    private func setupBackground() {
        // Create gradient background
        backgroundColor = GameColors.bgPrimary
        
        // Add radial gradient effects (simulated with colored circles)
        let gradient1 = SKShapeNode(circleOfRadius: 300)
        gradient1.fillColor = GameColors.gradientPurple1
        gradient1.alpha = 0.1
        gradient1.position = CGPoint(x: size.width * 0.2, y: size.height * 0.5)
        gradient1.zPosition = ZPositions.background
        addChild(gradient1)
        
        let gradient2 = SKShapeNode(circleOfRadius: 300)
        gradient2.fillColor = GameColors.accentSecondary
        gradient2.alpha = 0.1
        gradient2.position = CGPoint(x: size.width * 0.8, y: size.height * 0.8)
        gradient2.zPosition = ZPositions.background
        addChild(gradient2)
        
        // Create card background
        let cardWidth = size.width - 40
        let cardHeight = size.height - 40
        let cardRect = CGRect(x: -cardWidth/2, y: -cardHeight/2, width: cardWidth, height: cardHeight)
        cardBackground = SKShapeNode(rect: cardRect, cornerRadius: 24)
        cardBackground.fillColor = GameColors.bgCard
        cardBackground.strokeColor = SKColor(hex: "#ffffff", alpha: 0.1)
        cardBackground.lineWidth = 1
        cardBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        cardBackground.zPosition = ZPositions.background + 1
        addChild(cardBackground)
    }
    
    private func setupUI() {
        let padding: CGFloat = GameLayout.padding
        let topY = size.height - 60
        
        // Date/Time Display (top left)
        dateTimeDisplay = DateTimeDisplay()
        dateTimeDisplay.position = CGPoint(x: padding + 100, y: topY)
        dateTimeDisplay.zPosition = ZPositions.ui
        addChild(dateTimeDisplay)
        
        // Health Display (top right)
        healthDisplay = HealthDisplay()
        healthDisplay.position = CGPoint(x: size.width - 150, y: topY)
        healthDisplay.zPosition = ZPositions.ui
        addChild(healthDisplay)
        healthDisplay.updateHealth(3)
        
        // Food Image
        foodImageNode = SKSpriteNode()
        foodImageNode.size = CGSize(width: size.width - 80, height: GameLayout.foodImageHeight)
        foodImageNode.position = CGPoint(x: size.width/2, y: size.height/2 + 50)
        foodImageNode.zPosition = ZPositions.foodImage
        addChild(foodImageNode)
        
        // Choice Buttons
        let buttonWidth = size.width - 80
        let buttonY1 = 180
        let buttonY2 = 100
        
        choice1Button = ChoiceButton(choiceNumber: 1, width: buttonWidth)
        choice1Button.position = CGPoint(x: size.width/2, y: CGFloat(buttonY1))
        choice1Button.zPosition = ZPositions.buttons
        choice1Button.onTap = { [weak self] in
            self?.handleChoice(1)
        }
        addChild(choice1Button)
        
        choice2Button = ChoiceButton(choiceNumber: 2, width: buttonWidth)
        choice2Button.position = CGPoint(x: size.width/2, y: CGFloat(buttonY2))
        choice2Button.zPosition = ZPositions.buttons
        choice2Button.onTap = { [weak self] in
            self?.handleChoice(2)
        }
        addChild(choice2Button)
    }
    
    private func loadScenario() {
        guard let scenario = gameState.getCurrentScenario() else {
            // Game completed
            showWinScreen()
            return
        }
        
        // Fade out current image
        foodImageNode.run(SKAction.fadeOut(withDuration: GameAnimations.normal)) { [weak self] in
            guard let self = self else { return }
            
            // Update content
            self.dateTimeDisplay.updateText(scenario.dateLocation)
            self.foodImageNode.texture = SKTexture(imageNamed: scenario.imageName)
            self.choice1Button.setText(scenario.choice1.text)
            self.choice2Button.setText(scenario.choice2.text)
            
            // Reset buttons
            self.choice1Button.reset()
            self.choice2Button.reset()
            self.choice1Button.isEnabled = true
            self.choice2Button.isEnabled = true
            
            // Fade in new image
            self.foodImageNode.run(SKAction.fadeIn(withDuration: GameAnimations.normal))
        }
    }
    
    private func handleChoice(_ choiceNumber: Int) {
        guard let scenario = gameState.getCurrentScenario() else { return }
        
        let choice = choiceNumber == 1 ? scenario.choice1 : scenario.choice2
        let button = choiceNumber == 1 ? choice1Button : choice2Button
        
        // Disable buttons
        choice1Button.isEnabled = false
        choice2Button.isEnabled = false
        
        if choice.isSafe {
            // Correct choice
            button?.animateCorrect()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                self?.gameState.nextScenario()
                self?.loadScenario()
            }
        } else {
            // Wrong choice
            button?.animateWrong()
            gameState.processChoice(choice)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
                guard let self = self else { return }
                
                self.healthDisplay.updateHealth(self.gameState.health)
                
                if self.gameState.health <= 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showGameOverScreen(message: choice.message ?? "You didn't make it...")
                    }
                } else {
                    // Show damage message
                    if let message = choice.message {
                        self.showDamageMessage(message)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.gameState.nextScenario()
                        self.loadScenario()
                    }
                }
            }
        }
    }
    
    private func showDamageMessage(_ message: String) {
        let messageLabel = SKLabelNode.createLabel(text: message, fontSize: 20, color: .white)
        messageLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        messageLabel.zPosition = ZPositions.message
        
        // Create background
        let background = SKShapeNode(rectOf: CGSize(width: 300, height: 80), cornerRadius: 12)
        background.fillColor = GameColors.accentDanger
        background.strokeColor = .clear
        background.position = messageLabel.position
        background.zPosition = ZPositions.message - 1
        
        addChild(background)
        addChild(messageLabel)
        
        // Animate
        background.alpha = 0
        messageLabel.alpha = 0
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let wait = SKAction.wait(forDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut, remove])
        
        background.run(sequence)
        messageLabel.run(sequence)
    }
    
    private func showGameOverScreen(message: String) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: size, message: message)
        gameOverScene.scaleMode = scaleMode
        view?.presentScene(gameOverScene, transition: transition)
    }
    
    private func showWinScreen() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let winScene = WinScene(size: size, finalHealth: gameState.health)
        winScene.scaleMode = scaleMode
        view?.presentScene(winScene, transition: transition)
    }
}
