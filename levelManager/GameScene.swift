//
//  GameScene.swift
//  levelManager
//
//  Created by Norma Tu on 8/3/16.
//  Copyright (c) 2016 NormaTu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var contentNode: SKSpriteNode!
    var button: SKSpriteNode!
    
    var oldNode: SKNode?
    var contentNode2: SKSpriteNode!
    var contentNode3: SKSpriteNode!
    
    var transitionTime: CFTimeInterval = 0.5
    var level: Int = 0
    var levels = [SKNode]()  //Empty array of SKNodes
    var transitioning = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        contentSetUp() //Level 1
        contentSetUp_2() //Level 2
        contentSetUp_3() //Level 3
        moveOn(contentNode)
        buttonSetUp()

    }
    
    func buttonSetUp() {
        button = SKSpriteNode(color: UIColor.cyanColor(), size: CGSize(width: 50, height: 50))
        addChild(button)
        button.zPosition = 999
        button.position.x = size.width - 40
        button.position.y = 40
        button.name = "nextLevelButton"
    }
    
    func contentSetUp() {
        contentNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
        
        contentNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Hello"
        label.position.x = view!.frame.width/2
        label.position.y = view!.frame.height/2
        
        contentNode.addChild(label)
        levels.append(contentNode)
        
    }
    
    func contentSetUp_2() {
        contentNode2 = SKSpriteNode(color: UIColor.blueColor(), size: size)
        
        contentNode2.anchorPoint = CGPoint(x: 0, y: 0)
        
        let nextLabel = SKLabelNode(fontNamed: "Courier New Bold")
        nextLabel.text = "Hi there"
        nextLabel.position.x = size.width/2
        nextLabel.position.y = size.height/2
        
        contentNode2.addChild(nextLabel)
        levels.append(contentNode2)

    }
    
    func contentSetUp_3() {
        contentNode3 = SKSpriteNode(color: UIColor.darkGrayColor(), size: size)
        
        contentNode3.anchorPoint = CGPoint(x: 0, y: 0)
        
        let nextLabel = SKLabelNode(fontNamed: "Ariel")
        nextLabel.text = "Bye bye"
        nextLabel.position.x = size.width/2
        nextLabel.position.y = size.height/2
        
        contentNode3.addChild(nextLabel)
        levels.append(contentNode3)
    }

    
    func moveOn(node: SKNode) {
        
        transitioning = true
        
        if let oldNode = oldNode {
            let bye = SKAction.moveToX(-size.width, duration: transitionTime) //left
            let remove = SKAction.removeFromParent()
            
            oldNode.runAction(SKAction.sequence([bye, remove]))
        }
        
        node.position.x = size.width
        addChild(node)
        
        let moveAction = SKAction.moveToX(0, duration: transitionTime)
        
        let done =  SKAction.runBlock { 
            self.transitioning = false
        }
        
        node.runAction(SKAction.sequence([moveAction, done]))
        
        oldNode = node
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        let node = nodeAtPoint(location)
        if node.name == "nextLevelButton" {
            print("next level button pressed")
            
            if transitioning == false {
                
                //MARK: Where we change levels
                
                level += 1
                if level == levels.count {
                    level = 0
                }
                
                
                moveOn(levels[level])
            }
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
