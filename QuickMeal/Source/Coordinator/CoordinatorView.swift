//
//  CoordinatorView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: .home)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
        }
        .environmentObject(coordinator)
    }
}
