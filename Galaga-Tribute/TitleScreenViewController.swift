//
//  TitleScreenViewController.swift
//  Galaga-Tribute
//
//  Created by Alexander Hall on 4/13/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class TitleScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapTitleScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "TitleToMenuSegue", sender: nil)
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
