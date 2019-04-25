import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var player1:Player!
    var background: SKEmitterNode!
    
    let motionManager = CMMotionManager()
    var xAccel: CGFloat = 0
    
    var gameTimer:Timer!
    var alienTypes = ["alien", "alien2", "alien3"]
    
    override func didMove(to view: SKView) {
        
        //load background
        background = SKEmitterNode(fileNamed: "Spacebg")
        background.position = CGPoint(x: 625.5, y: 2463)
        background.scene?.scaleMode = .aspectFit
        background.advanceSimulationTime(15)
        background.zPosition = -1
        self.addChild(background)
        
        //load player ship
        player1 = Player.init(xLocation: self.frame.size.width/2)
        var yLocation = CGFloat(230)
        player1.position = CGPoint(x: player1.xLocation, y: yLocation)
        self.addChild(player1)
        
        //initiate motion
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){ (data: CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAccel = CGFloat(acceleration.x) * 2.5 + self.xAccel * 0.75
            }
        }
        
        //introduce the enemies
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc func addAlien() {
        alienTypes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: alienTypes) as! [String]
        
        let alien = SKSpriteNode(imageNamed: alienTypes[0])
        /*get random x position and set to cgfloat*/
        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)
        /*add to the display*/
        self.addChild(alien)
        
        /*animate the alien from top to bottom of screen*/
        let animationDuration = 6
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -alien.size.height), duration: TimeInterval(animationDuration)))
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
    }
    
    
    
    override func didSimulatePhysics() {
        
        //handle player movement updates
        player1.position.x += xAccel
       
        if (player1.position.x < -20) {
            player1.position = CGPoint(x:self.size.width + 20, y: player1.position.y)
        } else if(player1.position.x > self.frame.width + 20) {
            player1.position = CGPoint(x:-20, y: player1.position.y)
        }
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
