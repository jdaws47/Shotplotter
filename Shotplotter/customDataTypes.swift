//
//  customDataTypes.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

enum LineType: Int {
    case Base = -1
}

struct Pos { //Just a utility structure to hold position
    var x: Int
    var y: Int
}

struct Line {
    var StartPos: Pos
    var EndPos: Pos
    var Tip: Bool = false
    var Slide: Bool = false
    var A: Bool = false
    var Roll: Bool = false
    var Hit: Bool = false
    var Color: UIColor
    var DidScore: Bool = false
    var rotationID: Int
}

struct Player {
    var Shots = [AnyHashable:Line]()
    var Color: UIColor
    var Number: Int
}
