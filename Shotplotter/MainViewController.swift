//
//  MainViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data: MainView?
    var passedMatch = -1
    private var localTableView: UITableView?
    
    // Doesn't always run. Do not use
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Runs whenever the view starts loading. Use this instead of DidLoad.
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
    
    // Runs once for each cell in a table. Use to initialize cell values, such as the labels
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell", for: indexPath) as! GlobalTableViewCell
        
        // Fetches the appropriate match for the data source layout.
        let match = data?.matches[indexPath.row]
        
        cell.opponentName.text = match?.opponentName
        
        var date = match?.dateCreated.description
        let regexp = "\\d*-\\d*-\\d*"
        if let range = date?.range(of:regexp, options: .regularExpression) {
            date = date?.substring(with:range)
        }
        cell.date.text = date
        //cell.date.text = match?.dateCreated.description
        
        localTableView = tableView
        return cell
    }
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Just a basic getter to get the number of cells that are supposed to be in the table
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.matches.count)!
    }
    
    // Runs whenever a cell is tapped. Used to segue to the relevant Match.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedMatch = indexPath.row
        self.performSegue(withIdentifier: "MainToMatch", sender: self)
    }
    
    @IBAction func addNewMatch(_ sender: Any) {
        data?.addMatch()
        localTableView?.reloadData()
        passedMatch = (data?.matches.count)! - 1
        self.performSegue(withIdentifier: "MainToMatch", sender: self)
    }
    
    //Runs right before a segue happens, every time a segue happens. Used to pass information to the segue destination.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToMatch") {
            if let destination = segue.destination as? MatchViewController {
                destination.data = (self.data?.matches[passedMatch])!
            }
        }
    }
}
