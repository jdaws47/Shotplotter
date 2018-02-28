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
    let activePError = UIAlertController.init(title: "Not Enough Active Players", message: "There aren't six active players. Please select six active players before opening a rotation.", preferredStyle: .alert)
    
    
    // Doesn't always run. Do not use
    override func viewDidLoad() {
        super.viewDidLoad()
        if(previews.count < 6) {
            for _ in 0 ..< 6 {
                previews.append(#imageLiteral(resourceName: "Volleyball Court.jpg"))
            }
        }
        activePError.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            (action: UIAlertAction!) in print("Handle Ok logic here")
        }))
//        rotationButtons.append(rotation1)
//        rotationButtons.append(rotation2)
//        rotationButtons.append(rotation3)
//        rotationButtons.append(rotation4)
//        rotationButtons.append(rotation5)
//        rotationButtons.append(rotation6)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print(data?.gameNum)
        //print(data?.opponentName)
        //if data?.gameNum != nil && data?.opponentName != nil {
        let game = (data?.gameNum)! + 1
        let name = (data?.opponentName)!
        navTitle.title = "Game \(game) vs. \(name)"
        print("GameView: " + String(describing: data?.activePlayers.count))
//        for i in 0 ..< previews.count {
//            rotationButtons[i].setBackgroundImage(previews[i], for: UIControlState.normal)
//        }
        rotation1.setImage(previews[0], for: UIControlState.normal)
        rotation2.setImage(previews[1], for: UIControlState.normal)
        rotation3.setImage(previews[2], for: UIControlState.normal)
        rotation4.setImage(previews[3], for: UIControlState.normal)
        rotation5.setImage(previews[4], for: UIControlState.normal)
        rotation6.setImage(previews[5], for: UIControlState.normal)
        //rotation1.imageView!.image = previews[0]
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
        if ((data?.activePlayers.count)! < 6) {
            self.present(activePError, animated: true, completion: nil)
            return
        }
        passedRotation = 0
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation2(_ sender: Any) {
        if((data?.activePlayers.count)! < 6) {
            self.present(activePError, animated: true, completion: nil)
            return
        }
        passedRotation = 1
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation3(_ sender: Any) {
        if((data?.activePlayers.count)! < 6) {
            self.present(activePError, animated: true, completion: nil)
            return
        }
        passedRotation = 2
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation4(_ sender: Any) {
        if((data?.activePlayers.count)! < 6) {
            self.present(activePError, animated: true, completion: nil)
            return
        }
        passedRotation = 3
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation5(_ sender: Any) {
        if((data?.activePlayers.count)! < 6) {
            self.present(activePError, animated: true, completion: nil)
            return
        }
        passedRotation = 4
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    @IBAction func rotation6(_ sender: Any) {
        if((data?.activePlayers.count)! < 6) {
            self.present(activePError, animated: true, completion: nil)
            return
        }
        passedRotation = 5
        self.performSegue(withIdentifier: "GameToRotation", sender: self)
    }
    
    func passScreenCap(screenshot: UIImage, index: Int) {
        previews[index] = screenshot
        print(screenshot)
        print(previews[index])
    }
    
    //Runs right before a segue happens, every time a segue happens. Used to pass information to the segue destination. Uses passedGame to choose which item in the games[] array.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        data?.updateActive()
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
