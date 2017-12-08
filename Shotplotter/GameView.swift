//
//  GameView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

class GameView {
    var rotations = [AnyHashable: RotationView]()
    var activePlayers = [AnyHashable: Player]()
    var gameNum: Int
    
    init() { //Make a proper initializer with arguments
        gameNum = -1
    }
}
