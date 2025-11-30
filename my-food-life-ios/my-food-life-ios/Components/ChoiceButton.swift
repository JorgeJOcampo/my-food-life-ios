//
//  ChoiceButton.swift
//  MyFoodLife
//
//  Created on 2025-11-30.
//

import SpriteKit

class ChoiceButton: SKNode {
    private let background: SKSpriteNode
    private let numberBadge: SKShapeNode
    private let numberLabel: SKLabelNode
    private let textLabel: SKLabelNode
    private let choiceNumber: Int
    
    var isEnabled: Bool = true
    var onTap: (() -> Void)?
    
    init(choiceNumber: Int, width: CGFloat) {
        self.choiceNumber = choiceNumber
        
        background = SKSpriteNode(imageNamed: "choice_button_background")
        
        background.size = CGSize(width: width, height: GameLayout.buttonHeight)
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 0 // Start at 0, other elements will be above
        background.isHidden = false // Ensure it's visible
        
        // Create number badge (circle)
        let badgeRadius: CGFloat = 16
        numberBadge = SKShapeNode(circleOfRadius: badgeRadius)
        numberBadge.fillColor = GameColors.accentPrimary // Pink badge
        numberBadge.strokeColor = .clear
        numberBadge.position = CGPoint(x: -width/2 + 40, y: 0)
        numberBadge.zPosition = 1 // Above background
        
        // Number label
        numberLabel = SKLabelNode.createLabel(text: "\(choiceNumber)", fontSize: 18, color: .white)
        numberLabel.fontName = "Inter-Bold"
        numberLabel.position = CGPoint(x: 0, y: -1)
        numberLabel.zPosition = 2 // Above badge
        
        // Text label
        textLabel = SKLabelNode.createLabel(text: "", fontSize: GameFonts.body, color: GameColors.textPrimary)
        textLabel.fontName = "Inter-SemiBold"
        textLabel.horizontalAlignmentMode = .left
        textLabel.position = CGPoint(x: -width/2 + 70, y: 0)
        textLabel.preferredMaxLayoutWidth = width - 100
        textLabel.numberOfLines = 0
        textLabel.zPosition = 1 // Above background
        
        super.init()
        
        addChild(background)
        addChild(numberBadge)
        numberBadge.addChild(numberLabel)
        addChild(textLabel)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        textLabel.text = text
    }
    
    func animateCorrect() {
        let scaleUp = SKAction.scale(to: 1.05, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.3)
        let colorize = SKAction.colorize(with: SKColor(hex: "#4ecdc4", alpha: 0.2), colorBlendFactor: 1.0, duration: 0.3)
        let sequence = SKAction.sequence([
            SKAction.group([scaleUp, colorize]),
            scaleDown
        ])
        background.run(sequence)
    }
    
    func animateWrong() {
        let shake = SKAction.shake(duration: 0.6, amplitude: 10)
        let colorize = SKAction.colorize(with: SKColor(hex: "#ff4757", alpha: 0.2), colorBlendFactor: 1.0, duration: 0.3)
        let sequence = SKAction.group([shake, colorize])
        background.run(sequence)
    }
    
    func reset() {
        setScale(1.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }
        setScale(0.98)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }
        setScale(1.0)
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            if background.contains(location) {
                onTap?()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}
