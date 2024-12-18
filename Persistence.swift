//
//  Persistence.swift
//  Session09
//
//  Created by DAMII on 17/12/24.
//

import CoreData

struct Persistence {
    static let shared = Persistence()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Session09")
        container.loadPersistentStores { _, error in
            if let err = error as NSError? {
                fatalError("Error al crear DB: \(err.localizedDescription)")
            }
        }
    }
}
