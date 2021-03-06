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
    var localTextField: UITextField?
    var keyBoardSize: CGRect?
    var editingIndexPath: IndexPath?

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
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Runs whenever the view starts loading. Use this instead of DidLoad.
    override func viewWillAppear(_ animated: Bool) {
        nameOfOpponent.text = data?.opponentName
		calendarWidget.setDate(data?.datePlayed as! Date, animated: true) //circular warning
        playerStepper.value = Double((data?.numOfPlayers)!)
        numberOfPlayersLabel.text = "\(Int(playerStepper.value))"
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
        data?.numOfPlayers = Int(playerStepper.value)
        localTableView?.reloadData()
    }
    
    // TODO: Needs documentation
    @IBAction func goBack(_ sender: Any) {
        data?.datePlayed = calendarWidget.date as NSDate
        data?.dateEdited = NSDate.init()
		saveDataEvent.raise(data: true)
        dismiss(animated: true, completion: nil)
    }
    
    // Runs when the name of the opponent school is changed.
    @IBAction func oppNameChanged(_ sender: Any) {
        data?.opponentName = nameOfOpponent.text!
    }
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableCell
        
        // Fetches the appropriate meal for the data source layout.
        let player = data?.players[indexPath.row]
        
        if(player?.name != "") {
            cell.name.text = player?.name
        }
        if(player?.number != -1) {
            cell.number.text = String((player?.number)!)
        }
        //cell.imageView?.backgroundColor = player?.color
        cell.color.backgroundColor = UIColor(cgColor: setColor(indexPath.row))
        player?.color = cell.color.backgroundColor!.cgColor
        cell.name.delegate = self
        cell.number.delegate = self
        cell.name.index = indexPath.row
        cell.number.index = indexPath.row
        cell.number.isName = false
        
        editingIndexPath = indexPath
        localTableView = tableView
        return cell
    }
    
    /*public func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.numOfPlayers)!
    }
    
    /*required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }*/
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textField = textField as! PlayerTextField
        let fieldIndexPath = IndexPath(row: textField.index, section: 0)
        localTableView?.scrollToRow(at: fieldIndexPath, at: .top, animated: true)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textField = textField as! PlayerTextField
        if (textField.isName) {
            data?.players[textField.index].name = textField.text!
        } else {
            data?.players[textField.index].number = Int(textField.text!)!
        }
    }

    @objc func keyboardWasShown (notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        var contentInsets:UIEdgeInsets
        
        if UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation) {
            
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize?.height)! / 2, 0.0);
        }
        else {
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize?.height)! / 2, 0.0);
            
        }
        
        localTableView?.contentInset = contentInsets
        localTableView?.scrollIndicatorInsets = (localTableView?.contentInset)!
    }
    
    @objc func keyboardWillBeHidden (notification: NSNotification) {
        localTableView?.contentInset = UIEdgeInsets.zero
        localTableView?.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

