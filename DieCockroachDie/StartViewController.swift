//
//  StartViewController.swift
//  DieCockroachDie
//
//  Created by Matt Deuschle on 3/7/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer?

    let startPlayer = Player()

    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var gamesPlayed: UILabel!

    var defaultsTwo = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true

        do {
            try playSound("Happy", fileExtension: "mp3")
        } catch {
            return
        }

        if (startPlayer.userDefaults.stringForKey("hiScore")) != nil {

            highScore.text = "High Score: " + (startPlayer.userDefaults.stringForKey("hiScore"))!
        }
        else {

            highScore.text = "High Score: 0"
        }

        if (startPlayer.userDefaults.stringForKey("gamesPlay")) != nil {

            gamesPlayed.text = "Games Played: " + (startPlayer.userDefaults.stringForKey("gamesPlay"))!
        }
        else {

            gamesPlayed.text = "Games Played: 0"
        }
    }


    @IBAction func unwindToStartVC(segue: UIStoryboardSegue) {

        highScore.text = "High Score: " + (startPlayer.userDefaults.stringForKey("hiScore"))!
        gamesPlayed.text = "Games Played: " + (startPlayer.userDefaults.stringForKey("gamesPlay"))!

    }

    func playSound(fileName: String, fileExtension: String) throws {

        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

        dispatch_async(dispatchQueue, { let mainBundle = NSBundle.mainBundle()

            let filePath = mainBundle.pathForResource("\(fileName)", ofType:"\(fileExtension)")

            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)

                do {
                    /* Start the audio player */
                    self.audioPlayer = try AVAudioPlayer(data: fileData!)

                    guard let player : AVAudioPlayer? = self.audioPlayer else {
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
