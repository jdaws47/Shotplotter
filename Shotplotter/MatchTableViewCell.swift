//
//  MatchTableViewCell.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 1/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

//THIS IS THE CELL DATA THAT ALL CELLS IN THE MATCHVIEW TABLE WILL USE

class MatchTableViewCell: UITableViewCell {
   
    @IBOutlet weak var title: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
