//
//  DateTimeDisplay.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class DateTimeDisplay: SKNode {
    private let textLabel: SKLabelNode
    private let backgroundNode: SKShapeNode
    
    override init() {
        // Create background box
        let boxSize = CGSize(width: 120, height: 40)
        backgroundNode = SKShapeNode(rectOf: boxSize)
        backgroundNode.fillColor = SKColor(hex: "#F5EDD8") // Cream color
        backgroundNode.strokeColor = SKColor(hex: "#2D2D2D") // Dark border
        backgroundNode.lineWidth = 2
        
        // Create text label
        textLabel = SKLabelNode(fontNamed: GameFonts.mainFontName)
        textLabel.text = "01/98" // Placeholder
        textLabel.fontSize = 15
        textLabel.fontColor = SKColor(hex: "#2D2D2D")
        textLabel.verticalAlignmentMode = .center
        textLabel.horizontalAlignmentMode = .center
        textLabel.position = CGPoint(x: 0, y: 0)
        
        super.init()
        
        addChild(backgroundNode)
        addChild(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateText(_ text: String) {
        textLabel.text = text
    }
}
