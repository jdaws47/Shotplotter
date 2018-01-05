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
    var localTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loadSample()
        self.localTableView?.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data = MainView()
        data?.matches = [MatchView()]
        data?.matches[0].opponentName = "Example #1"
        data?.matches[0].firstView = true
        super.init(coder: aDecoder)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell", for: indexPath) as! GlobalTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let match = data?.matches[indexPath.row]
        
        cell.opponentName.text = match?.opponentName
        cell.date.text = match?.dateCreated.description
        
        
        return cell
    }
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.matches.count)!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedMatch = indexPath.row
        self.performSegue(withIdentifier: "MainToMatch", sender: self)
    }
    
    private func loadSample() {
        let match1 = MatchView()
        let match2 = MatchView()
        
        data?.matches += [match1, match2]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToMatch") {
            if let destination = segue.destination as? MatchViewController {
                destination.data = (self.data?.matches[passedMatch])!
            }
        }
    }
}
