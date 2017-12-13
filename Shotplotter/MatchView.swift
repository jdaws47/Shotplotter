//
//  MatchView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation

class MatchView {
    var games = [GameView]()
    var players = [Player]()
    var dateCreated: NSDate
    var dateEdited: NSDate
    var datePlayed: NSDate
    var opponentName: String
    var firstView: Bool
    
    init() { //Make a proper initializer with arguments
        dateCreated = NSDate.init()
        opponentName = ""
        dateEdited = NSDate.init()
        datePlayed = NSDate.init()
        firstView = true
    }
    
    func addGame() {
        games.append(GameView(_gameNum:games.count, _players:players))
    }
}
