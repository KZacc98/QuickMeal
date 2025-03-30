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
    let persistenceController: PersistenceController
    let coordinator: Coordinator
    
    init() {
        self.persistenceController = PersistenceController.shared
        self.coordinator = Coordinator(
            factory: DIContainer(
                apiService: GeminiAPIService(apiKey: ""),
                persistenceController: persistenceController))
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: coordinator)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
