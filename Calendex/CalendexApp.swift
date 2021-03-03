//
//  CalendexApp.swift
//  Calendex
//
//  Created by Evan Bacon on 12/26/20.
//

import SwiftUI

@main
struct CalendexApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.preview
    
    var body: some Scene {
        WindowGroup {
            Year(year: 2021).environmentObject(Colors())
                  .environmentObject(Goals())
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
