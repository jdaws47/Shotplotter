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
    @IBOutlet weak var goToGame: UIButton!
    @IBOutlet weak var rotationTitle: UINavigationItem!
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
        rotationTitle.title = "Rotation \((data?.rotationID)! % 10 + 1)"
        aButton.setBackgroundImage(UIImage(named: AOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        rollButton.setBackgroundImage(UIImage(named: RollOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        slideButton.setBackgroundImage(UIImage(named: SlideOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        tipButton.setBackgroundImage(UIImage(named: TipOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = RotationView()
        activePlayer = Player()
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TipTypeSelect(_ sender: Any) {
        data?.protoLine.tip = !(data?.protoLine.tip)!
        print("Tip shot type toggled: " + String(describing: data?.protoLine.tip))
        if (data?.protoLine.tip)! {
            tipButton.setBackgroundImage(UIImage(named: TipOn)?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            tipButton.setBackgroundImage(UIImage(named: TipOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func SlideTypeSelect(_ sender: Any) {
        data?.protoLine.slide = !(data?.protoLine.slide)!
        print("Slide shot type toggled: " + String(describing: data?.protoLine.slide))
        if (data?.protoLine.slide)! {
            slideButton.setBackgroundImage(UIImage(named: SlideOn)?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            slideButton.setBackgroundImage(UIImage(named: SlideOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func RollTypeSelect(_ sender: Any) {
        data?.protoLine.roll = !(data?.protoLine.roll)!
        print("Roll shot type toggled: " + String(describing: data?.protoLine.roll))
        if (data?.protoLine.roll)! {
            rollButton.setBackgroundImage(UIImage(named: RollOn)?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            rollButton.setBackgroundImage(UIImage(named: RollOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func ATypeSelect(_ sender: Any) {
        data?.protoLine.A = !(data?.protoLine.A)!
        print("A shot type toggled: " + String(describing: data?.protoLine.A))
        if (data?.protoLine.A)! {
            aButton.setBackgroundImage(UIImage(named: AOn)?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            aButton.setBackgroundImage(UIImage(named: AOff)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func player1(_ sender: Any) {
        print("Player1 button pushed")
        activePlayer = (data?.activePlayers[0])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player2(_ sender: Any) {
        activePlayer = (data?.activePlayers[1])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player3(_ sender: Any) {
        activePlayer = (data?.activePlayers[2])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player4(_ sender: Any) {
        activePlayer = (data?.activePlayers[3])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player5(_ sender: Any) {
        activePlayer = (data?.activePlayers[4])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player6(_ sender: Any) {
        activePlayer = (data?.activePlayers[5])!
        drawingBoard.changeColor(player: activePlayer)
    }
}
