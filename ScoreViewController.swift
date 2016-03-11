//
//  ScoreViewController.swift
//  DieCockroachDie
//
//  Created by Matt Deuschle on 3/7/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import AVFoundation

class ScoreViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScore: UILabel!

    var audioPlayerThree : AVAudioPlayer?

    var playerScore = Player()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBarHidden = true


        do {
            try playSound("Dramatic", fileExtension: "mp3")
        } catch {
            return
        }

        saveData()
    }

    func saveData() {

        if let showCurrentScore = playerScore.userDefaults.stringForKey("curScore") {

            currentScore.text = "Cockroaches Crushed: \(showCurrentScore)"
        }

        if let showHighScore = playerScore.userDefaults.stringForKey("hiScore") {

            highScore.text = "High Score: \(showHighScore)"
        }
    }

    func playSound(fileName: String, fileExtension: String) throws {

        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

        dispatch_async(dispatchQueue, { let mainBundle = NSBundle.mainBundle()

            let filePath = mainBundle.pathForResource("\(fileName)", ofType:"\(fileExtension)")

            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)

                do {
                    /* Start the audio player */
                    self.audioPlayerThree = try AVAudioPlayer(data: fileData!)

                    guard let player : AVAudioPlayer? = self.audioPlayerThree else {
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

