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
            Login().environmentObject(Colors())
                   .environmentObject(Goals())
                   .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            
        }.onChange(of: scenePhase) { _ in
            PersistenceController.shared.save()
        }
    }
}
