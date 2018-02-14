//
//  customDataTypes.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import Foundation

//----------------------------- Enumeration used to keep track of which Matches we should be displaying on Mainview.
enum SortingMode: Int {
    case alphaOpponent = 0
    case dateEdit,dateCreated,datePlayed
}

//----------------------------- The Line structure. This is used to keep track of all information for each line
struct Line {
    var startPos: CGPoint
    var endPos: CGPoint
    var tip: Bool = false
    var slide: Bool = false
    var A: Bool = false
    var roll: Bool = false
    var hit: Bool = false
    var color: UIColor
    var didScore: Bool = false
    var rotationID: Int
    
    mutating func reset() {
        startPos = CGPoint.init(x: 0, y: 0)
        endPos = CGPoint.init(x: 0, y: 0)
        tip = false
        slide = false
        A = false
        roll = false
        hit = false
        color = UIColor.black
        didScore = false
        rotationID = 0
    }
}

//----------------------------- The Player class is used to hold all data that is specific to each player
class Player {
    var shots = [Line]()
    var color: UIColor
    var number: Int
    var name: String
    var isActive: Bool
    
    init(_number: Int, _color: UIColor, _name: String) {
        number = _number
        color = _color
        name = _name
        isActive = false
    }
    
    init() {
        number = -1
        color = UIColor.black
        name = ""
        isActive = false
    }
    
    //adds a copy of a line struct
    func addLine(line: Line) {
        shots.append(line)
    }
    
    //adds a line to the array directly from the raw information
    func addLine(start:CGPoint, end:CGPoint, tip:Bool = false, rotation:Int, slide:Bool = false, A:Bool = false, roll:Bool = false, hit:Bool = false, didScore:Bool = false) {
        var temp = Line(startPos: start, endPos: end, tip: tip, slide: slide, A: A, roll: roll, hit: hit, color: color, didScore: didScore, rotationID: rotation)
        addLine(line:temp)
    }
    
    @objc public func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        //isActive = value
        print("value changed")
    }
    
    func getColor() -> UIColor {
        return color
    }
}

//----------------------------- Represents each player in the GUI
class PlayerSpot : UIButton {
    var player: Player?
    var playerIsSelected: Bool
    
    required init?(coder aDecoder: NSCoder) {
        self.playerIsSelected = false
        super.init(coder: aDecoder)!
    }
    
    func rotate() {
        
    }
    
       
    func brutallyInjureOpponentPlayer() {
    
    }
}

class PlayerTextField: UITextField {
    var index: Int
    var isName: Bool
    required init?(coder aDecoder: NSCoder) {
        index = -1
        isName = true
        super.init(coder: aDecoder)
    }
}

let playerColors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.magenta, UIColor.purple, UIColor.orange, UIColor.brown, UIColor.init(red: 192/255, green: 249/255, blue: 2/255, alpha: 0.5), UIColor.init(red: 249/255, green: 192/255, blue: 11/255, alpha: 0.5), UIColor.init(red:125/255,green:0,blue:255/255,alpha:0)]

func setColor(_ index: Int) -> UIColor {
    if (index >= 0 && index < playerColors.count) {
        return playerColors[index]
    } else if (index < 0) {
        return playerColors[0]
    } else if (index >= playerColors.count) {
        return playerColors[playerColors.count-1]
    }
    return UIColor.black
}

protocol ActiveSwitchDelegate: class {
    func switched(sender: ActiveSwitch)
}

class ActiveSwitch: UISwitch {
    var index: Int
    weak var delegate:ActiveSwitchDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        index = -1
        super.init(coder: aDecoder)
    }
    
    func switched(_ tapGesture: UITapGestureRecognizer) {
        delegate?.switched(sender: self)
    }
}

//----------------------------- Holds references to images
let AOff = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/AOff.png"
let AOn = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/AOn.png"

let RollOff = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/RollOff.png"
let RollOn = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/RollOn.png"

let SlideOff = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/SlideOff.png"
let SlideOn = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/SlideOn.png"

let TipOff = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/TipOff.png"
let TipOn = "/Users/Zelle/Documents/Projects/School/Programming/Shotplotter/Shotplotter/ShotTypeIcons/TipOn.png"
