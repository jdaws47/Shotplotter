//
//  RotationView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

class RotationView {
    var positions = [PlayerSpot]()
    var activePlayers = [Player]()
    var players = [Player]()
    var rotationID: Int
    var viewMode: Int //0 - Standard, all lines. 1 - Scoring only. 2 = ???. 3 = ???
    var hasSelected: Bool                                //^ Idea: Weighted noise field based on where the lines end
    var selected: PlayerSpot?
    var nextDraws: Bool
    var tipSelect, slideSelect, aSelect, rollSelect: Bool
    
    
    init(ID: Int, GameNum: Int, _players: [Player], _activePlayers: [Player]) { //Make a proper initializer with arguments
        rotationID = GameNum*10+ID
        viewMode = 0
        hasSelected = false
        selected = nil
        nextDraws = false
        tipSelect = false; slideSelect = false; aSelect = false; rollSelect = false
        activePlayers = _activePlayers
        players = _players
    }
}
