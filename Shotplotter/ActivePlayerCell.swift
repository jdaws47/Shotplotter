//
//  ActivePlayerCell.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 1/24/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

//THIS IS THE CELL DATA THAT ALL CELLS IN THE MATCHVIEW TABLE WILL USE

class ActivePlayerCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activeSwitch.isOn = false
    }
}
