//
//  customDataTypes.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import Foundation

let playerColors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.magenta, UIColor.purple, UIColor.orange, UIColor.brown, UIColor.init(red: 192/255, green: 249/255, blue: 2/255, alpha: 0.5), UIColor.init(red: 249/255, green: 192/255, blue: 11/255, alpha: 0.5), UIColor.init(red:125/255,green:0,blue:255/255,alpha:0)]

let updateShotButtonsEvent = Event<Int>()
let updateActiveEvent = Event<[Player]>()

//----------------------------- Holds references to images
let AOff = #imageLiteral(resourceName: "AOff.png")
let AOn = #imageLiteral(resourceName: "AOn.png")

let RollOff = #imageLiteral(resourceName: "RollOff.png")
let RollOn = #imageLiteral(resourceName: "RollOn.png")

let SlideOff = #imageLiteral(resourceName: "SlideOff.png")
let SlideOn = #imageLiteral(resourceName: "SlideOn.png")

let TipOff = #imageLiteral(resourceName: "TipOff.png")
let TipOn = #imageLiteral(resourceName: "TipOn.png")


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
    var roll: Bool = false
    var A: Bool = false
    var hit: Bool = false
    var color: UIColor
    var didScore: Bool = false
    var rotationID: Int
    
    mutating func reset() {
        startPos = CGPoint.init(x: 0, y: 0)
        endPos = CGPoint.init(x: 0, y: 0)
        tip = false
        slide = false
        roll = false
        A = false
        hit = false
        color = UIColor.black
        didScore = false
        rotationID = -1
    }
    
    func hasType() -> Bool {
        return tip || slide || A || roll || hit
    }
    
    func convert() -> CAShapeLayer {
        let newLayer = CAShapeLayer()
        newLayer.strokeColor = color.cgColor
        newLayer.lineWidth = 3
        //add in stuff here about types
        let newPath = UIBezierPath()
        newPath.removeAllPoints()
        //newPath.move(to: startPos)
        
        if (tip) {
            newLayer.path =  newPath.cgPath //THIS IS THE IMPORTANT ONE
        } else if (slide) {
            let slidePath = UIBezierPath().cgPath.mutableCopy()
            let startX = CGFloat(startPos.x)
            let startY = CGFloat(startPos.y)
            let endX = CGFloat(endPos.x)
            let endY = CGFloat(endPos.y)
            
            let amplitude = CGFloat(5)
            var period = CGFloat(5)
            // Increase this number to increase performance
            let segmentLength = 5
            
            let xDiff = startX - endX
            let yDiff = startY - endY
            
            var angle = atan2(yDiff, xDiff)
            if angle < 0 {
                angle += 2.0 * CGFloat.pi
            }
            
            let length = sqrt(xDiff * xDiff + yDiff * yDiff)
            
            var occilations = CGFloat((Int)(length / (2 * CGFloat.pi)))
            occilations = CGFloat(Int(occilations / period))
            period = (CGFloat(occilations) * ((2 * CGFloat.pi) / length))
            
            var x3 = CGFloat(startX)
            var y3 = CGFloat(startY)
            for i in stride(from: 0, to: Int(length), by: segmentLength) {
                var counter = CGFloat(i)
                var x1 = startX - counter * (xDiff / length)
                var y1 = startY - counter * (yDiff / length)
                var x2 = x1 + sin(counter * period) * amplitude * cos(angle + CGFloat.pi / CGFloat(2))
                var y2 = y1 + sin(counter * period) * amplitude * sin(angle + CGFloat.pi / CGFloat(2))
                
                var firstPoint = CGPoint(x: x3,y: y3)
                var lastPoint = CGPoint(x: x2, y: y2)
                slidePath?.addLines(between: [firstPoint, lastPoint])
                
                newLayer.path = slidePath
                
                x3 = x2
                y3 = y2
            }
        } else if roll {
            let rollPath = newPath.cgPath.mutableCopy()
            rollPath?.addLines(between: [startPos, endPos])
            newLayer.lineDashPattern = [30, 15, 15, 15]
            newLayer.path = rollPath
        } else if A {
            let aPath = newPath.cgPath.mutableCopy()
            aPath?.addLines(between: [startPos, endPos])
            newLayer.lineDashPattern = [7, 3, 7]
            newLayer.path = aPath
        }
        //newPath.addLine(to: endPos)
        //newLayer.path = newPath.cgPath
        return newLayer
    }
}

//----------------------------- The Player class is used to hold all data that is specific to each player
class Player {
    var shots = [Line]()
    var layer: CAShapeLayer
    var color: UIColor
    var number: Int
    var name: String
    var isActive: Bool
    var layerExists: Bool
    
    init(_number: Int, _color: UIColor, _name: String) {
        layer = CAShapeLayer()
        number = _number
        color = _color
        name = _name
        isActive = false
        layerExists = false
        layer.strokeColor = color.cgColor
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color.cgColor
        layer.addSublayer(previewLayer)
    }
    
    init() {
        number = -1
        color = UIColor.black
        name = ""
        isActive = false
        layer = CAShapeLayer()
        layerExists = false
        layer.strokeColor = color.cgColor
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color.cgColor
        layer.addSublayer(previewLayer)
    }
    
    //stupid delete this
    
    //adds a copy of a line struct
    func addLine(line: Line) {
        shots.append(line)
    }
    
    //adds a line to the array directly from the raw information
    func addLine(start:CGPoint, end:CGPoint, tip:Bool = false, rotation:Int, slide:Bool = false, A:Bool = false, roll:Bool = false, hit:Bool = false, didScore:Bool = false) {
        var temp = Line(startPos: start, endPos: end, tip: tip, slide: slide, roll: roll, A: A, hit: hit, color: color, didScore: didScore, rotationID: rotation)
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
    
    func initializeLayer(_ wantedID:Int) -> CAShapeLayer {
        layer.sublayers?.removeAll()
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color.cgColor
        layer.addSublayer(previewLayer)
        for i in 0 ..< shots.count {
            if shots[i].rotationID == wantedID {
                layer.addSublayer(shots[i].convert() as CALayer)
            }
        }
        return layer
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
    
       
    func brutallyInjureOpponentPlayer() { //Depricated, use "geld()" instead
    
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
    
    @objc func switched(_ tapGesture: UITapGestureRecognizer) {
        delegate?.switched(sender: self)
    }
}

//----------------------------- Event Implementation
private class EventHandlerWrapper<T: AnyObject, U>
: Invocable, Disposable {
    weak var target: T?
    let handler: (T) -> (U) -> ()
    let event: Event<U>
    
    init(target: T?, handler: @escaping (T) -> (U) -> (), event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event;
    }
    
    func invoke(data: Any) -> () {
        if let t = target {
            handler(t)(data as! U)
        }
    }
    
    func dispose() {
        event.eventHandlers = event.eventHandlers.filter { $0 !== self }
    }
}
protocol RotationDelegate: class {
    func passScreenCap(screenshot: UIImage, index: Int)
    func nextRotation(ID: Int, _ sender: RotationViewController)
    func previousRotation(ID: Int, _ sender: RotationViewController)
}

public protocol Disposable {
    func dispose()
}


public class Event<T> {
    
    public typealias EventHandler = (T) -> ()
    
    var eventHandlers = [Invocable]()
    
    public func raise(data: T) {
        for handler in self.eventHandlers {
            handler.invoke(data: data)
        }
    }
    
    public func addHandler<U: AnyObject>(target: U, handler: @escaping (U) -> EventHandler) -> Disposable {
        let wrapper = EventHandlerWrapper(target: target, handler: handler, event: self)
        eventHandlers.append(wrapper)
        return wrapper
    }
}

protocol Invocable: class {
    func invoke(data: Any)
}
