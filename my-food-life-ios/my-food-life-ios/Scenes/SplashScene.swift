//
//  SplashScene.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class SplashScene: SKScene {
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupLogo()
        
        // Auto-transition to main menu after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.transitionToMainMenu()
        }
    }
    
    private func setupBackground() {
        // Lavender background
        backgroundColor = GameColors.bgPrimary
    }
    
    private func setupLogo() {
        // Create circular logo placeholder
        let logoRadius: CGFloat = 120
        let logoCircle = SKShapeNode(circleOfRadius: logoRadius)
        logoCircle.fillColor = GameColors.logoCircle
        logoCircle.strokeColor = .clear
        logoCircle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        logoCircle.zPosition = 10
        addChild(logoCircle)
        
        // Add "LOGO" text placeholder
        let logoText = SKLabelNode.createLabel(
            text: "LOGO",
            fontSize: 32,
            color: GameColors.textPrimary
        )
        logoText.position = CGPoint(x: size.width / 2, y: size.height / 2 - 10)
        logoText.zPosition = 11
        addChild(logoText)
        
        // Subtle fade-in animation
        logoCircle.alpha = 0
        logoText.alpha = 0
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.8)
        logoCircle.run(fadeIn)
        logoText.run(fadeIn)
    }
    
    private func transitionToMainMenu() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let mainMenuScene = MainMenuScene(size: size)
        mainMenuScene.scaleMode = scaleMode
        view?.presentScene(mainMenuScene, transition: transition)
    }
}
