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
    }
    
    func archive(fileName: String) {
        print("Attempting Main archive...")
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                print("Main Data successfully saved to file.")
            } else {
                print("Failed to save Main data")
            }
        } catch {
            print("Failed to save Main data")
        }
    }
    
    func restore(fileName: String) {
        print("Attempting Main restore")
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(
            withFile: archiveURL.path) as? Data {
            do {
                let recoveredData = try PropertyListDecoder().decode(MainView.self, from: recoveredDataCoded)
                //positions = recoveredData.positions
                matches = recoveredData.matches
                sortMode = recoveredData.sortMode
                search = recoveredData.search
                isSearching = recoveredData.isSearching
                print(matches)
                print(sortMode)
                print(search)
                print(isSearching)
                print("Main Data successfully recovered from file.")
            } catch {
                print("Failed to Main recover data")
            }
        } else {
            print("Failed to Main recover data")
        }
    }
    
    func save() {
        archive(fileName: "Plottashot")
    }
	
	func save(asd: Bool) {
		archive(fileName: "Plottashot")
	}
    
    func load() {
        restore(fileName: "Plottashot")
    }
}
