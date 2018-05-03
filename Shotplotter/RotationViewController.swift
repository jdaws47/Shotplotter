//
//  RotationViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController, SubstituteDelegate {
  
    
    @IBOutlet weak var drawingBoard: ArrowView!
    var data: RotationView?
    var screenshot: UIImage?
    @IBOutlet weak var goToGame: UIButton!
    @IBOutlet weak var rotationTitle: UINavigationItem!
    weak var delegate: RotationDelegate?
    var activePlayer: Player
    
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var slideButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    
    @IBOutlet weak var playerSpot1: PlayerSpot!
    @IBOutlet weak var playerSpot2: PlayerSpot!
    @IBOutlet weak var playerSpot3: PlayerSpot!
    @IBOutlet weak var playerSpot4: PlayerSpot!
    @IBOutlet weak var playerSpot5: PlayerSpot!
    @IBOutlet weak var playerSpot6: PlayerSpot!
    
    var subData: GameView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drawingBoard.data = self.data
        //tipShot.addTarget(customDataTypes., action: #selector(ActiveSwitch.switched(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawingBoard.data = data
        //print("RotationView: " + String(describing: data?.activePlayers.count))
        rotationTitle.title = "Rotation \((data?.rotationID)! % 10 + 1)"
        checkButtons()
        for i in 0 ..< (data?.activePlayers.count)! {
            let player = (data?.activePlayers[i])!
            if (!player.layerExists) {
                drawingBoard.layer.addSublayer(player.initializeLayer((data?.rotationID)!))
                player.layerExists = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.data = RotationView()
        activePlayer = Player()
        super.init(coder: aDecoder)
        //adlsjf
        let _ = updateShotButtonsEvent.addHandler(target: self, handler: RotationViewController.checkButtons)
    }
    
    @IBAction func goBack(_ sender: Any) {
        screenshot = drawingBoard.pb_takeSnapshot()
        delegate?.passScreenCap(screenshot: screenshot!, index: ((data?.rotationID)! % 10))
        for i in 0 ..< (data?.activePlayers.count)! {
            data?.activePlayers[i].layerExists = false
        }
		saveDataEvent.raise(data: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TipTypeSelect(_ sender: Any) {
        data?.protoLine.tip = !(data?.protoLine.tip)!
        if (data?.protoLine.tip)! {
            data?.protoLine.roll = false
            data?.protoLine.A = false
        }
        //print("Tip shot type toggled: " + String(describing: data?.protoLine.tip))
        checkButtons()
    }
    
    @IBAction func SlideTypeSelect(_ sender: Any) {
        data?.protoLine.slide = !(data?.protoLine.slide)!
        //print("Slide shot type toggled: " + String(describing: data?.protoLine.slide))
        checkButtons()
    }
    
    @IBAction func RollTypeSelect(_ sender: Any) {
        data?.protoLine.roll = !(data?.protoLine.roll)!
        if (data?.protoLine.roll)! {
            data?.protoLine.tip = false
            data?.protoLine.A = false
        }
        //print("Roll shot type toggled: " + String(describing: data?.protoLine.roll))
        checkButtons()
    }
    
    @IBAction func ATypeSelect(_ sender: Any) {
        data?.protoLine.A = !(data?.protoLine.A)!
        if (data?.protoLine.A)! {
            data?.protoLine.roll = false
            data?.protoLine.tip = false
        }
        //print("A shot type toggled: " + String(describing: data?.protoLine.A))
        checkButtons()
    }
    
    @IBAction func ScoreButtonSelect(_ sender: Any) {
        data?.protoLine.didScore = !(data?.protoLine.didScore)!
        //print("Shot didScore value changed to: " + String(describing: data?.protoLine.didScore))
        checkButtons()
    }
    
    @IBAction func player1(_ sender: Any) {
        data?.selected = 0
        activePlayer = (data?.activePlayers[0])!
        drawingBoard.changeColor(player: activePlayer)
        checkButtons()
    }
    
    @IBAction func player2(_ sender: Any) {
        data?.selected = 1
        activePlayer = (data?.activePlayers[1])!
        drawingBoard.changeColor(player: activePlayer)
        checkButtons()
    }
    
    @IBAction func player3(_ sender: Any) {
        data?.selected = 2
        activePlayer = (data?.activePlayers[2])!
        drawingBoard.changeColor(player: activePlayer)
        checkButtons()
    }
    
    @IBAction func player4(_ sender: Any) {
        data?.selected = 3
        activePlayer = (data?.activePlayers[3])!
        drawingBoard.changeColor(player: activePlayer)
        checkButtons()
    }
    
    @IBAction func player5(_ sender: Any) {
        data?.selected = 4
        activePlayer = (data?.activePlayers[4])!
        drawingBoard.changeColor(player: activePlayer)
        checkButtons()
    }
    
    @IBAction func player6(_ sender: Any) {
        data?.selected = 5
        activePlayer = (data?.activePlayers[5])!
        drawingBoard.changeColor(player: activePlayer)
        checkButtons()
    }
    
    func checkButtons (empty: Int = 0) {
        if (data?.protoLine.A)! {
            aButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/AOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            aButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/AOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.roll)! {
            rollButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/RollOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            rollButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/RollOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.slide)! {
            slideButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/SlideOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            slideButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/SlideOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.tip)! {
            tipButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/TipOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            tipButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/TipOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if (data?.protoLine.didScore)! {
            scoreButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/ScoreOn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            scoreButton.setBackgroundImage(UIImage(named: "ShotTypeIcons/ScoreOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        if (data?.selected == 0) {playerSpot1.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOn.png"), for: .normal)}
        else {playerSpot1.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOff.png"), for: .normal)}
        if (data?.selected == 1) {playerSpot2.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOn.png"), for: .normal)}
        else {playerSpot2.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOff.png"), for: .normal)}
        if (data?.selected == 2) {playerSpot3.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOn.png"), for: .normal)}
        else {playerSpot3.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOff.png"), for: .normal)}
        if (data?.selected == 3) {playerSpot4.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOn.png"), for: .normal)}
        else {playerSpot4.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOff.png"), for: .normal)}
        if (data?.selected == 4) {playerSpot5.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOn.png"), for: .normal)}
        else {playerSpot5.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOff.png"), for: .normal)}
        if (data?.selected == 5) {playerSpot6.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOn.png"), for: .normal)}
        else {playerSpot6.setBackgroundImage(UIImage(named:"ShotTypeIcons/PlayerOff.png"), for: .normal)}
        
        playerSpot1.tintColor = UIColor.black
        playerSpot1.backgroundColor = UIColor(cgColor: (data?.activePlayers[0].color)!)
        playerSpot1.setTitle(String(describing: data!.activePlayers[0].number), for: .normal)
        playerSpot2.tintColor = UIColor.black
        playerSpot2.backgroundColor = UIColor(cgColor: (data?.activePlayers[1].color)!)
        playerSpot2.setTitle(String(describing: data!.activePlayers[1].number), for: .normal)
        playerSpot3.tintColor = UIColor.black
        playerSpot3.backgroundColor = UIColor(cgColor: (data?.activePlayers[2].color)!)
        playerSpot3.setTitle(String(describing: data!.activePlayers[2].number), for: .normal)
        playerSpot4.tintColor = UIColor.black
        playerSpot4.backgroundColor = UIColor(cgColor: (data?.activePlayers[3].color)!)
        playerSpot4.setTitle(String(describing: data!.activePlayers[3].number), for: .normal)
        playerSpot5.tintColor = UIColor.black
        playerSpot5.backgroundColor = UIColor(cgColor: (data?.activePlayers[4].color)!)
        playerSpot5.setTitle(String(describing: data!.activePlayers[4].number), for: .normal)
        playerSpot6.tintColor = UIColor.black
        playerSpot6.backgroundColor = UIColor(cgColor: (data?.activePlayers[5].color)!)
        playerSpot6.setTitle(String(describing: data!.activePlayers[5].number), for: .normal)
    }
    
    @IBAction func nextRotation(_ sender: Any) {
        screenshot = drawingBoard.pb_takeSnapshot()
        delegate?.passScreenCap(screenshot: screenshot!, index: ((data?.rotationID)! % 10))
        delegate?.nextRotation(ID: (data?.rotationID)!, self)
        drawingBoard.data = data
        drawingBoard.clear()
        self.viewWillAppear(false)
    }
    
    @IBAction func prevRotation(_ sender: Any) {
        screenshot = drawingBoard.pb_takeSnapshot()
        delegate?.passScreenCap(screenshot: screenshot!, index: ((data?.rotationID)! % 10))
        delegate?.previousRotation(ID: (data?.rotationID)!, self)
        drawingBoard.data = data
        drawingBoard.clear()
        self.viewWillAppear(false)
    }
    
    @IBAction func goToSubstitution(_ sender: Any) {
        subData = delegate?.getData(sender: self)
        self.performSegue(withIdentifier: "RotationToOrder", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RotationToOrder") {
            if let destination = segue.destination as? OrderViewController {
                destination.data = subData
                destination.data?.activePlayers = (self.data?.activePlayers)!
                destination.passthroughDelegate1 = self
            }
        }
    }
    
    func syncActiveArray(newArray: [Player], playerSubbedOut: Player) {
        self.data?.activePlayers = newArray
        print("Rotation active synced")
        data?.players.forEach({ (i) in if(!i.isActive){ i.layerExists = false }})
        drawingBoard.layer.sublayers?.forEach({ (j) in if(j == playerSubbedOut.layer){ j.removeFromSuperlayer() }})
        drawingBoard.clear()
        viewWillAppear(false)
    }
    
	@IBAction func undoDelete(_ sender: Any) {
		print("hello sdfgsdfgdfsg")
		drawingBoard?.undo()
		viewWillAppear(false)
		print("bye dfgdfsgdfsg")
	}
	
	func updatePreviewPositions(_ activePlayers: [Player]) {
        //wow, such empty
    }
}
