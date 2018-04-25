//
//  RotationView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RotationView {
    var positions = [PlayerSpot]()
    var activePlayers = [Player]()
    var players = [Player]()
    var rotationID: Int
    var viewMode: Int //0 - Standard, all lines. 1 - Scoring only. 2 = ???. 3 = ???
    var hasSelected: Bool                       //^ Idea: Weighted noise field based on where the lines end and score
    var selected: Int
    var nextDraws: Bool
    var protoLine: Line
    
    
    init(ID: Int, GameNum: Int, _players: [Player], _activePlayers: [Player]) {
        rotationID = GameNum*10+ID
        viewMode = 0
        hasSelected = false
        selected = -1
        nextDraws = false
        activePlayers = _activePlayers
        protoLine = Line(_startPos: CGPoint.init(x:0,y:0), _endPos: CGPoint.init(x:0,y:0), _tip: false, _slide: false, _roll: false, _A: false, _hit: false, _color: UIColor.black.cgColor, _didScore: false, _rotationID: -1)
        players = _players
    }
    
    func updateActive(newActive: [Player]) {
        activePlayers = newActive
        if (activePlayers.count >= 6) {
            for i in 0 ..< newActive.count {
                print (activePlayers.count)
                print ((i+(rotationID%10))%6)
                activePlayers[(i+(rotationID%10))%6] = newActive[i]
            }
        }
    }
    
    func checkDraw() -> Bool {
        nextDraws = protoLine.hasType() && (selected > -1)
        return nextDraws
    }
    
    // TODO: Get this working
    /*func addLine(playerNum:Int, start:Pos, end:Pos, tip:Bool = false, rotation:Int, slide:Bool = false, A:Bool = false, roll:Bool = false, hit:Bool = false, didScore:Bool = false) {
        activePlayers[?].addLine(startPos: start, endPos: end, tip: tip, slide: slide, A: A, roll: roll, hit: hit, didScore: didScore, rotationID: rotation)
        addLine(line:temp)
    }*/
}
