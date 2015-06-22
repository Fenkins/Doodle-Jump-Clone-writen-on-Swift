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
    
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var gameOverStatus: UILabel!
    @IBOutlet weak var scoreCount: UILabel!
    @IBOutlet weak var scoreNewRecordSet: UILabel!
    @IBOutlet weak var playAgainButtonOut: UIButton!
    
    
    var PlatformDropDownFor:CGFloat = 0.0
    
    var UpMovement:CGFloat = 0
    var SideMovement:CGFloat = 0
    var MoveLeft = false
    var MoveRight = false
    var StopSideMovement = false
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    
    let movingConstant:Float = 0.1
    
    var platform2sideMovement:CGFloat = 0.0
    var platform4sideMovement:CGFloat = 0.0
    
    var repeatThis = NSTimer()
    
    var scoreNumber:Int = 0
    var highScoreNumber:Int = 0
    var addedScore:Int = 0
    var levelNumber:Int = 1
    
    var platformUsed = false
    var platform1Used = false
    var platform2Used = false
    var platform3Used = false
    var platform4Used = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        platformImage.hidden = true
        platformImage1.hidden = true
        platformImage2.hidden = true
        platformImage3.hidden = true
        platformImage4.hidden = true
        
        gameOverStatus.hidden = true
        scoreCount.hidden = true
        scoreNewRecordSet.hidden = true
        playAgainButtonOut.hidden = true
        
        let screenRect = UIScreen.mainScreen().bounds
        screenWidth = screenRect.width
        screenHeight = screenRect.height
        
        platformUsed = false
        platform1Used = false
        platform2Used = false
        platform3Used = false
        platform4Used = false
        
        highScoreNumber = NSUserDefaults.standardUserDefaults().integerForKey("HighScoreSaved")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scoring() {
        // Raising the score as the ball goes higher. Method is ticking with the moving method
        scoreNumber += addedScore
        addedScore -= 1
        if addedScore < 0 {
            addedScore = 0
        }
        currentScore.text = "Score: " + "\(scoreNumber)"
        if scoreNumber > 500 && scoreNumber < 1000 {
            levelNumber = 2
        }
        if scoreNumber/levelNumber > 500 {
            levelNumber += 1
        }
    }
    
    func gameOver() {
        platformImage.hidden = true
        platformImage1.hidden = true
        platformImage2.hidden = true
        platformImage3.hidden = true
        platformImage4.hidden = true
        ballImage.hidden = true
        currentScore.hidden = true
        
        gameOverStatus.hidden = false
        playAgainButtonOut.hidden = false
        if scoreNumber > highScoreNumber {
            NSUserDefaults.standardUserDefaults().setInteger(scoreNumber, forKey: "HighScoreSaved")
            scoreNewRecordSet.hidden = false
            scoreNewRecordSet.text = "You've set the New Record: " +  "\(scoreNumber)"
        }
        else {
            scoreCount.hidden = false
            scoreCount.text = "Your HighScore: " + "\(scoreNumber)"
        }
        UpMovement = 0
        SideMovement = 0
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
        if ballImage.center.y > screenHeight {
            // Stopping the game
            gameOver()
            repeatThis.invalidate()
        }
        
        // We dont want for ball to go higher then half of the screen
        if ballImage.center.y > (screenHeight - ballImage.bounds.height/2) {
            ballImage.center = CGPointMake(ballImage.center.x, screenHeight)
        }
        
        if MoveLeft == true {
            SideMovement -= CGFloat(movingConstant * 3)
            //Maximum speed is 5
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
        UpMovement -= CGFloat(movingConstant)
        if CGRectIntersectsRect(ballImage.frame, platformImage.frame) && UpMovement <= 0 {
            Bounce()
            PlatformDropDown()
            if platformUsed == false {
                addedScore = 10
                platformUsed = true
            }
        }
        if CGRectIntersectsRect(ballImage.frame, platformImage1.frame) && UpMovement <= 0 {
            Bounce()
            PlatformDropDown()
            if platform1Used == false {
                addedScore = 10
                platform1Used = true
            }
        }
        if CGRectIntersectsRect(ballImage.frame, platformImage2.frame) && UpMovement <= 0 {
            Bounce()
            PlatformDropDown()
            if platform2Used == false {
                addedScore = 10
                platform2Used = true
            }
        }
        if CGRectIntersectsRect(ballImage.frame, platformImage3.frame) && UpMovement <= 0 {
            Bounce()
            PlatformDropDown()
            if platform3Used == false {
                addedScore = 10
                platform3Used = true
            }
        }
        if CGRectIntersectsRect(ballImage.frame, platformImage4.frame) && UpMovement <= 0 {
            Bounce()
            PlatformDropDown()
            if platform4Used == false {
                addedScore = 10
                platform4Used = true
            }
        }
        PlatformMovement()
        scoring()
    }
    
    func Bounce() {
        var arrayImage:[UIImage] = []
        arrayImage.append(UIImage(named: "ball.png")!)
        arrayImage.append(UIImage(named: "ballSQ1.png")!)
        arrayImage.append(UIImage(named: "ballSQ2.png")!)
        arrayImage.append(UIImage(named: "ballSQ1.png")!)
        arrayImage.append(UIImage(named: "ball.png")!)

        ballImage.animationImages = arrayImage
        ballImage.animationRepeatCount = 1
        ballImage.animationDuration = 0.2
        ballImage.startAnimating()
            // CounterWeight
        if ballImage.center.y > 450 {
            UpMovement = 5
        }
        if ballImage.center.y > 350 {
            UpMovement = 4
        }
        if ballImage.center.y > 150 {
            UpMovement = 3
        }
    }
    
    func GameStarted() {
        startGameButtonOut.hidden = true
        platformImage.hidden = false
        platformImage1.hidden = false
        platformImage2.hidden = false
        platformImage3.hidden = false
        platformImage4.hidden = false
        UpMovement = -5
        repeatThis = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "Moving", userInfo: nil, repeats: true)
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
    
    // Moving platforms left and right * also up and down
    func PlatformMovement() {
        platformImage.center = CGPointMake(platformImage.center.x, platformImage.center.y + PlatformDropDownFor)
        platformImage1.center = CGPointMake(platformImage1.center.x, platformImage1.center.y + PlatformDropDownFor)
        platformImage2.center = CGPointMake(platformImage2.center.x + platform2sideMovement, platformImage2.center.y + PlatformDropDownFor)
        platformImage3.center = CGPointMake(platformImage3.center.x, platformImage3.center.y + PlatformDropDownFor)
        platformImage4.center = CGPointMake(platformImage4.center.x + platform4sideMovement, platformImage4.center.y + PlatformDropDownFor)
        //Checking the edges collision
        if platformImage2.center.x >= screenWidth - (platformImage2.bounds.width/2) || platformImage2.center.x <= 0 + (platformImage2.bounds.width/2) {
            platform2sideMovement *= -1
        } else if platformImage4.center.x >= screenWidth - (platformImage4.bounds.width/2) || platformImage4.center.x <= 0 + (platformImage4.bounds.width/2) {
            platform4sideMovement *= -1
        }
        //Stopping the platforms falloff
        PlatformDropDownFor -= CGFloat(movingConstant)
        if PlatformDropDownFor < 0 {
            PlatformDropDownFor = 0
        }
        //Checking if platform is falled off the screen and bringing platforms back from the top
        if platformImage.center.y >= (screenHeight + platformImage.bounds.size.height/2) {
            var randomPosition = CGFloat(arc4random_uniform(UInt32(screenWidth - (platformImage.bounds.size.width))))
            randomPosition += (platformImage.bounds.size.width/2)
            platformImage.center = CGPointMake(randomPosition, -(platformImage.bounds.size.height))
            platformUsed = false
        }
        if platformImage1.center.y >= (screenHeight + platformImage1.bounds.size.height/2) {
            var randomPosition = CGFloat(arc4random_uniform(UInt32(screenWidth - (platformImage1.bounds.size.width))))
            randomPosition += (platformImage1.bounds.size.width/2)
            platformImage1.center = CGPointMake(randomPosition, -(platformImage1.bounds.size.height))
            platform1Used = false
        }
        if platformImage2.center.y >= (screenHeight + platformImage2.bounds.size.height/2) {
            var randomPosition = CGFloat(arc4random_uniform(UInt32(screenWidth - (platformImage2.bounds.size.width))))
            randomPosition += (platformImage2.bounds.size.width/2)
            platformImage2.center = CGPointMake(randomPosition, -(platformImage2.bounds.size.height))
            platform2Used = false
        }
        if platformImage3.center.y >= (screenHeight + platformImage3.bounds.size.height/2) {
            var randomPosition = CGFloat(arc4random_uniform(UInt32(screenWidth - (platformImage3.bounds.size.width))))
            randomPosition += (platformImage3.bounds.size.width/2)
            platformImage3.center = CGPointMake(randomPosition, -(platformImage3.bounds.size.height))
            platform3Used = false
        }
        if platformImage4.center.y >= (screenHeight + platformImage4.bounds.size.height/2) {
            var randomPosition = CGFloat(arc4random_uniform(UInt32(screenWidth - (platformImage4.bounds.size.width))))
            randomPosition += (platformImage4.bounds.size.width/2)
            platformImage4.center = CGPointMake(randomPosition, -(platformImage4.bounds.size.height))
            platform4Used = false
        }
println("PLATFORMS COORD__0___ \(platformImage.center.x),\(platformImage.center.y)")
println("PLATFORMS COORD__1___ \(platformImage1.center.x),\(platformImage1.center.y)")
println("PLATFORMS COORD__2___ \(platformImage2.center.x),\(platformImage2.center.y)")
println("PLATFORMS COORD__3___ \(platformImage3.center.x),\(platformImage3.center.y)")
println("PLATFORMS COORD__4___ \(platformImage4.center.x),\(platformImage4.center.y)")

    }
    
    func PlatformDropDown() {
        if ballImage.center.y > 500 {
            PlatformDropDownFor = 1.0
        }
        if ballImage.center.y > 450 {
            PlatformDropDownFor = 2.0
        }
        if ballImage.center.y > 400 {
            PlatformDropDownFor = 3.0
        }
        if ballImage.center.y > 300 {
            PlatformDropDownFor = 4.0
        }
        if ballImage.center.y > 250 {
            PlatformDropDownFor = 5.0
        }
        if ballImage.center.y > 200 {
            PlatformDropDownFor = 6.0
        }
println("PLATFORM DROPPED_____ \(PlatformDropDownFor)__")
    }
    
    
}
