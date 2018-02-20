//
//  GameViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var data: GameView?
    @IBOutlet weak var goToMatch: UIButton!
    var passedRotation = -1
    @IBOutlet weak var navTitle: UINavigationItem!
    
    
    // Doesn't always run. Do not use
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navTitle.title = "Game \((data?.gameNum)! + 1) vs. \((data?.opponentName)!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = GameView()
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rotation1(_ sender: Any) {
        passedRotation = 0
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation2(_ sender: Any) {
        passedRotation = 1
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation3(_ sender: Any) {
        passedRotation = 2
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation4(_ sender: Any) {
        passedRotation = 3
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation5(_ sender: Any) {
        passedRotation = 4
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation6(_ sender: Any) {
        passedRotation = 5
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    //Runs right before a segue happens, every time a segue happens. Used to pass information to the segue destination. Uses passedGame to choose which item in the games[] array.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "OpenActivePlayers") {
            if let destination = segue.destination as? GameEditController {
                destination.data = self.data
            }
        } else if (segue.identifier == "GameToRotation") {
            if let destination = segue.destination as? RotationViewController {
                destination.data = data?.rotations[passedRotation]
            }
        }
    }
    
}
