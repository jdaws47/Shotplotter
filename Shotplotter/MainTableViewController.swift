//
//  MainTableViewController.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 12/21/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //var cells: [MatchView]
    var data: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //loadSample()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data = MainView()
        data?.matches = [MatchView()]
        data?.matches[0].opponentName = "Example #1"
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
    
    private func loadSample() {
        let match1 = MatchView()
        let match2 = MatchView()
        
        data?.matches += [match1, match2]
    }
}
