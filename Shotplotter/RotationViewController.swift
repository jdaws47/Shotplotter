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
        drawingBoard.changeColor(player: (data?.players[0])!)
    }
    
    
}
