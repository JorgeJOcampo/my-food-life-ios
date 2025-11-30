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
        
        let logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.position = CGPoint(x: size.width / 2, y: size.height / 2 - 10)
        logoImg.zPosition = 11
        addChild(logoImg)
        
        // Subtle fade-in animation
        logoCircle.alpha = 0
        logoImg.alpha = 0
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.8)
        logoCircle.run(fadeIn)
        logoImg.run(fadeIn)
    }
    
    private func transitionToMainMenu() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let mainMenuScene = MainMenuScene(size: size)
        mainMenuScene.scaleMode = scaleMode
        view?.presentScene(mainMenuScene, transition: transition)
    }
}
