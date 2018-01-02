//
//  globalTableViewCell.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 12/20/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class GlobalTableViewCell: UITableViewCell {
    var data: MainView?
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    init(pName: String, pDate: String, coder aDecoder: NSCoder) {
        self.data = MainView()
        opponentName.text = pName
        date.text = pDate
        super.init(coder: aDecoder)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
