//
//  MenuScene.swift
//  Galaga-Tribute
//
//  Created by Anthony Owyeong on 4/16/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var StartButtonNode: SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        
        StartButtonNode = self.childNode(withName: "StartGameButton") as! SKSpriteNode
        
        
        
        
    }
    
    
    
}
