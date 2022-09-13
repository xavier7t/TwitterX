//
//  TwitterXApp.swift
//  TwitterX
//
//  Created by Xavier on 9/12/22.
//

import SwiftUI

@main
struct TwitterXApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
