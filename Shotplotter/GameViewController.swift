//
//  GameViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, RotationDelegate {
    var data: GameView?
    @IBOutlet weak var goToMatch: UIButton!
    var passedRotation = -1
    @IBOutlet weak var navTitle: UINavigationItem!
    var previews = [UIImage]()
    var rotationButtons = [UIButton]()
    @IBOutlet weak var rotation1: UIButton!
    @IBOutlet weak var rotation2: UIButton!
    @IBOutlet weak var rotation3: UIButton!
    @IBOutlet weak var rotation4: UIButton!
    @IBOutlet weak var rotation5: UIButton!
    @IBOutlet weak var rotation6: UIButton!
    
    // Doesn't always run. Do not use
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0 ..< 6 {
            previews.append(#imageLiteral(resourceName: "Volleyball Court.jpg"))
        }
        rotationButtons.append(rotation1)
        rotationButtons.append(rotation2)
        rotationButtons.append(rotation3)
        rotationButtons.append(rotation4)
        rotationButtons.append(rotation5)
        rotationButtons.append(rotation6)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print(data?.gameNum)
        //print(data?.opponentName)
        //if data?.gameNum != nil && data?.opponentName != nil {
        let game = (data?.gameNum)! + 1
        let name = (data?.opponentName)!
        navTitle.title = "Game \(game) vs. \(name)"
        for i in 0 ..< previews.count {
            //rotationButtons[i].background = previews[i]
        }
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
    
    func passScreenCap(screenshot: UIImage, index: Int) {
        previews[index] = screenshot
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
                destination.delegate = self
            }
        }
    }
    
}
