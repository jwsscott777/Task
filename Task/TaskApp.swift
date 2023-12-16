//
//  TaskApp.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI
@main
struct TaskApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var themeSettings = ThemeSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(themeSettings)
        }
    }
}


