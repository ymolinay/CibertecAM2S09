//
//  Session09App.swift
//  Session09
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

@main
struct Session09App: App {
    let persistence = Persistence.shared

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
