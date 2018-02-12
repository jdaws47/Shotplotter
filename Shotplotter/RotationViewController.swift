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
    var protoLine: Line
    @IBOutlet weak var goToGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //tipShot.addTarget(customDataTypes., action: #selector(ActiveSwitch.switched(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawingBoard.data = data
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = RotationView()
        protoLine = Line(startPos: CGPoint.init(x:0,y:0), endPos: CGPoint.init(x:0,y:0), tip: false, slide: false, A: false, roll: false, hit: false, color: UIColor.black, didScore: false, rotationID: -1)
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func player1(_ sender: Any) {
        print("Player1 button pushed")
        drawingBoard.changeColor(player: (data?.players[0])!)
    }
    
    @IBAction func TipTypeSelect(_ sender: Any) {
    }
    
    @IBAction func SlideTypeSelect(_ sender: Any) {
    }
    
    @IBAction func RollTypeSelect(_ sender: Any) {
    }
    
    @IBAction func ATypeSelect(_ sender: Any) {
    }
}
