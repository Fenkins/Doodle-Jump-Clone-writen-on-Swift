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
    @IBOutlet weak var platformImage1: UIImageView!
    @IBOutlet weak var platformImage2:UIImageView!
    @IBOutlet weak var platformImage3:UIImageView!
    @IBOutlet weak var platformImage4:UIImageView!
    @IBOutlet weak var startGameButtonOut: UIButton!
    
    var UpMovement:CGFloat = 0
    var SideMovement:CGFloat = 0
    var MoveLeft = false
    var MoveRight = false
    var StopSideMovement = false
    var screenWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        platformImage.hidden = true
        platformImage1.hidden = true
        platformImage2.hidden = true
        platformImage3.hidden = true
        platformImage4.hidden = true
        
        let screenRect = UIScreen.mainScreen().bounds
        screenWidth = screenRect.width
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
        UpMovement -= 0.1
        if (CGRectIntersectsRect(ballImage.frame, platformImage.frame) && (UpMovement <= 0)) {
            Bounce()
        }
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
        platformImage1.hidden = false
        platformImage2.hidden = false
        platformImage3.hidden = false
        platformImage4.hidden = false
        UpMovement = -5
        var repeatThis = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "Moving", userInfo: nil, repeats: true)
        var randomPosition = CGFloat(arc4random_uniform(248))
        randomPosition += platformImage1.bounds.width/2
        platformImage1.center = CGPointMake(randomPosition, 448)
        
    }
    
}
