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
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Year().environmentObject(Colors())
                  .environmentObject(Goals())
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
