//
//  DateTimeDisplay.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class DateTimeDisplay: SKNode {
    private let iconLabel: SKLabelNode
    private let textLabel: SKLabelNode
    
    override init() {
        iconLabel = SKLabelNode(text: "📅")
        iconLabel.fontSize = 24
        iconLabel.position = CGPoint(x: -10, y: 0)
        
        textLabel = SKLabelNode.createLabel(text: "", fontSize: GameFonts.small, color: GameColors.textSecondary)
        textLabel.horizontalAlignmentMode = .left
        textLabel.position = CGPoint(x: 20, y: 0)
        
        super.init()
        
        addChild(iconLabel)
        addChild(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateText(_ text: String) {
        textLabel.text = text
    }
}
