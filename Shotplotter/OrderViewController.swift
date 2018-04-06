//
//  OrderViewController.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 4/2/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: GameView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("order count = \(data?.activePlayers.count)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = GameView()
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activeOrderPlayers", for: indexPath) as! OrderCell
        
        // Fetches the appropriate meal for the data source layout.
        let player = data?.activePlayers[indexPath.row]
        
        cell.name.text = player?.name
        cell.number.text = "\((player?.number)!)"
        
        return cell
    }
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data?.activePlayers.count != nil) {
            return (data?.activePlayers.count)!
        } else {
            return 6
        }
    }
    
}
