//
//  MenuViewController.swift
//  Galaga-Tribute
//
//  Created by Alexander Hall on 4/13/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import SpriteKit
import GameplayKit


class MenuViewController: UIViewController {

    @IBAction func playPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "GameSegue", sender: nil)
        
       /*
        let gamescene = SKScene(fileNamed: "GameScene")
        
        //SKScene(size: view.bounds.size)
        
        let vc = self.view
        vc?.isHidden = true
        
        let skView = self.view as! SKView
        
        skView.presentScene(gamescene)
        
        
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
