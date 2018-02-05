//
//  MainView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MainView {
    var matches = [MatchView]() // each element is a different match
    var sortMode: SortingMode
    var search: String
    var isSearching: Bool
    
    init() {
        sortMode = SortingMode.dateEdit
        search = ""
        isSearching = false
        UserDefaults.standard.set(matches, forKey: "matchArray")
    }
    
    // adds a blank match to the end of the array
    func addMatch() {
        matches.append(MatchView())
    }
}
