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
    
    let movingConstant:Float = 0.1
    
    var platform2sideMovement:CGFloat = 0.0
    var platform4sideMovement:CGFloat = 0.0
    
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        StopSideMovement = false
        if let touch = touches.first as? UITouch {
            if touch.locationInView(self.view).x > screenWidth/2 {
                MoveRight = true
            } else if touch.locationInView(self.view).x < screenWidth/2 {
                MoveLeft = true
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        StopSideMovement = true
        MoveLeft = false
        MoveRight = false
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
        if MoveLeft == true {
            SideMovement -= CGFloat(movingConstant * 3)
            if SideMovement <= -5 {
                SideMovement = -5
            }
            if ballImage.center.x <= ballImage.bounds.width/2 {
                ballImage.center.x = screenWidth - (ballImage.bounds.width/2)
            }
        }
        if MoveRight == true {
            SideMovement += CGFloat(movingConstant * 3)
            if SideMovement >= 5 {
                SideMovement = 5
            }
            if ballImage.center.x >= screenWidth - (ballImage.bounds.width/2) {
                ballImage.center.x = ballImage.bounds.width/2
            }
        }
        
        ballImage.center = CGPointMake(ballImage.center.x + SideMovement, ballImage.center.y - UpMovement)
        UpMovement -= 0.1
        if (CGRectIntersectsRect(ballImage.frame, platformImage.frame) && (UpMovement <= 0)) {
            Bounce()
        }
        PlatformMovement()
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
        
        randomPosition = CGFloat(arc4random_uniform(248))
        randomPosition += platformImage2.bounds.width/2
        platformImage2.center = CGPointMake(randomPosition, 336)
        
        randomPosition = CGFloat(arc4random_uniform(248))
        randomPosition += platformImage3.bounds.width/2
        platformImage3.center = CGPointMake(randomPosition, 224)
        
        randomPosition = CGFloat(arc4random_uniform(248))
        randomPosition += platformImage4.bounds.width/2
        platformImage4.center = CGPointMake(randomPosition, 112)
        
        platform2sideMovement = 1.5
        platform4sideMovement = -1.5
        
    }
    
    // Moving platforms left and right
    func PlatformMovement() {
        platformImage2.center = CGPointMake(platformImage2.center.x + platform2sideMovement, platformImage2.center.y)
        platformImage4.center = CGPointMake(platformImage4.center.x + platform4sideMovement, platformImage4.center.y)
        //Checking the edges collision
        if platformImage2.center.x >= screenWidth - (platformImage2.bounds.width/2) || platformImage2.center.x <= 0 + (platformImage2.bounds.width/2) {
            platform2sideMovement *= -1
        } else if platformImage4.center.x >= screenWidth - (platformImage4.bounds.width/2) || platformImage4.center.x <= 0 + (platformImage4.bounds.width/2) {
            platform4sideMovement *= -1
        }
    }
    
}
