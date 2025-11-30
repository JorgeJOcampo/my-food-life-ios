//
//  MainMenuScene.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    private var newGameButton: MenuButton!
    private var continueButton: MenuButton!
    private var settingsButton: MenuButton!
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupLogo()
        setupButtons()
    }
    
    private func setupBackground() {
        backgroundColor = GameColors.bgPrimary
    }
    
    private func setupLogo() {
        // Logo circle at top
        let logoRadius: CGFloat = 100
        let logoCircle = SKShapeNode(circleOfRadius: logoRadius)
        logoCircle.fillColor = GameColors.logoCircle
        logoCircle.strokeColor = .clear
        logoCircle.position = CGPoint(x: size.width / 2, y: size.height - 200)
        logoCircle.zPosition = 10
        addChild(logoCircle)
        
        let logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.position = CGPoint(x: size.width / 2, y: size.height - 210)
        logoImg.zPosition = 11
        addChild(logoImg)
    }
    
    private func setupButtons() {
        let buttonWidth: CGFloat = size.width - 100
        let centerX = size.width / 2
        let startY: CGFloat = size.height / 2 + 20
        let spacing: CGFloat = 80
        
        // Check if saved game exists
        let hasSave = SaveManager.shared.hasSavedGame()
        
        // New Game button
        newGameButton = MenuButton(text: "New Game", width: buttonWidth)
        newGameButton.position = CGPoint(x: centerX, y: startY)
        newGameButton.zPosition = 20
        newGameButton.onTap = { [weak self] in
            self?.startNewGame()
        }
        addChild(newGameButton)
        
        // Continue button (only if save exists)
        if hasSave {
            continueButton = MenuButton(text: "Continue", width: buttonWidth)
            continueButton.position = CGPoint(x: centerX, y: startY - spacing)
            continueButton.zPosition = 20
            continueButton.onTap = { [weak self] in
                self?.continueGame()
            }
            addChild(continueButton)
            
            // Settings button (lower position when Continue is visible)
            settingsButton = MenuButton(text: "Settings", width: buttonWidth)
            settingsButton.position = CGPoint(x: centerX, y: startY - spacing * 2)
            settingsButton.zPosition = 20
            settingsButton.onTap = { [weak self] in
                self?.showSettings()
            }
            addChild(settingsButton)
        } else {
            // Settings button (higher position when no Continue button)
            settingsButton = MenuButton(text: "Settings", width: buttonWidth)
            settingsButton.position = CGPoint(x: centerX, y: startY - spacing)
            settingsButton.zPosition = 20
            settingsButton.onTap = { [weak self] in
                self?.showSettings()
            }
            addChild(settingsButton)
        }
    }
    
    private func startNewGame() {
        // Delete any existing save
        SaveManager.shared.deleteSave()
        
        // Transition to game scene
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        view?.presentScene(gameScene, transition: transition)
    }
    
    private func continueGame() {
        // Load saved game
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: size, loadFromSave: true)
        gameScene.scaleMode = scaleMode
        view?.presentScene(gameScene, transition: transition)
    }
    
    private func showSettings() {
        // Placeholder for settings screen
        print("Settings tapped - not implemented yet")
    }
}

// MARK: - MenuButton Component

class MenuButton: SKNode {
    private var background: SKShapeNode!
    private let buttonWidth: CGFloat
    private let buttonHeight: CGFloat = 60
    private let button = SKSpriteNode(imageNamed: "choice_button_background")
    
    var onTap: (() -> Void)?
    var isEnabled: Bool = true
    
    init(text: String, width: CGFloat) {
        self.buttonWidth = width
        super.init()
        
        let label = SKLabelNode.createLabel(
            text: text,
            fontSize: 22,
            color: GameColors.textMenu
        )
        label.fontName = "Pixel Operator HB 8"
        button.addChild(label)
        addChild(button)
        // Enable touch
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }
        
        // Scale down animation
        let scaleDown = SKAction.scale(to: 0.95, duration: 0.1)
        run(scaleDown)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }
        
        // Scale back up
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.1)
        run(scaleUp)
        
        // Check if touch is still within bounds
        if let touch = touches.first {
            let location = touch.location(in: self)
            let rect = CGRect(
                x: -buttonWidth / 2,
                y: -buttonHeight / 2,
                width: buttonWidth,
                height: buttonHeight
            )
            
            if rect.contains(location) {
                onTap?()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset scale
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.1)
        run(scaleUp)
    }
}
