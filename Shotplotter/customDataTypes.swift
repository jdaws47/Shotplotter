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
let Red         = UIColor.init(red: 255/255, green:  0/255, blue:   0/255, alpha: 1).cgColor
let Orange      = UIColor.init(red: 255/255, green:  130/255, blue: 0/255, alpha: 1).cgColor
let YellowOrange = UIColor.init(red: 253/255, green:  196/255, blue:   46/255, alpha: 1).cgColor
let LightGreen  = UIColor.init(red: 15/255, green:  85/255, blue: 15/255, alpha: 1).cgColor
let Green       = UIColor.init(red: 0/255, green: 220/255, blue:   0/255, alpha: 1).cgColor
let Teal        = UIColor.init(red: 0/255, green: 170/255, blue:   170/255, alpha: 1).cgColor
let LightBlue   = UIColor.init(red: 0/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
let Blue        = UIColor.init(red: 0/255, green:  0/255, blue: 255/255, alpha: 1).cgColor
let Purple      = UIColor.init(red: 98/255, green:  20/255, blue:   162/255, alpha: 1).cgColor
let RedPurple   = UIColor.init(red: 202/255, green: 26/255, blue: 173/255, alpha: 1).cgColor
let Pink        = UIColor.init(red: 252/255, green: 22/255, blue:   140/255, alpha: 1).cgColor
let Maroon      = UIColor.init(red: 180/255, green: 50/255, blue:   50/255, alpha: 1).cgColor
let Violet      = UIColor.init(red: 184/255, green:  39/255, blue: 251/255, alpha: 1).cgColor
#endif

let playerColors = [Red, Orange, YellowOrange, LightGreen, Green, Teal, LightBlue, Blue, Purple, RedPurple, Pink, Maroon, Violet]

let updateShotButtonsEvent = Event<Int>()
let updateActiveEvent = Event<[Player]>()

//----------------------------------------------------------
//----------------------------------------------------------
//Holds references to images
let AOff = #imageLiteral(resourceName: "AOff.png")
let AOn = #imageLiteral(resourceName: "AOn.png")

let RollOff = #imageLiteral(resourceName: "RollOff.png")
let RollOn = #imageLiteral(resourceName: "RollOn.png")

let SlideOff = #imageLiteral(resourceName: "SlideOff.png")
let SlideOn = #imageLiteral(resourceName: "SlideOn.png")

let TipOff = #imageLiteral(resourceName: "TipOff.png")
let TipOn = #imageLiteral(resourceName: "TipOn.png")

//----------------------------------------------------------
//----------------------------------------------------------
//Enumeration used to keep track of which Matches we should be displaying on Mainview.
enum SortingMode: Int, Codable {
    case alphaOpponent = 0
    case dateEdit,dateCreated,datePlayed
}

//----------------------------------------------------------
//----------------------------------------------------------
//Re-implementation of the Substring function
func subs(str: String, end:Int) -> String {
    return String(str[str.startIndex..<str.index(str.startIndex, offsetBy: end)])
}

//----------------------------------------------------------
//----------------------------------------------------------
//The Line structure. This is used to keep track of all information for each line
struct Line: Codable {
    var startPos: CGPoint
    var endPos: CGPoint
    var tip: Bool = false
    var slide: Bool = false
    var roll: Bool = false
    var A: Bool = false
    var hit: Bool = false
    var color: CGColor
    var colorSplit = [Float]()
    var didScore: Bool = false
    var rotationID: Int
    
    private enum CodingKeys: CodingKey { // Might also need : String?
        case startPos
        case endPos
        case tip
        case slide
        case roll
        case A
        case hit
        case didScore
        case rotationID
        case colorSplit
    }
    
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
    
    func hasType() -> Bool {
        return tip || slide || A || roll || hit
    }
    
    func convert() -> CAShapeLayer {
        let newLayer = CAShapeLayer()
        newLayer.strokeColor = color
        newLayer.lineWidth = 3
       
        let newPath = UIBezierPath()
        newPath.removeAllPoints()
        
        convertPath(layer: newLayer, path: newPath)
        
        return newLayer
    }
    
    func convertPath(layer: CAShapeLayer, path: UIBezierPath) {
        let layer = layer
        var path = path.cgPath.mutableCopy()
        
        if endPos == CGPoint.zero {
            return
        }
        
        if (tip) {
            //let tipPath = path.cgPath.mutableCopy()
            path?.addLines(between: [startPos, endPos])
			layer.lineWidth = 6
            
		} else if roll {
			//let rollPath = path.cgPath.mutableCopy()
			path?.addLines(between: [startPos, endPos])
			layer.lineDashPattern = [30, 15, 15, 15]
	
		} else if A {
			//let aPath = path.cgPath.mutableCopy()
			path?.addLines(between: [startPos, endPos])
			layer.lineDashPattern = [7, 3, 7]
	
		}
		
		if (slide) {
			path = UIBezierPath().cgPath.mutableCopy()
			let startX = CGFloat(startPos.x)
            let startY = CGFloat(startPos.y)
            let endX = CGFloat(endPos.x)
            let endY = CGFloat(endPos.y)
            
            let amplitude = CGFloat(5)
            var period = CGFloat(5)
            // Increase this number to increase performance
            let segmentLength = 1
            
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
			
			var oscillatorLength = 0
			var oscillating = 0
			var pattern = [Int]()
			var carryover = 0
			if(roll) {
				pattern = [15, 3]
				//layer.lineCap = ""
				oscillatorLength = pattern.count
			} else if(A) {
				pattern = [2, 4]
				oscillatorLength = pattern.count
			} else {
				pattern = [5]
				oscillatorLength = pattern.count
			}
			
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
				
				var shown: Bool
				if(oscillating % 2 == 1 && carryover <= 0) {
					shown = false
					oscillating += 1
					if(oscillating == oscillatorLength) {
						oscillating = 0
					}
					carryover = pattern[oscillating]
				} else if (oscillating % 2 == 0 && carryover <= 0){
					shown = true
					oscillating += 1
					if(oscillating == oscillatorLength) {
						oscillating = 0
					}
					carryover = pattern[oscillating]
				} else {
					carryover -= segmentLength
					shown = (oscillating % 2 == 0)
				}
				
				if(shown) {
					path?.addLines(between: [firstPoint, lastPoint])
				}
                
                //layer.path = slidePath
                
                x3 = x2
                y3 = y2
            }
		}
		
        if didScore {
            let hitmarkerLayer = CAShapeLayer()
            let hitmarkerPath = UIBezierPath().cgPath.mutableCopy()
            
            hitmarkerLayer.strokeColor = color
            hitmarkerLayer.fillColor = nil
            hitmarkerLayer.lineWidth = 3
            
            let radius1 = 20.0
            let radius2 = 10.0
            
            let origin1 = CGPoint(x: Double(endPos.x) - (radius1 / 2), y: Double(endPos.y) - (radius1 / 2))
            let origin2 = CGPoint(x: Double(endPos.x) - (radius2 / 2), y: Double(endPos.y) - (radius2 / 2))
            let rect1 = CGRect(origin: origin1, size: CGSize(width: radius1, height: radius1))
            let rect2 = CGRect(origin: origin2, size: CGSize(width: radius2, height: radius2))
            
            hitmarkerPath?.addEllipse(in: rect1)
            hitmarkerPath?.addEllipse(in: rect2)
            hitmarkerLayer.path = hitmarkerPath
            layer.addSublayer(hitmarkerLayer)
        } else {
            let arrowLayer = CAShapeLayer()
            let arrowPath = UIBezierPath().cgPath.mutableCopy()
            
            arrowLayer.strokeColor = color
            arrowLayer.fillColor = nil
            arrowLayer.lineWidth = 3
            
            
            let startX = CGFloat(startPos.x)
            let startY = CGFloat(startPos.y)
            let endX = CGFloat(endPos.x)
            let endY = CGFloat(endPos.y)
            
            let rLen = CGFloat(10)
            
            let xDiff = startX - endX
            let yDiff = startY - endY
            
            var angle = atan2(yDiff, xDiff)
            if angle < 0 {
                angle += 2.0 * CGFloat.pi
            }
            
            let x1 = endX
            let y1 = endY
            var x2 = CGFloat(endX + (rLen * cos(angle)))
            var y2 = CGFloat(endY + (rLen * sin(angle)))
            
            print("x1: \(x1) + y1: \(y1)")
            print("x2: \(x2) + y2: \(y2)")
            
            x2 = x2 + CGFloat(2 * rLen * cos(angle + CGFloat.pi / CGFloat(4.0)))
            y2 = y2 + CGFloat(2 * rLen * sin(angle + CGFloat.pi / CGFloat(4.0)))
            
            let firstPoint = CGPoint(x: x1,y: y1)
            var lastPoint = CGPoint(x: x2, y: y2)
            arrowPath?.addLines(between: [firstPoint, lastPoint])
            
            x2 = CGFloat(endX + (rLen * cos(angle)))
            y2 = CGFloat(endY + (rLen * sin(angle)))
            x2 = x2 + CGFloat(2 * rLen * cos(angle - CGFloat.pi / CGFloat(4.0)))
            y2 = y2 + CGFloat(2 * rLen * sin(angle - CGFloat.pi / CGFloat(4.0)))
            
            lastPoint = CGPoint(x: x2, y: y2)
            arrowPath?.addLines(between: [firstPoint, lastPoint])
            
            arrowLayer.path = arrowPath
            layer.addSublayer(arrowLayer)
            
            //var meme = CGRect(origin: CGPoint(x: 150, y: 150), size: CGSize(width: 10, height: 10))
            //path?.addEllipse(in: meme)
        }
        
        layer.path = path
        
    }
    
    mutating func archive(fileName: String) {
        colorSplit = [0,0,0]
        colorSplit[0] = Float(color.components![0])
        colorSplit[1] = Float(color.components![1])
        colorSplit[2] = Float(color.components![2])
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
        let container = try decoder.container(keyedBy: CodingKeys.self)
        startPos = try container.decode(CGPoint.self, forKey: .startPos)
        endPos = try container.decode(CGPoint.self, forKey: .endPos)
        tip = try container.decode(Bool.self, forKey: .tip)
        slide = try container.decode(Bool.self, forKey: .slide)
        roll = try container.decode(Bool.self, forKey: .roll)
        A = try container.decode(Bool.self, forKey: .A)
        hit = try container.decode(Bool.self, forKey: .hit)
        colorSplit = try container.decode([Float].self, forKey: .colorSplit)
        didScore = try container.decode(Bool.self, forKey: .didScore)
        rotationID = try container.decode(Int.self, forKey: .rotationID)
        if (colorSplit.count == 3) {
            color = UIColor.init(red: CGFloat(colorSplit[0]), green: CGFloat(colorSplit[1]), blue: CGFloat(colorSplit[2]), alpha: 1).cgColor
        } else {
            color = UIColor.black.cgColor
        }
    }
    
    /*mutating func encode(to encoder: Encoder) throws {
        colorSplit = [0,0,0]
        colorSplit[0] = Float(color.components![0])
        colorSplit[1] = Float(color.components![1])
        colorSplit[2] = Float(color.components![2])
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(startPos, forKey: .startPos)
        try container.encode(endPos, forKey: .endPos)
        try container.encode(tip, forKey: .tip)
        try container.encode(slide, forKey: .slide)
        try container.encode(roll, forKey: .roll)
        try container.encode(A, forKey: .A)
        try container.encode(hit, forKey: .hit)
        try container.encode(colorSplit, forKey: .colorSplit)
        try container.encode(didScore, forKey: .didScore)
        try container.encode(rotationID, forKey: .rotationID)
        print("Line Data successfully saved to file.")
    }*/
}

//----------------------------------------------------------
//----------------------------------------------------------
//The Player class is used to hold all data that is specific to each player
class Player: Codable {
    var shots = [Line]()
    var layer: CAShapeLayer
    var color: CGColor
    //var colorSplit = [Float]()
    var number: Int
    var name: String
    var isActive: Bool
    var layerExists: Bool
    
    private enum CodingKeys: CodingKey { // Might also need : String?
        case shots
        case number
        case name
        case isActive
        //case colorSplit
    }
    
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
    
    //adds a copy of a line struct
    func addLine(line: Line) {
        shots.append(line)
    }
    
    //adds a line to the array directly from the raw information
    func addLine(start:CGPoint, end: CGPoint, tip:Bool = false, rotation:Int, slide:Bool = false, A:Bool = false, roll:Bool = false, hit:Bool = false, color:CGColor, didScore:Bool = false) {
        let temp = Line(_startPos: start, _endPos: end, _tip: tip, _slide: slide, _roll: roll, _A: A, _hit: hit, _color: color, _didScore: didScore, _rotationID: rotation)
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
                let shotLayer = shots[i].convert() //as CALayer
                shotLayer.fillColor = nil
                layer.addSublayer(shotLayer)
            }
        }
        return layer
    }
    
    func archive(fileName: String) {
        //colorSplit = [0,0,0]
        //colorSplit[0] = Float(color.components![0])
        //colorSplit[1] = Float(color.components![1])
        //colorSplit[2] = Float(color.components![2])
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
    
    func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(
            withFile: archiveURL.path) as? Data {
            do {
                let recoveredData = try PropertyListDecoder().decode(Player.self, from: recoveredDataCoded)
                print("Data successfully recovered from file.")
                shots = recoveredData.shots
                layer = recoveredData.layer
                color = recoveredData.color
                number = recoveredData.number
                name = recoveredData.name
                isActive = recoveredData.isActive
                layerExists = recoveredData.layerExists
            } catch {
                print("Failed to recover data")
            }
        } else {
            print("Failed to recover data")
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        layer = CAShapeLayer()
        number = try container.decode(Int.self, forKey: .number)
        //colorSplit = try container.decode([Float].self, forKey: .colorSplit)
        //if (colorSplit.count == 3) {
        //    color = UIColor.init(red: CGFloat(colorSplit[0]), green: CGFloat(colorSplit[1]), blue: CGFloat(colorSplit[2]), alpha: 1).cgColor
        //} else {
        //    color = UIColor.black.cgColor
        //}
        name = try container.decode(String.self, forKey: .name)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        layerExists = false
		color = UIColor.black.cgColor
        layer.strokeColor = color
        let previewLayer = CAShapeLayer()
        previewLayer.strokeColor = color
        layer.addSublayer(previewLayer)
    }
	
	func setColor(_color: UIColor) {
		color = _color.cgColor
		layer.strokeColor = color
		for i in 0...shots.count-1 {
			shots[i].color = color
		}
	}
	
	func setColor(_color: CGColor) {
		color = _color
		layer.strokeColor = color
		if (shots.count > 0) { for i in 0...shots.count {
			shots[i].color = color
			} }
		print ("Setting player color to:")
		print(color)
	}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(shots, forKey: .shots)
        //try container.encode(colorSplit, forKey: .colorSplit)
        try container.encode(name, forKey: .name)
        try container.encode(isActive, forKey: .isActive)
        print("Player Data successfully saved to file.")
    }
}

//----------------------------------------------------------
//----------------------------------------------------------
//Represents each player in the GUI
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

//----------------------------------------------------------
//----------------------------------------------------------
//Event Implementation
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
    func getData(sender: RotationViewController) -> GameView
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

protocol SubstituteDelegate: class {
    func syncActiveArray(newArray: [Player], playerSubbedOut: Player)
    func updatePreviewPositions(_ activePlayers: [Player])
}

class SubButton : UIButton {
    var player: Player?
    var indexOfPlayer: Int?
    var delegate: SubButtonDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    @objc func pressed(_ tapGesture: UITapGestureRecognizer) {
        delegate?.openSubstitution(self)
    }
}

protocol SubButtonDelegate: class {
    func openSubstitution(_ sender: SubButton)
}
