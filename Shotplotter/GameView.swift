//
//  GameView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

class GameView {
    var rotations = [RotationView]()
    var players = [Player]()
    var activePlayers = [Player]()
    var gameNum: Int
    var opponentName: String
    
    init(_gameNum: Int, _players: [Player]) {
        gameNum = _gameNum
        players = _players
        opponentName = ""
        while (rotations.count < 6) { // There should always be 6 rotations in a game
            addRotation()
        }
    }
    
    func addRotation() { // adds a rotation with the proper rotationID and player array references
        rotations.append(RotationView(ID: rotations.count, GameNum: gameNum, _players: players, _activePlayers: activePlayers))
    }
}
