//
//  QuickMealApp.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI

@main
struct QuickMealApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
