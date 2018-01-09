//
//  MatchViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data: MatchView
    var passedMatch = -1
    var localTableView: UITableView
    @IBOutlet weak var backToMain: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleBox: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(data.firstView) {
            data.firstView = false
            self.performSegue(withIdentifier: "MatchToMEdit", sender: self)
        }
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleBox.title = "Match vs. " + data.opponentName
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data = MatchView()                 //REPLACE THIS
        data.opponentName = ""
        localTableView = UITableView()
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MatchToMEdit") {
            if let destination = segue.destination as? MatchEditController {
                destination.data = self.data
            }
        } else if (segue.identifier == "MatchToGame") {
            if let destination = segue.destination as? GameViewController {
                destination.data = (self.data.games[passedMatch])
            }
        }
    }
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let game = data.games[indexPath.row]
        
        //cell.opponentName.text = game.opponentName
        //cell.date.text = game.dateCreated.description
        
        localTableView = tableView
        return cell
    }
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data.games.count)
    }
    
    // This gets called when a singular cell gets called
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedMatch = indexPath.row
        self.performSegue(withIdentifier: "MainToMatch", sender: self)
    }
}
