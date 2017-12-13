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
    
    init(_gameNum: Int, _players: [Player]) { //Make a proper initializer with arguments
        gameNum = _gameNum
        players = _players
    }
    
    func addRotation() {
        rotations.append(RotationView(ID: rotations.count, GameNum: gameNum, _players: players, _activePlayers: activePlayers))
    }
}
