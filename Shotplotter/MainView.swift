//
//  MainView.swift
//  Shotplotter
//
//  Created by Zelle Mandez on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class MainView: Codable {
    var matches = [MatchView]() // each element is a different match
    var sortMode: SortingMode
    var search: String
    var isSearching: Bool
    
    init() {
        sortMode = SortingMode.dateEdit
        search = ""
        isSearching = false
        UserDefaults.standard.set(matches, forKey: "matchArray")
        restore(fileName: "Plottashot")
    }
    
    // adds a blank match to the end of the array
    func addMatch() {
        matches.append(MatchView())
        archive(fileName: "Plottashot")
    }
    
    func archive(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                print("Rotation Data successfully saved to file.")
            } else {
                print("Failed to save data...")
            }
        } catch {
            print("Failed to save data...")
        }
    }
    
    func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(
            withFile: archiveURL.path) as? Data {
            do {
                let recoveredData = try PropertyListDecoder().decode(MainView.self, from: recoveredDataCoded)
                print("Data successfully recovered from file.")
                //positions = recoveredData.positions
                matches = recoveredData.matches
                sortMode = recoveredData.sortMode
                search = recoveredData.search
                isSearching = recoveredData.isSearching
            } catch {
                print("Failed to recover data")
            }
        } else {
            print("Failed to recover data")
        }
    }
}
