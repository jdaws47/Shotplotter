//
//  MatchView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit

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
    
    func playerNumShift(newNum: Int) {
        let oldNum = players.count
        let inc: Bool
        inc = (oldNum < newNum)
        if (inc) {
            var double = true
            var newNumber = 1
            while (double) {
                double = false
                for player in players {
                    if (newNumber == player.number) {double = true}
                }
                if (double) {newNumber += 1}
            }
            var newColor = UIColor.black// >>>>Ignore what it tells you. Do NOT change this to a let!<<<<
            players.append(Player.init(_number: newNumber, _color: newColor))
        }
        syncColors()
    }
    
    //
    func syncColors() {
        for i in 0...players.count {
            if (i < players.count) {
                players[i].color = playerColors[i]
            } else {
                players[i].color = UIColor.black
            }
            //add function that causes buttons to update colors
        }
    }
}
