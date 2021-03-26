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
    
    var body: some Scene {
        WindowGroup {
            NewLogin().environmentObject(Colors())
                      .environmentObject(Goals())
                      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            /*Year(year: 2021).environmentObject(Colors())
                  .environmentObject(Goals())
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)*/
        }.onChange(of: scenePhase) { _ in
            PersistenceController.shared.save()
        }
    }
}
