//
//  MainTableViewController.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 12/21/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data: MainView?
    var passedMatch = -1
    private var localTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.localTableView?.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data = MainView()
        data?.addMatch()
        data?.matches[0].opponentName = "Example #1"
        data?.matches[0].firstView = true
        data?.matches[0].addGame()
        super.init(coder: aDecoder)
    }
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell", for: indexPath) as! GlobalTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let match = data?.matches[indexPath.row]
        
        cell.opponentName.text = match?.opponentName
        cell.date.text = match?.dateCreated.description
        
        localTableView = tableView
        return cell
    }
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.matches.count)!
    }
    
    // This gets called when a singular cell gets called
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedMatch = indexPath.row
        self.performSegue(withIdentifier: "MainToMatch", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToMatch") {
            if let destination = segue.destination as? MatchViewController {
                destination.data = (self.data?.matches[passedMatch])!
            }
        }
    }
}
