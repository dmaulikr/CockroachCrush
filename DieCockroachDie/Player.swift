//
//  Player.swift
//  DieCockroachDie
//
//  Created by Matt Deuschle on 3/7/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation

class Player {

    // properties
    var currentScore = Int()
    var highScore = Int()
    var gamesPlayed = Int()
    var userDefaults = NSUserDefaults.standardUserDefaults()

    // default initializers
    init() {

        currentScore = 0
        highScore = 0
        gamesPlayed = 0
    }

    // initializers with parameters
    init(currentScore: Int, highScore: Int, gamesPlayed: Int, userDefaults: NSUserDefaults) {

        self.currentScore = currentScore
        self.highScore = highScore
        self.gamesPlayed = gamesPlayed
        self.userDefaults = userDefaults
    }

}

