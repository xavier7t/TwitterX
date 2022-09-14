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
    let sharedPostViewModel = PostViewModel()
    let ud = UserDefaults.standard
    var body: some Scene {
        WindowGroup {
            
            if ud.bool(forKey: "isLoggedIn") {
                PostView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .onAppear {
                        printFilePath()
                    }
            } else {
                WelcomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .onAppear {
                        printFilePath()
                    }
            }
        }
    }
}

func printFilePath() {
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print(paths[0])
}
