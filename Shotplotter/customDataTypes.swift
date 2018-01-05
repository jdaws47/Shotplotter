//
//  customDataTypes.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import Foundation

enum SortingMode: Int {
    case alphaOpponent = 0
    case dateEdit,dateCreated,datePlayed
}

struct Pos { //Just a utility structure to hold position
    var x: Int
    var y: Int
}

struct Line {
    var startPos: Pos
    var endPos: Pos
    var tip: Bool = false
    var slide: Bool = false
    var A: Bool = false
    var roll: Bool = false
    var hit: Bool = false
    var color: UIColor
    var didScore: Bool = false
    var rotationID: Int
}

class Player {
    var shots = [AnyHashable:Line]()
    var color: UIColor
    var number: Int
    init(_number: Int, _color: UIColor) {
        number = _number
        color = _color
    }
}

class PlayerSpot : UIButton {
    
}

let playerColors = [UIColor.blue,UIColor.red,UIColor.yellow]
