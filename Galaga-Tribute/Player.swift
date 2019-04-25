import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

class Player: SKSpriteNode{
    
    var player = SKSpriteNode(imageNamed: "shuttle")
    
    var xLocation: CGFloat = 0
    var yLocation: CGFloat = 0
//
//    var motionManager: CMMotionManager!
//    var xAccel: CGFloat!
//
    
    init() {
        let texture = SKTexture(imageNamed: "shuttle")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.isHidden = true
    }
    
    
    init(xLocation: CGFloat, yLocation: CGFloat) {
        let texture = SKTexture(imageNamed: "shuttle")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.xLocation = xLocation
        self.yLocation = yLocation
    
    }
    
    init(xLocation: CGFloat) {
        let texture = SKTexture(imageNamed: "shuttle")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.xLocation = xLocation
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func didMove(){
        
        
    }
    
}
