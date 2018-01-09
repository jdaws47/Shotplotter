//
//  globalTableViewCell.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 12/20/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

//THIS IS THE CELL DATA THAT ALL CELLS IN THE MAINVIEW TABLE WILL USE

class GlobalTableViewCell: UITableViewCell {
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    init(pName: String, pDate: String, coder aDecoder: NSCoder) {
        opponentName.text = pName
        date.text = pDate
        super.init(coder: aDecoder)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
