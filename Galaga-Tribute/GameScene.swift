import Foundation
import SpriteKit
import GameplayKit
import CoreMotion
import Parse

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
    var vc: UIViewController?
    var user: String!
    
    var player1:Player!
    var background: SKEmitterNode!
    
    let motionManager = CMMotionManager()
    var xAccel: CGFloat = 0
    
    var gameTimer:Timer!
    var alienTypes = ["enemy", "enemy2", "enemy3"]
    
    var livesArray:[SKSpriteNode]!
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let alienCategory:UInt32 = 0x1 << 0
    let bulletCategory:UInt32 = 0x1 << 0
    
    override func didMove(to view: SKView) {
        
        addLives()
        
        //load background
        background = SKEmitterNode(fileNamed: "Spacebg")
        background.position = CGPoint(x: 625.5, y: 2463)
        background.scene?.scaleMode = .aspectFit
        background.advanceSimulationTime(15)
        background.zPosition = -1
        self.addChild(background)
        

        //load player ship
        player1 = Player.init(xLocation: self.frame.size.width/2)
        let yLocation = CGFloat(230)
        player1.position = CGPoint(x: player1.xLocation, y: yLocation)
        self.addChild(player1)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height - 300)
        
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = UIColor.white
        score = 0
        self.addChild(scoreLabel)
    
        
        //initiate motion
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){ (data: CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAccel = CGFloat(acceleration.x) * 3.5 + self.xAccel * 0.85
            }
        }
        
        
        //introduce the enemies
        // 
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
    }
    
    func addLives(){
        livesArray = [SKSpriteNode]()
        
        for life in 1 ... 3 {
            let liveNode = SKSpriteNode(imageNamed: "shuttle")
            liveNode.position = CGPoint(x: self.frame.size.width - CGFloat(4 - life) * liveNode.size.width, y: self.frame.size.height - 120)
            
            self.addChild(liveNode)
            livesArray.append(liveNode)
            
        }
    }
    
    
    @objc func addAlien() {
        alienTypes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: alienTypes) as! [String]
        
        let alien = SKSpriteNode(imageNamed: alienTypes[0])
        /*get random x position and set to cgfloat*/
        /* lowest value and highest value set to prevent aliens going inbetween the screen */
        let randomAlienPosition = GKRandomDistribution(lowestValue: Int(10 + alien.size.width), highestValue: Int(self.frame.size.width - alien.size.width - 10))
        let position = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)
        /*add to the display*/
       
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = bulletCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        
        /*animate the alien from top to bottom of screen*/
        let animationDuration = 6
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -alien.size.height), duration: TimeInterval(animationDuration)))
        
        actionArray.append(SKAction.run {
            
            if self.livesArray.count > 0 {
                let liveNode = self.livesArray.first
                liveNode!.removeFromParent()
                self.livesArray.removeFirst()
                
                if self.livesArray.count == 0 {
                    self.gameOver()
                }
            }
        })
        
        actionArray.append(SKAction.removeFromParent())
        alien.run(SKAction.sequence(actionArray))
    }
    
    
    func gameOver() {
        /*store the user name and score into parse server*/
        let userScore = PFObject(className: "userScore")
        userScore["score"] = score
        userScore["playerName"] = "Harry Zhang"
        
        userScore.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                self.vc?.performSegue(withIdentifier: "gameOver", sender: self.vc)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTopedo()
    }
    
    
    func fireTopedo() {
        
        let torpedoNode = SKSpriteNode(imageNamed: "bullet")
        torpedoNode.position = player1.position
        torpedoNode.position.y += 3
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
        torpedoNode.physicsBody?.isDynamic = true
        
        torpedoNode.physicsBody?.categoryBitMask = bulletCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(torpedoNode)
        
        let animationDuration:TimeInterval = 1
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x:player1.position.x, y: self.frame.size.height + 10), duration: animationDuration))
        torpedoNode.run(SKAction.sequence(actionArray))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody!
        var secondBody:SKPhysicsBody!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & bulletCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            torpedoDidCollideWithAlien(torpedoNode: firstBody.node as! SKSpriteNode, alienNode: secondBody.node as! SKSpriteNode)
        }
    }
    
    func torpedoDidCollideWithAlien(torpedoNode:SKSpriteNode, alienNode: SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        //self.run(SKAtion.playSoundFileNamed("explosion.mp3" waitForCompletion:False))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        score += 5
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
