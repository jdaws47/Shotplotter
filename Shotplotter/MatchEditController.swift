//
//  MatchEditController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MatchEditController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var data: MatchView?
    var localTableView: UITableView?

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
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableCell
        
        // Fetches the appropriate meal for the data source layout.
        let player = data?.players[indexPath.row]
        
        cell.imageView?.backgroundColor = player?.color
        cell.name.delegate = self
        cell.number.delegate = self
        
        localTableView = tableView
        return cell
    }
    
    /*public func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(playerStepper.value)
    }
    
    /*required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }*/
    
    func textFieldDidEndEditing(textField: UITextField) {
        //textField.
    }
}
