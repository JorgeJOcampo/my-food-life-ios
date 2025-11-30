//
//  Extensions.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

extension SKColor {
    /// Initialize SKColor from hex string
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension SKNode {
    /// Add a fade in animation
    func fadeIn(duration: TimeInterval = GameAnimations.normal) {
        let fadeIn = SKAction.fadeIn(withDuration: duration)
        self.run(fadeIn)
    }
    
    /// Add a fade out animation
    func fadeOut(duration: TimeInterval = GameAnimations.normal) {
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        self.run(fadeOut)
    }
    
    /// Add a scale animation
    func pulse(scale: CGFloat = 1.1, duration: TimeInterval = GameAnimations.fast) {
        let scaleUp = SKAction.scale(to: scale, duration: duration)
        let scaleDown = SKAction.scale(to: 1.0, duration: duration)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        self.run(sequence)
    }
}

extension SKAction {
    /// Create a shake animation
    static func shake(duration: TimeInterval = 0.6, amplitude: CGFloat = 10) -> SKAction {
        let moveLeft = SKAction.moveBy(x: -amplitude, y: 0, duration: duration / 4)
        let moveRight = SKAction.moveBy(x: amplitude * 2, y: 0, duration: duration / 2)
        let moveBack = SKAction.moveBy(x: -amplitude, y: 0, duration: duration / 4)
        return SKAction.sequence([moveLeft, moveRight, moveBack])
    }
    
    /// Create a heartbeat animation
    static func heartbeat() -> SKAction {
        let scaleUp = SKAction.scale(to: 1.05, duration: 0.75)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.75)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        return SKAction.repeatForever(sequence)
    }
}

extension SKSpriteNode {
    /// Create a rounded rectangle sprite
    static func roundedRect(size: CGSize, cornerRadius: CGFloat, color: SKColor) -> SKSpriteNode {
        let rect = SKSpriteNode(color: color, size: size)
        // Note: SpriteKit doesn't have built-in rounded corners, so we use a solid rectangle
        // For true rounded corners, you'd need to use a custom texture or SKShapeNode
        return rect
    }
}

extension SKLabelNode {
    /// Create a label with common settings
    static func createLabel(text: String, fontSize: CGFloat, color: SKColor = GameColors.textPrimary) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: GameFonts.mainFontName)
        label.text = text
        label.fontSize = fontSize
        label.fontColor = color
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        return label
    }
}
