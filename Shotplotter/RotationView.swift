//
//  RotationView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

class RotationView {
    var positions = [AnyHashable: PlayerSpot]()
    var activePlayers = [AnyHashable: Player]()
    var rotationID: Int
    var viewMode: Int //0 - Standard, all lines. 1 - Scoring only. 2 = ???. 3 = ???
    var hasSelected: Bool                                //^ Idea: Weighted noise field based on where the lines end
    //INSTANCE VARIABLES NOT COMPLETE. FINISH THIS FIRST.
    
    
    init() { //Make a proper initializer with arguments
        rotationID = -1
        viewMode = 0
        hasSelected = false
    }
}
