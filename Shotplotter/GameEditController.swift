//
//  GameEditController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class GameEditController: UIViewController, UITableViewDataSource, UITableViewDelegate, ActiveSwitchDelegate {
    var data: GameView?
    var localTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = GameView()
        super.init(coder: aDecoder)
    }
    
    // This gets called to load each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activePlayers", for: indexPath) as! ActivePlayerCell
        
        // Fetches the appropriate meal for the data source layout.
        let player = data?.players[indexPath.row]
        
        cell.activeSwitch.index = indexPath.row
        cell.activeSwitch.delegate = self
        cell.name.text = player?.name
        cell.number.text = String((player?.number)!)
        cell.activeSwitch.isOn = (player?.isActive)!
        
        cell.activeSwitch.addTarget(cell.activeSwitch, action: #selector(ActiveSwitch.switched(_:)), for: UIControlEvents.valueChanged)
        
        localTableView = tableView
        return cell
    }
    
    /*public func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    // Returns the number of cells in the TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data?.players.count != nil) {
            return (data?.players.count)!
        } else {
            return 12
        }
    }
    
    func switched(sender: ActiveSwitch) {
        data?.players[sender.index].isActive = sender.isOn
        if (data?.players[sender.index].isActive)! && (data?.activePlayers.count)! > 0 {
            for k in 0 ..< (data?.activePlayers.count)! {
                if (data?.players[sender.index])! === (data?.activePlayers[k])! {
                    //print(data?.activePlayers)
                    return
                }
            }
            data?.activePlayers.append((data?.players[sender.index])!)
        } else if (data?.players[sender.index].isActive)! && (data?.activePlayers.count == 0) {
            data?.activePlayers.append((data?.players[sender.index])!)
        } else {
            for var k in 0 ..< (data?.activePlayers.count)! {
                if (data?.players[sender.index])! === (data?.activePlayers[k])! {
                    data?.activePlayers.remove(at: k)
                    k = 0
                }
            }
        }
        //print(data?.activePlayers)
    }
    
}
