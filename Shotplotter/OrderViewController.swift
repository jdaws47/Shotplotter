//
//  OrderViewController.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 4/2/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SubstituteDelegate, SubButtonDelegate {
    
    var data: GameView?
    private var localTableView: UITableView?
    var passthroughDelegate: SubstituteDelegate?
    
    @IBOutlet weak var playerSpot1: PlayerSpot!
    @IBOutlet weak var playerSpot2: PlayerSpot!
    @IBOutlet weak var playerSpot3: PlayerSpot!
    @IBOutlet weak var playerSpot4: PlayerSpot!
    @IBOutlet weak var playerSpot5: PlayerSpot!
    @IBOutlet weak var playerSpot6: PlayerSpot!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //localTableView?.setEditing(true, animated: true)
        updatePreviewPositions((data?.activePlayers)!)
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
        cell.subButton.player = player
        cell.subButton.indexOfPlayer = indexPath.row

        cell.subButton.delegate = self
        cell.subButton.addTarget(cell.subButton, action: #selector(SubButton.pressed(_:)), for: UIControlEvents.touchDown)
        
        localTableView = tableView
        tableView.isEditing = true
        tableView.setEditing(true, animated: false)
        
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
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.data?.activePlayers[sourceIndexPath.row]
        data?.activePlayers.remove(at: sourceIndexPath.row)
        data?.activePlayers.insert(movedObject!, at: destinationIndexPath.row)
        updatePreviewPositions((data?.activePlayers)!)
        localTableView?.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func updatePreviewPositions(_ activePlayers: [Player]) {
        playerSpot1.player = activePlayers[0]
        playerSpot1.setTitle("\(activePlayers[0].number)", for: .normal)
        playerSpot2.player = activePlayers[1]
        playerSpot2.setTitle("\(activePlayers[1].number)", for: .normal)
        playerSpot3.player = activePlayers[2]
        playerSpot3.setTitle("\(activePlayers[2].number)", for: .normal)
        playerSpot4.player = activePlayers[3]
        playerSpot4.setTitle("\(activePlayers[3].number)", for: .normal)
        playerSpot5.player = activePlayers[4]
        playerSpot5.setTitle("\(activePlayers[4].number)", for: .normal)
        playerSpot6.player = activePlayers[5]
        playerSpot6.setTitle("\(activePlayers[5].number)", for: .normal)
        print("give up already")
    }
    
    func openSubstitution(_ sender: SubButton) {
        self.performSegue(withIdentifier: "OrderToSubstitute", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        data?.updateActive()
        if (segue.identifier == "OrderToSubstitute") {
            if let destination = segue.destination as? SubstituteViewController {
                destination.data = self.data
                destination.delegate = self
                destination.delegate2 = passthroughDelegate
                destination.playerSubbedOutIndex = (sender as! SubButton).indexOfPlayer
            }
        }
    }
    
    func syncActiveArray(newArray: [Player]) {
        data?.activePlayers = newArray
        localTableView?.reloadData()
    }
}
