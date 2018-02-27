//
//  RotationViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {
    
    @IBOutlet weak var drawingBoard: ArrowView!
    var data: RotationView?
    var screenshot: UIImage?
    @IBOutlet weak var goToGame: UIButton!
    @IBOutlet weak var rotationTitle: UINavigationItem!
    weak var delegate: RotationDelegate?
    var activePlayer: Player
    
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var slideButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var aButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drawingBoard.data = self.data
        //tipShot.addTarget(customDataTypes., action: #selector(ActiveSwitch.switched(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawingBoard.data = data
        print("RotationView: " + String(describing: data?.activePlayers.count))
        rotationTitle.title = "Rotation \((data?.rotationID)! % 10 + 1)"
        checkButtons(empty: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = RotationView()
        activePlayer = Player()
        super.init(coder: aDecoder)
        updateShotButtonsEvent.addHandler(target: self, handler: RotationViewController.checkButtons)
    }
    
    @IBAction func goBack(_ sender: Any) {
        screenshot = drawingBoard.pb_takeSnapshot()
        delegate?.passScreenCap(screenshot: screenshot!, index: ((data?.rotationID)! % 10))
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TipTypeSelect(_ sender: Any) {
        data?.protoLine.tip = !(data?.protoLine.tip)!
        //print("Tip shot type toggled: " + String(describing: data?.protoLine.tip))
        if (data?.protoLine.tip)! {
            tipButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/TipOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            tipButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/TipOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func SlideTypeSelect(_ sender: Any) {
        data?.protoLine.slide = !(data?.protoLine.slide)!
        //print("Slide shot type toggled: " + String(describing: data?.protoLine.slide))
        if (data?.protoLine.slide)! {
            slideButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/SlideOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            slideButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/SlideOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func RollTypeSelect(_ sender: Any) {
        data?.protoLine.roll = !(data?.protoLine.roll)!
        //print("Roll shot type toggled: " + String(describing: data?.protoLine.roll))
        if (data?.protoLine.roll)! {
            rollButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/RollOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            rollButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/RollOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func ATypeSelect(_ sender: Any) {
        data?.protoLine.A = !(data?.protoLine.A)!
        //print("A shot type toggled: " + String(describing: data?.protoLine.A))
        if (data?.protoLine.A)! {
            aButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/AOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            aButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/AOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func player1(_ sender: Any) {
        print("Player1 button pushed")
        data?.selected = 0
        activePlayer = (data?.activePlayers[0])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player2(_ sender: Any) {
        data?.selected = 1
        activePlayer = (data?.activePlayers[1])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player3(_ sender: Any) {
        data?.selected = 2
        activePlayer = (data?.activePlayers[2])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player4(_ sender: Any) {
        data?.selected = 3
        activePlayer = (data?.activePlayers[3])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player5(_ sender: Any) {
        data?.selected = 4
        activePlayer = (data?.activePlayers[4])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player6(_ sender: Any) {
        data?.selected = 5
        activePlayer = (data?.activePlayers[5])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    func checkButtons (empty: Int) {
        if (data?.protoLine.A)! {
            aButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/AOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            aButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/AOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.roll)! {
            rollButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/RollOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            rollButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/RollOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.slide)! {
            slideButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/SlideOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            slideButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/SlideOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.tip)! {
            tipButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/TipOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            tipButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/TipOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
}
