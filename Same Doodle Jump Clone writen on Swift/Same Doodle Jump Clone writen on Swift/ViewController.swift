//
//  ViewController.swift
//  Same Doodle Jump Clone writen on Swift
//
//  Created by Fenkins on 10/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreNewRecordSet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let highscore = NSUserDefaults.standardUserDefaults().integerForKey("HighScoreSaved")
            scoreNewRecordSet.text = "HighScore: " + "\(highscore)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

