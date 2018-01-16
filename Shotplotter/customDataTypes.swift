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
    var shots = [Line]()
    var color: UIColor
    var number: Int
    init(_number: Int, _color: UIColor) {
        number = _number
        color = _color
    }
    
    func addLine(line: Line) {
        shots.append(line)
    }
    
    func addLine(start:Pos, end:Pos, tip:Bool = false, rotation:Int, slide:Bool = false, A:Bool = false, roll:Bool = false, hit:Bool = false, didScore:Bool = false) {
        var temp = Line(startPos: start, endPos: end, tip: tip, slide: slide, A: A, roll: roll, hit: hit, color: color, didScore: didScore, rotationID: rotation)
        addLine(line:temp)
    }
}

class PlayerSpot : UIButton {
    
}

let playerColors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.magenta, UIColor.purple, UIColor.orange, UIColor.brown, UIColor.init(red: 192, green: 249, blue: 2, alpha: 0), UIColor.init(red: 249, green: 192, blue: 11, alpha: 0)]
