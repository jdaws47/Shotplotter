//
//  OrderCell.swift
//  Shotplotter
//
//  Created by DAWSON, JARED on 4/2/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

//THIS IS THE CELL DATA THAT ALL CELLS IN THE ORDERVIEW TABLE WILL USE

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
