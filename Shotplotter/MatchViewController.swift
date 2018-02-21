//
//  MatchViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data: MatchView?
    var passedGame = -1 //initial value that can't exist as an index
    private var localTableView: UITableView? // A reference to the table of Games
    @IBOutlet weak var backToMain: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleBox: UINavigationItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // Doesn't always run. Do not use
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Like Caillou, this function doesn't deserve hair or love
    }
    
    // Runs whenever the view finishes loading. Use this instead of DidLoad.
    override func viewDidAppear(_ animated: Bool) {
        if(data?.firstView)! {
            data?.firstView = false
            self.performSegue(withIdentifier: "MatchToMEdit", sender: self)
        }
        super.viewDidAppear(animated)
    }
    
    // Runs whenever the view starts loading. Use this instead of DidLoad.
    override func viewWillAppear(_ animated: Bool) {
        titleBox.title = "Match vs. " + (data?.opponentName)!
        self.localTableView?.reloadData()
        super.viewWillAppear(animated)
        if((data?.games.count)! >= 5) {
            addButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        data?.opponentName = ""
        super.init(coder: aDecoder)
    }
    
    // TODO: Needs documentation
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //Runs right before a segue happens, every time a segue happens. Used to pass information to the segue destination. Uses passedGame to choose which item in the games[] array.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MatchToMEdit") {
            if let destination = segue.destination as? MatchEditController {
                destination.data = self.data
            }
        } else if (segue.identifier == "MatchToGame") {
            if let destination = segue.destination as? GameViewController {
                destination.data = (self.data?.games[passedGame])
                destination.data?.opponentName = (self.data?.opponentName)!
                destination.data?.numOfPlayers = (data?.numOfPlayers)!
            }
        }
    }
    
    // Runs once for each cell in a table. Use to initialize cell values, such as the labels.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let game = data?.games[indexPath.row]
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        cell.addGestureRecognizer(longGesture)
        cell.title.text = "Game #\((game?.gameNum)! + 1 )"
        
        localTableView = tableView
        return cell
    }
    
    /*public func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Just a basic getter to get the number of cells that are supposed to be in the table
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data!.games.count)
    }
    
    // Runs whenever a cell is tapped. Used to segue to the relevant Game.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedGame = indexPath.row
        self.performSegue(withIdentifier: "MatchToGame", sender: self)
    }
    
    //deletes row when called
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.row > 2{
            //print("Deleted")
            
            data?.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        if((data?.games.count)! < 5) {
            addButton.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < 3 {
            return false
        }
        return true
    }
    
    @IBAction func addGame(_ sender: Any) {
        data?.addGame()
        localTableView?.reloadData()
        if((data?.games.count)! >= 5) {
            addButton.isEnabled = false
        }
    }
    
    func longPress() {
        localTableView?.setEditing(!(localTableView?.isEditing)!, animated: true)
    }
}
