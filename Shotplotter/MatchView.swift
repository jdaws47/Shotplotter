//
//  MatchView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

//////////////////////////////////////////////////////
///////      !!!!!! VERY IMPORTANT !!!!!!    /////////
///////    Does not currently save dates!!!  /////////
//////////////////////////////////////////////////////


import Foundation
import UIKit

class MatchView: Codable {
    var games = [GameView]()
    var players = [Player]()
    var dateCreated: NSDate
    var dateEdited: NSDate
    var datePlayed: NSDate
    var opponentName: String
    var firstView: Bool
    var numOfPlayers: Int
    var dateString: String
    
    private enum CodingKeys: CodingKey { // Might also need : String?
        case games
        case players
        case opponentName
        case firstView
        case numOfPlayers
        case dateString
    }
    
    init() { // TODO: Make a proper initializer with arguments
        dateCreated = NSDate.init()
        opponentName = ""
        dateEdited = NSDate.init()
        datePlayed = NSDate.init()
        dateString = ""
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
    
    func archive(fileName: String) {
        dateString = subs(str: dateCreated.description, end:10)
        dateString = dateString + "," + subs(str: dateEdited.description, end:10)
        dateString = dateString + "," + subs(str: dateEdited.description, end:10)
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                print("Game Data successfully saved to file.")
            } else {
                print("Failed to save data...")
            }
        } catch {
            print("Failed to save data...")
        }
    }
    
    func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(
            withFile: archiveURL.path) as? Data {
            do {
                let recoveredData = try PropertyListDecoder().decode(MatchView.self, from: recoveredDataCoded)
                print("Game Data successfully recovered from file.")
                //positions = recoveredData.positions
                games = recoveredData.games
                players = recoveredData.players
                opponentName = recoveredData.opponentName
                firstView = recoveredData.firstView
                numOfPlayers = recoveredData.numOfPlayers
                dateString = recoveredData.dateString
                let dates = dateString.components(separatedBy: ",")
                let dater = DateFormatter()
                dater.dateFormat = "yyyy-MM-dd"
                dateCreated = dater.date(from: dates[0])! as NSDate
                dateEdited = dater.date(from: dates[1])! as NSDate
                datePlayed = dater.date(from: dates[2])! as NSDate
            } catch {
                print("Failed to recover data")
            }
        } else {
            print("Failed to recover data")
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        games = try container.decode([GameView].self, forKey: .games)
        players = try container.decode([Player].self, forKey: .players)
        opponentName = try container.decode(String.self, forKey: .opponentName)
        firstView = try container.decode(Bool.self, forKey: .firstView)
        numOfPlayers = try container.decode(Int.self, forKey: .numOfPlayers)
        dateString = try container.decode(String.self, forKey: .dateString)
        
        let dates = dateString.components(separatedBy: ",")
        let dater = DateFormatter()
        dater.dateFormat = "yyyy-MM-dd"
        print (dateString)
        print (dates)
        if (dates.count > 1) {
            dateCreated = dater.date(from: dates[0])! as NSDate
            dateEdited = dater.date(from: dates[1])! as NSDate
            datePlayed = dater.date(from: dates[2])! as NSDate
        } else {
            dateCreated = NSDate.init()
            dateEdited = NSDate.init()
            datePlayed = NSDate.init()
        }

    }
    
}
