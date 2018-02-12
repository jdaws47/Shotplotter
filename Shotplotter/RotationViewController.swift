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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drawingBoard.data = self.data
        //tipShot.addTarget(customDataTypes., action: #selector(ActiveSwitch.switched(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = RotationView()
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func player1(_ sender: Any) {
        print("Player1 button pushed")
        //guard data?.players[0] != nil else {
            drawingBoard.changeColor(player: (data?.players[0])!)
            //return
        //}
    }
    
    @IBAction func player2(_ sender: Any) {
        drawingBoard.changeColor(player: (data?.players[1])!)
    }
    
    @IBAction func player3(_ sender: Any) {
        drawingBoard.changeColor(player: (data?.players[2])!)
    }
    
    @IBAction func player4(_ sender: Any) {
        drawingBoard.changeColor(player: (data?.players[3])!)
    }
    
    @IBAction func player5(_ sender: Any) {
        drawingBoard.changeColor(player: (data?.players[4])!)
    }
    
    @IBAction func player6(_ sender: Any) {
        drawingBoard.changeColor(player: (data?.players[5])!)
    }
}
