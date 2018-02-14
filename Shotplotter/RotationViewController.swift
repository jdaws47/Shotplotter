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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drawingBoard.data = self.data
        //tipShot.addTarget(customDataTypes., action: #selector(ActiveSwitch.switched(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawingBoard.data = data
        rotationTitle.title = "Rotation \((data?.rotationID)! % 10 + 1)"
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
        data?.protoLine.tip = (data?.protoLine.tip)!
        print("Tip shot type toggled: " + String(describing: data?.protoLine.tip))
    }
    
    @IBAction func SlideTypeSelect(_ sender: Any) {
        data?.protoLine.tip = !(data?.protoLine.tip)!
        print("Tip shot type toggled: " + String(describing: data?.protoLine.tip))
    }
    
    @IBAction func RollTypeSelect(_ sender: Any) {
    }
    
    @IBAction func ATypeSelect(_ sender: Any) {
    }
    
    @IBAction func player1(_ sender: Any) {
        print("Player1 button pushed")
        activePlayer = (data?.players[0])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player2(_ sender: Any) {
        activePlayer = (data?.players[1])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player3(_ sender: Any) {
        activePlayer = (data?.players[2])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player4(_ sender: Any) {
        activePlayer = (data?.players[3])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player5(_ sender: Any) {
        activePlayer = (data?.players[4])!
        drawingBoard.changeColor(player: activePlayer)
    }
    
    @IBAction func player6(_ sender: Any) {
        activePlayer = (data?.players[5])!
        drawingBoard.changeColor(player: activePlayer)
    }
}
