//
//  GameViewController.swift
//  Same Doodle Jump Clone writen on Swift
//
//  Created by Fenkins on 10/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBAction func startGameButton(sender: AnyObject) {GameStarted()
    }
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var platformImage: UIImageView!

    @IBOutlet weak var startGameButtonOut: UIButton!
    
    var UpMovement:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        platformImage.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func Moving() {
        ballImage.center = CGPointMake(ballImage.center.x, ballImage.center.y - UpMovement)
        if (CGRectIntersectsRect(ballImage.frame, platformImage.frame) && (UpMovement <= 0)) { self.Bounce()}
    UpMovement = UpMovement - 0.1
    }
    
    func Bounce() {
        var arrayImage:[UIImage] = []
        arrayImage.append(UIImage(named: "ballSQ1.png")!)
        arrayImage.append(UIImage(named: "ballSQ2.png")!)
        arrayImage.append(UIImage(named: "ballSQ1.png")!)
        arrayImage.append(UIImage(named: "ball.png")!)
        
        ballImage.animationImages = arrayImage
        ballImage.animationRepeatCount = 1
        ballImage.animationDuration = 0.2
        ballImage.startAnimating()
        UpMovement = 5
    }
    
    func GameStarted() {
        startGameButtonOut.hidden = true
        platformImage.hidden = false
        UpMovement = -5
        var Movement = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "Moving", userInfo: nil, repeats: true)
    }
    
}
