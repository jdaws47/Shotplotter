//
//  MainView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

class MainView {
    var matches = [MatchView]()
    var sortMode: SortingMode
    var search: String
    var isSearching: Bool
    
    init() {
        sortMode = SortingMode.alphaOpponent
        search = ""
        isSearching = false
    }
    
    func addMatch() {
        matches.append(MatchView())
    }
}
