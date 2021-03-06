//
//  PlayerTableCell.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 1/17/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

//THIS IS THE CELL DATA THAT ALL CELLS IN THE MATCHVIEW TABLE WILL USE

class PlayerTableCell: UITableViewCell {
    
    @IBOutlet weak var name: PlayerTextField!
    @IBOutlet weak var number: PlayerTextField!
    @IBOutlet weak var color: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = ""
    }
}
