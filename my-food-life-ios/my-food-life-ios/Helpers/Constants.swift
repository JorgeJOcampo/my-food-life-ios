//
//  Constants.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

struct GameColors {
    // Figma Background colors
    static let bgPrimary = SKColor(hex: "#C8B6E2") // Lavender background
    static let bgSecondary = SKColor(hex: "#D4C4EC") // Lighter lavender
    static let bgCard = SKColor(hex: "#F5EDD8", alpha: 0.95) // Cream/beige card
    
    // Logo and UI elements
    static let logoCircle = SKColor(hex: "#F5F0E8") // Cream circle for logo
    static let buttonFill = SKColor(hex: "#F5EDD8") // Cream button fill
    static let buttonStroke = SKColor(hex: "#FF9B9B") // Pink/coral button border
    
    // Accent colors
    static let accentPrimary = SKColor(hex: "#FF9B9B") // Pink/coral
    static let accentSecondary = SKColor(hex: "#FFB6C1") // Light pink
    static let accentSuccess = SKColor(hex: "#95e1d3")
    static let accentDanger = SKColor(hex: "#ff4757")
    
    // Text colors
    static let textPrimary = SKColor(hex: "#2D2D2D") // Dark gray/black
    static let textSecondary = SKColor(hex: "#4A4A4A") // Medium gray
    static let textMuted = SKColor(hex: "#6c7a9b")
    
    // Game screen specific
    static let gameBackground = SKColor(hex: "#F5DEB3") // Tan/beige for game screen
    static let heartPink = SKColor(hex: "#FFB6D9") // Pink hearts
    
    // Gradient colors (keeping for compatibility)
    static let gradientPurple1 = SKColor(hex: "#C8B6E2")
    static let gradientPurple2 = SKColor(hex: "#B8A6D2")
    static let gradientDanger1 = SKColor(hex: "#ff6b6b")
    static let gradientDanger2 = SKColor(hex: "#ee5a6f")
    static let gradientSuccess1 = SKColor(hex: "#4ecdc4")
    static let gradientSuccess2 = SKColor(hex: "#44a08d")
}

struct GameFonts {
    static let mainFontName = "Pixel Operator HB 8"
    
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
