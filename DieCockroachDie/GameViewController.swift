//
//  GameViewController.swift
//  DieCockroachDie
//
//  Created by Matt Deuschle on 3/7/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayerTwo : AVAudioPlayer?

    // outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!

    var countdownTimer = NSTimer()
    var newGameSegueTimer = NSTimer()
    var countdownTimerInt = 15
    var segueTimerInt = 2
    let player = Player()

    override func viewDidLoad() {

//        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBarHidden = true


        super.viewDidLoad()
        tapButton.enabled = true
        updateLabels()

        if let playerHiScore = player.userDefaults.stringForKey("hiScore") {

            player.highScore = Int(playerHiScore)!
        }
        else {

            print("Hello")

        }

        if let playerGamesPlay = player.userDefaults.stringForKey("gamesPlay") {

            player.gamesPlayed = Int(playerGamesPlay)!
        }
        else {

            print("Hello2")

        }
    }

    @IBAction func tapButtonTapped(sender: UIButton) {

        do {
            try playSound("Tap", fileExtension: "mp3")
        } catch {
            return
        }

        if countdownTimerInt <= 0 {

            //            tapButton.setImage(UIImage(named: "Cockroach3"), forState: UIControlState.Normal)
            updateLabels()
            tapButton.enabled = false
            segueTimerFunc()

            // save date to NSUserDefaults

            if player.currentScore > player.highScore {

                player.highScore = player.currentScore
            }
            player.userDefaults.setObject(player.currentScore, forKey: "curScore")
            player.userDefaults.setObject(player.highScore, forKey: "hiScore")
            player.userDefaults.setObject(player.gamesPlayed + 1, forKey: "gamesPlay")
        }

        else {

            tapButton.enabled = true
            player.currentScore++
            updateLabels()
            countdownTimerFunc()
        }
    }

    func countdownTimerFunc() {

        if player.currentScore <= 1 {

            countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("countdownTimerUpdate"), userInfo: nil, repeats: true)
        }
    }

    func countdownTimerUpdate() {

        countdownTimerInt -= 1
        timerLabel.text = String(countdownTimerInt)

        if countdownTimerInt <= 0 {

            countdownTimer.invalidate()
            timerLabel.text = String(countdownTimerInt)
        }
    }

    func segueTimerFunc() {

        newGameSegueTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "segueToScore", userInfo: nil, repeats: false)
    }

    func segueToScore() {

        performSegueWithIdentifier("ScoreSegue", sender: self)
    }
    
    func updateLabels() {
        
        timerLabel.text = String(countdownTimerInt)
        scoreLabel.text = String(player.currentScore)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let dvc = segue.destinationViewController as! ScoreViewController
        let playerScore = player
        dvc.playerScore = playerScore
    }

    func playSound(fileName: String, fileExtension: String) throws {

        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

        dispatch_async(dispatchQueue, { let mainBundle = NSBundle.mainBundle()

            let filePath = mainBundle.pathForResource("\(fileName)", ofType:"\(fileExtension)")

            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)

                do {
                    /* Start the audio player */
                    self.audioPlayerTwo = try AVAudioPlayer(data: fileData!)

                    guard let player : AVAudioPlayer? = self.audioPlayerTwo else {
                        return
                    }

                    /* Set the delegate and start playing */
                    player!.delegate = self
                    if player!.prepareToPlay() && player!.play() {
                        /* Successfully started playing */
                    } else {
                        /* Failed to play */
                    }

                } catch {
                    //self.audioPlayer = nil
                    return
                }
                
            }
            
        })
        
    }
}
