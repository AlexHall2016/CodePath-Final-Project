//
//  GameOverViewController.swift
//  Galaga-Tribute
//
//  Created by Anthony Owyeong on 5/3/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeButton.clipsToBounds = true
        homeButton.layer.cornerRadius = 25
        
        newGameButton.clipsToBounds = true
        newGameButton.layer.cornerRadius = 25
        
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
