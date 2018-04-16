//
//  SubstituteViewController.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 4/9/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class SubstituteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data: GameView?
    var localTableView: UITableView?
    var playerSubbedOutIndex: Int?
    var offset: Int?
    var delegate: SubstituteDelegate?
    var delegate2: SubstituteDelegate?
    var counter: Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        offset = 0
        counter = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = GameView()
        counter = 0
        super.init(coder: aDecoder)
    }
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        while (data?.players[indexPath.row + offset!].isActive)! {
            offset! += 1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "substitutePlayer", for: indexPath) as! SubstituteCell
        
        // Fetches the appropriate meal for the data source layout.
        
        let player = data?.players[indexPath.row + offset!]
        
        cell.name.text = player?.name
        cell.number.text = "\(player?.number ?? -1)"
        
        localTableView = tableView
        
        if(indexPath.row == (data?.numOfPlayers)! - (data?.activePlayers.count)! - 1) {
            offset = 0
        }
        
        return cell
    }
    
    /*public func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data?.numOfPlayers != nil) {
            return (data?.numOfPlayers)! - (data?.activePlayers.count)!
        } else {
            return 6
        }
    }
    
    // Gets called when a cell is selected. Subs the selected player into the active players array
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        counter = -1
        var nonActiveCount = 0
        for i in 0 ..< (data?.players.count)! {
            if(!(data?.players[i].isActive)!) {
                nonActiveCount += 1
            }
            if (indexPath.row + 1 == nonActiveCount) {
                counter = i
                break
            }
        }
        
        data?.players[counter].isActive = true
        data?.activePlayers[playerSubbedOutIndex!].isActive = false
        data?.activePlayers.insert((data?.players[counter])!, at: playerSubbedOutIndex!)
        data?.activePlayers.remove(at: playerSubbedOutIndex! + 1)
        counter = 0
        delegate?.syncActiveArray(newArray: (data?.activePlayers)!)
        delegate2?.syncActiveArray(newArray: (data?.activePlayers)!)
        delegate?.updatePreviewPositions((data?.activePlayers)!)
        delegate2?.updatePreviewPositions((data?.activePlayers)!)
        self.dismiss(animated: true, completion: nil)
    }
}

