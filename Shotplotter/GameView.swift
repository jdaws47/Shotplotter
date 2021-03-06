//
//  GameView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation

class GameView: Codable {
    var rotations = [RotationView]()
    var players = [Player]()
    var activePlayers = [Player]()
	var activeInt = [Int]()
    var gameNum: Int
    var opponentName: String
    var numOfPlayers: Int
    
    init(_gameNum: Int, _players: [Player]) {
        gameNum = _gameNum
        players = _players
        numOfPlayers = -1
        opponentName = ""
        while (rotations.count < 6) { // There should always be 6 rotations in a game
            addRotation()
        }
        let _ = updateActiveEvent.addHandler(target: self, handler: GameView.updateActive)
    }
    
    func addRotation() { // adds a rotation with the proper rotationID and player array references
        rotations.append(RotationView(ID: rotations.count, GameNum: gameNum, _players: players, _activePlayers: activePlayers))
    }
    
    func updateActive() {
		activeInt.removeAll()
		while (activePlayers.count > activeInt.count) {
			let x = activeInt.count
			var i = 0
			for player in players {
				if (player.number == activePlayers[x].number) {
					activeInt.append(i)
				}
				i = i + 1
			}
		}
        rotations.forEach {
            $0.updateActive(newActive: activePlayers)
        }
    }
    
    func updateActive(newActive: [Player]) {
        activePlayers = newActive
        updateActive()
    }
	
	func updatePlayers(newPlayers: [Player]) {
		players = newPlayers
		for rotation in rotations {
			rotation.updatePlayers(newPlayers: players)
		}
		var temp = [Player]()
		for num in activeInt {
			temp.append(players[num])
		}
		updateActive(newActive: temp)
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		rotations = try container.decode([RotationView].self, forKey: .rotations)
		players = try container.decode([Player].self, forKey: .players)
		activePlayers = try container.decode([Player].self, forKey: .activePlayers)
		activeInt = try container.decode([Int].self, forKey: .activeInt)
		gameNum = try container.decode(Int.self, forKey: .gameNum)
		opponentName = try container.decode(String.self, forKey: .opponentName)
		numOfPlayers = try container.decode(Int.self, forKey: .numOfPlayers)
		
		print("Game Data successfully recovered from file.")
	}
    
    func archive(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                print("Rotation Data successfully saved to file.")
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
                let recoveredData = try PropertyListDecoder().decode(GameView.self, from: recoveredDataCoded)
                print("Data successfully recovered from file.")
                //positions = recoveredData.positions
                activePlayers = recoveredData.activePlayers
                players = recoveredData.players
                rotations = recoveredData.rotations
                gameNum = recoveredData.gameNum
                opponentName = recoveredData.opponentName
                numOfPlayers = recoveredData.numOfPlayers
            } catch {
                print("Failed to recover data")
            }
        } else {
            print("Failed to recover data")
        }
    }
}
