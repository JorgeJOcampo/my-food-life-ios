//
//  Constants.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

struct GameColors {
    // Background colors
    static let bgPrimary = SKColor(hex: "#0a0e1a")
    static let bgSecondary = SKColor(hex: "#141824")
    static let bgCard = SKColor(hex: "#1e2332", alpha: 0.8)
    
    // Accent colors
    static let accentPrimary = SKColor(hex: "#ff6b6b")
    static let accentSecondary = SKColor(hex: "#4ecdc4")
    static let accentSuccess = SKColor(hex: "#95e1d3")
    static let accentDanger = SKColor(hex: "#ff4757")
    
    // Text colors
    static let textPrimary = SKColor.white
    static let textSecondary = SKColor(hex: "#b8c1ec")
    static let textMuted = SKColor(hex: "#6c7a9b")
    
    // Gradient colors
    static let gradientPurple1 = SKColor(hex: "#667eea")
    static let gradientPurple2 = SKColor(hex: "#764ba2")
    static let gradientDanger1 = SKColor(hex: "#ff6b6b")
    static let gradientDanger2 = SKColor(hex: "#ee5a6f")
    static let gradientSuccess1 = SKColor(hex: "#4ecdc4")
    static let gradientSuccess2 = SKColor(hex: "#44a08d")
}

struct GameFonts {
    static let title: CGFloat = 48
    static let subtitle: CGFloat = 24
    static let body: CGFloat = 18
    static let small: CGFloat = 16
    static let tiny: CGFloat = 14
}

struct GameLayout {
    static let padding: CGFloat = 20
    static let cornerRadius: CGFloat = 12
    static let buttonHeight: CGFloat = 60
    static let heartSize: CGFloat = 40
    static let foodImageHeight: CGFloat = 350
}

struct GameAnimations {
    static let fast: TimeInterval = 0.2
    static let normal: TimeInterval = 0.3
    static let slow: TimeInterval = 0.5
}

struct ZPositions {
    static let background: CGFloat = 0
    static let foodImage: CGFloat = 10
    static let ui: CGFloat = 20
    static let buttons: CGFloat = 30
    static let overlay: CGFloat = 40
    static let message: CGFloat = 50
}
