//
//  customDataTypes.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import Foundation

#if false
let Orange = UIColor.init(red: 255/255, green: 149/255, blue:   0/255, alpha: 1)
let Blue   = UIColor.init(red:   4/255, green:  51/255, blue: 255/255, alpha: 1)
let Brown  = UIColor.init(red: 157/255, green:  83/255, blue:   0/255, alpha: 1)
let Pink   = UIColor.init(red: 255/255, green:  64/255, blue: 255/255, alpha: 1)
let Red    = UIColor.init(red: 255/255, green:  38/255, blue:   0/255, alpha: 1)
let Green  = UIColor.init(red: 141/255, green: 213/255, blue:   0/255, alpha: 1)
let Cyan   = UIColor.init(red:   0/255, green: 151/255, blue: 255/255, alpha: 1)
let Yellow = UIColor.init(red: 215/255, green: 207/255, blue:   0/255, alpha: 1)
let Purple = UIColor.init(red: 148/255, green:  55/255, blue: 255/255, alpha: 1)
let Russet = UIColor.init(red: 215/255, green:  91/255, blue:   0/255, alpha: 1)
let Maroon = UIColor.init(red: 255/255, green:  57/255, blue: 138/255, alpha: 1)
let Lime   = UIColor.init(red:   0/255, green: 255/255, blue: 105/255, alpha: 1)
let Burnt  = UIColor.init(red: 255/255, green:  91/255, blue:   0/255, alpha: 1)
#else
let Orange = UIColor.init(red: 255/255, green: 149/255, blue:   0/255, alpha: 1).cgColor
let Blue   = UIColor.init(red:   4/255, green:  51/255, blue: 255/255, alpha: 1).cgColor
let Brown  = UIColor.init(red: 157/255, green:  83/255, blue:   0/255, alpha: 1).cgColor
let Pink   = UIColor.init(red: 255/255, green:  64/255, blue: 255/255, alpha: 1).cgColor
let Red    = UIColor.init(red: 255/255, green:  38/255, blue:   0/255, alpha: 1).cgColor
let Green  = UIColor.init(red: 141/255, green: 213/255, blue:   0/255, alpha: 1).cgColor
let Cyan   = UIColor.init(red:   0/255, green: 151/255, blue: 255/255, alpha: 1).cgColor
let Yellow = UIColor.init(red: 215/255, green: 207/255, blue:   0/255, alpha: 1).cgColor
let Purple = UIColor.init(red: 148/255, green:  55/255, blue: 255/255, alpha: 1).cgColor
let Russet = UIColor.init(red: 215/255, green:  91/255, blue:   0/255, alpha: 1).cgColor
let Maroon = UIColor.init(red: 255/255, green:  57/255, blue: 138/255, alpha: 1).cgColor
let Lime   = UIColor.init(red:   0/255, green: 255/255, blue: 105/255, alpha: 1).cgColor
let Burnt  = UIColor.init(red: 255/255, green:  91/255, blue:   0/255, alpha: 1).cgColor
#endif

let playerColors = [Blue, Red, Yellow, Green, Cyan, Maroon, Purple, Orange, Brown, Pink, Russet, Lime, Burnt]

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
struct Line: Codable {
    var startPos: CGPoint
    var endPos: CGPoint
    var tip: Bool = false
    var slide: Bool = false
    var roll: Bool = false
    var A: Bool = false
    var hit: Bool = false
    var color: CGColor
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
        color = UIColor.black.cgColor
        didScore = false
        rotationID = -1
    }
    
    /**
     * Archive this MeetClass object
     * @param: fileName from which to archived this object
     */
    func archive(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                print("Data successfully saved to file.")
            } else {
                print("Failed to save data...")
            }
        } catch {
            print("Failed to save data...")
        }
    }
    
    /**
     * blah
     * @param: blah
     */
    mutating func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(
            withFile: archiveURL.path) as? Data {
            do {
                let recoveredData = try PropertyListDecoder().decode(Line.self, from: recoveredDataCoded)
                print("Data successfully recovered from file.")
                startPos = recoveredData.startPos
                endPos = recoveredData.endPos
                tip = recoveredData.tip
                slide = recoveredData.slide
                roll = recoveredData.roll
                A = recoveredData.A
                hit = recoveredData.hit
                color = recoveredData.color
                didScore = recoveredData.didScore
                rotationID = recoveredData.rotationID
            } catch {
                print("Failed to recover data")
            }
        } else {
            print("Failed to recover data")
        }
    }
    
    init(from decoder: Decoder) throws {
        print("Ho")
        startPos = CGPoint.init(x: 0, y: 0)
        endPos = CGPoint.init(x: 0, y: 0)
        tip = false
        slide = false
        roll = false
        A = false
        hit = false
        color = UIColor.black.cgColor
        didScore = false
        rotationID = -1
    }
    
    init(_startPos: CGPoint, _endPos: CGPoint, _tip: Bool, _slide: Bool, _roll: Bool, _A: Bool, _hit: Bool, _color: CGColor, _didScore: Bool, _rotationID: Int) {
        startPos = _startPos
        endPos = _endPos
        tip = _tip
        slide = _slide
        roll = _roll
        A = _A
        hit = _hit
        color = _color
        didScore = _didScore
        rotationID = _rotationID
    }
    
    func encode(to encoder: Encoder) throws {
        print("Howdy")
    }
    
    func hasType() -> Bool {
        return tip || slide || A || roll || hit
    }
    
    func convert() -> CAShapeLayer {
        let newLayer = CAShapeLayer()
        newLayer.strokeColor = color
        newLayer.lineWidth = 3
        //add in stuff here about types
        let newPath = UIBezierPath()
        newPath.removeAllPoints()
        //newPath.move(to: startPos)
        
        convertPath(layer: newLayer, path: newPath)
        
        //newPath.addLine(to: endPos)
        //newLayer.path = newPath.cgPath
        return newLayer
    }
    
    func convertPath(layer: CAShapeLayer, path: UIBezierPath) {
        let layer = layer
        
        if (tip) {
            let tipPath = path.cgPath.mutableCopy()
            tipPath?.addLines(between: [startPos, endPos])
            layer.path = tipPath
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
                let counter = CGFloat(i)
                let x1 = startX - counter * (xDiff / length)
                let y1 = startY - counter * (yDiff / length)
                let x2 = x1 + sin(counter * period) * amplitude * cos(angle + CGFloat.pi / CGFloat(2))
                let y2 = y1 + sin(counter * period) * amplitude * sin(angle + CGFloat.pi / CGFloat(2))
                
                let firstPoint = CGPoint(x: x3,y: y3)
                let lastPoint = CGPoint(x: x2, y: y2)
                slidePath?.addLines(between: [firstPoint, lastPoint])
                
                layer.path = slidePath
                
                x3 = x2
                y3 = y2
            }
        } else if roll {
            let rollPath = path.cgPath.mutableCopy()
            rollPath?.addLines(between: [startPos, endPos])
            layer.lineDashPattern = [30, 15, 15, 15]
            layer.path = rollPath
        } else if A {
            let aPath = path.cgPath.mutableCopy()
            aPath?.addLines(between: [startPos, endPos])
            layer.lineDashPattern = [7, 3, 7]
            layer.path = aPath
        }
    }
}

//----------------------------- The Player class is used to hold all data that is specific to each player
class Player {
    var shots = [Line]()
    var layer: CAShapeLayer
    var color: CGColor
    var number: Int
    var name: String
    var isActive: Bool
    var layerExists: Bool
    
    init(_number: Int, _color: CGColor, _name: String) {
        layer = CAShapeLayer()
        number = _number
        color = _color
        name = _name
        isActive = false
        layerExists = false
        layer.strokeColor = color
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color
        layer.addSublayer(previewLayer)
    }
    
    init() {
        number = -1
        color = UIColor.black.cgColor
        name = ""
        isActive = false
        layer = CAShapeLayer()
        layerExists = false
        layer.strokeColor = color
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color
        layer.addSublayer(previewLayer)
    }
    
    //stupid delete this
    
    //adds a copy of a line struct
    func addLine(line: Line) {
        shots.append(line)
    }
    
    //adds a line to the array directly from the raw information
    func addLine(start:CGPoint, end: CGPoint, tip:Bool = false, rotation:Int, slide:Bool = false, A:Bool = false, roll:Bool = false, hit:Bool = false, color:CGColor, didScore:Bool = false) {
        var temp = Line(_startPos: start, _endPos: end, _tip: tip, _slide: slide, _roll: roll, _A: A, _hit: hit, _color: color, _didScore: didScore, _rotationID: rotation)
        addLine(line:temp)
    }
    
    @objc public func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        //isActive = value
        print("value changed")
    }
    
    func initializeLayer(_ wantedID:Int) -> CAShapeLayer {
        layer.sublayers?.removeAll()
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color
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

func setColor(_ index: Int) -> CGColor {
    if (index >= 0 && index < playerColors.count) {
        return playerColors[index]
    } else if (index < 0) {
        return playerColors[0]
    } else if (index >= playerColors.count) {
        return playerColors[playerColors.count-1]
    }
    return UIColor.black.cgColor
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
