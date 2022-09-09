//
//  DataController.swift
//  Filmzilla
//
//  Created by Павло on 27.08.2022.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Filmzilla")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

