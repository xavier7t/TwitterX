//
//  TwitterXApp.swift
//  TwitterX
//
//  Created by Xavier on 9/12/22.
//

import SwiftUI

@main
struct TwitterXApp: App {
    let persistenceController = DBHelperAuthentication.shared

    var body: some Scene {
        WindowGroup {
            TestView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
