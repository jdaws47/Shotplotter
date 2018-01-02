//
//  MatchEditController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MatchEditController: UIViewController {
    var data: MatchView?

    //MARK: Protocols
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var playerStepper: UIStepper!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameOfOpponent: UITextField!
    @IBOutlet weak var calendarWidget: UIDatePicker!
    
    
    override func viewDidLoad() {
        nameOfOpponent.text = data?.opponentName
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameOfOpponent.text = data?.opponentName
        calendarWidget.setDate(data?.datePlayed as! Date, animated: true)
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        data = MatchView()
        super.init(coder: aDecoder)
    }
    
    @IBAction func adjustPlayerNumber(_ sender: Any) {
        numberOfPlayersLabel.text = "\(Int(playerStepper.value))"
    }
    
    @IBAction func goBack(_ sender: Any) {
        data?.datePlayed = calendarWidget.date as NSDate
        data?.dateEdited = NSDate.init()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func oppNameChanged(_ sender: Any) {
        data?.opponentName = nameOfOpponent.text!
    }
    
    
    
    /*required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }*/
}
