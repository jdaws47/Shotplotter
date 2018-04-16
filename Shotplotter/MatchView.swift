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
    var numOfPlayers: Int
    
    init() { // TODO: Make a proper initializer with arguments
        dateCreated = NSDate.init()
        opponentName = ""
        dateEdited = NSDate.init()
        datePlayed = NSDate.init()
        firstView = true
        numOfPlayers = 12
        for i in 0..<12 {
            playerNumShift(newNum: i + 1)
        }
        addGame()
        addGame()
        addGame()
    }
    
    public func addGame() { // Adds a blank game to the end of the array, sets it's GameNumber
        games.append(GameView(_gameNum:games.count, _players:players))
    }
    
    // A function that runs when the number of players on a team is changed. Either removes a player or initializes a new one
    // TODO: Find all locations that call this multiple times and replace them with a single call. Multiple changes have been implemented.
    func playerNumShift(newNum: Int) {
        let oldNum = players.count
        let inc: Bool
        inc = (oldNum < newNum)
        if (inc) { // If a new player is added
            while (players.count < newNum) {
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
                players.append(Player.init(_number: newNumber, _color: newColor.cgColor, _name: ""))
            }
        } else { // If a player is being removed
            while (players.count > newNum) {
                players.removeLast()
            }
        }
        syncColors()
    }
    
    // Updates which players are associated with each color based off their position 
    func syncColors() {
        for i in 0...players.count - 1 {
            if (i < playerColors.count) {
                players[i].color = playerColors[i]
            } else {
                players[i].color = UIColor.black.cgColor
            }
            //add function that causes buttons to update colors
        }
    }
}
