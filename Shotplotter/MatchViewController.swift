//
//  MatchViewController.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    var data: MatchView
    @IBOutlet weak var backToMain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data = MatchView()                 //REPLACE THIS
        data.opponentName = "POTATO SCHOOL OF EXCELLENCE"
        super.init(coder: aDecoder)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func toMatchEdit(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MatchToMEdit" {
            if let destination = segue.destination as? MatchEditController {
                destination.data = self.data
            }
        }
    }
/*required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }*/
    
    

}
