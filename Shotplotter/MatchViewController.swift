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
    private var localTableView: UITableView?
    @IBOutlet weak var backToMain: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleBox: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Like Caillou, this function doesn't deserve hair or love
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(data?.firstView)! {
            data?.firstView = false
            self.performSegue(withIdentifier: "MatchToMEdit", sender: self)
        }
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleBox.title = "Match vs. " + (data?.opponentName)!
        self.localTableView?.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        data?.opponentName = ""
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
                destination.data = (self.data?.games[passedGame])
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let game = data?.games[indexPath.row]
        
        cell.title.text = "Game #\(game?.gameNum ?? -1)"
        
        localTableView = tableView
        return cell
    }
    
    /*public func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }*/
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data!.games.count)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedGame = indexPath.row
        self.performSegue(withIdentifier: "MatchToGame", sender: self)
    }
}
