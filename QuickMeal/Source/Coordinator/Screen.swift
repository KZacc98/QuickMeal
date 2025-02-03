//
//  Screen.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

enum Screen: Hashable, Equatable {
    case home
    case details
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine("home")
        case .details:
            hasher.combine("details")
        }
    }
}
