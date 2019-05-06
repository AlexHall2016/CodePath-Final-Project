//
//  UsernameViewController.swift
//  Galaga-Tribute
//
//  Created by Harry Zhang on 5/6/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class UsernameViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    
    var username: String = ""
    
    @IBAction func enterPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameSegue", sender: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameField.text = username
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the username to the game view controller.
        let gameViewController = segue.destination as! GameViewController
        
        gameViewController.username = username
    }
    

}
