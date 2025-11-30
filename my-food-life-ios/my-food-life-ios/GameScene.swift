//
//  GameScene.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit
import GameplayKit
import UIKit

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
    
    // Initialization
    private let loadFromSave: Bool
    
    init(size: CGSize, loadFromSave: Bool = false) {
        self.loadFromSave = loadFromSave
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.loadFromSave = false
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUI()
        
        // Load game state (either new or from save)
        if loadFromSave, let savedState = GameState.loadFromSave() {
            gameState = savedState
        } else {
            gameState = GameState()
        }
        
        loadScenario()
    }
    
    private func setupBackground() {
        // Set background image using scenario_1
        backgroundNode = SKSpriteNode(imageNamed: "scenario_1")
        backgroundNode.size = size
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundNode.zPosition = ZPositions.background
        addChild(backgroundNode)
    }
    
    private func setupUI() {
        let padding: CGFloat = GameLayout.padding
        
        // Get safe area insets to position relative to dynamic island
        var topInset: CGFloat = 0
        if let view = self.view {
            if let window = view.window {
                topInset = window.safeAreaInsets.top
            } else if let viewController = view.next(UIViewController.self) {
                topInset = viewController.view.safeAreaInsets.top
            }
        }
        
        // Dynamic island is typically ~126 points wide and centered horizontally
        // Position elements on left and right sides of the dynamic island
        let dynamicIslandWidth: CGFloat = 126
        let dynamicIslandCenterX = size.width / 2
        let dynamicIslandLeft = dynamicIslandCenterX - (dynamicIslandWidth / 2)
        let dynamicIslandRight = dynamicIslandCenterX + (dynamicIslandWidth / 2)
        
        // Y position: top safe area + small offset for dynamic island alignment
        let topY = size.height - topInset - 10
        
        // Date/Time Display (left of dynamic island)
        dateTimeDisplay = DateTimeDisplay()
        dateTimeDisplay.position = CGPoint(x: dynamicIslandLeft - 50, y: topY)
        dateTimeDisplay.zPosition = ZPositions.ui
        addChild(dateTimeDisplay)
        
        // Health Display (right of dynamic island)
        healthDisplay = HealthDisplay()
        healthDisplay.position = CGPoint(x: dynamicIslandRight, y: topY)
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
        
        // Update background based on current scenario/level
        updateBackgroundForLevel()
        
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
    
    private func updateBackgroundForLevel() {
        // Update background image based on current scenario index
        // For now using scenario_1, but can be extended to use different backgrounds per level
        let backgroundImageName = "scenario_1"
        
        // Only update if the background node exists and we need to change it
        if let backgroundNode = backgroundNode {
            let newTexture = SKTexture(imageNamed: backgroundImageName)
            backgroundNode.texture = newTexture
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
