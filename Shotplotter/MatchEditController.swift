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
    
    // Doesn't always run. Do not use
    override func viewDidLoad() {
        nameOfOpponent.text = data?.opponentName
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Runs whenever the view starts loading. Use this instead of DidLoad.
    override func viewWillAppear(_ animated: Bool) {
        nameOfOpponent.text = data?.opponentName
        calendarWidget.setDate(data?.datePlayed as! Date, animated: true)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }  
    
    // Runs when the number of players in the Match is changed. Will update colors and the player array
    @IBAction func adjustPlayerNumber(_ sender: Any) {
        numberOfPlayersLabel.text = "\(Int(playerStepper.value))"
    }
    
    // TODO: Needs documentation
    @IBAction func goBack(_ sender: Any) {
        data?.datePlayed = calendarWidget.date as NSDate
        data?.dateEdited = NSDate.init()
        dismiss(animated: true, completion: nil)
    }
    
    // Runs when the name of the opponent school is changed.
    @IBAction func oppNameChanged(_ sender: Any) {
        data?.opponentName = nameOfOpponent.text!
    }
    
    
    
    /*required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }*/
}
