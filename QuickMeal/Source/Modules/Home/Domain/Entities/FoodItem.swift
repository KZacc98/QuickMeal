//
//  FoodItem.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import Foundation

struct FoodItem: Identifiable, Equatable {
    let id: UUID
    let name: String
    let categoryId: String
    let image: String
    
    init?(id: UUID?, name: String?, categoryId: String?, image: String?) {
        guard let id, let name, let categoryId, let image else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.categoryId = categoryId
        self.image = image
    }
    
    init(id: UUID, name: String, categoryId: String, image: String) {
        self.id = id
        self.name = name
        self.categoryId = categoryId
        self.image = image
    }
}

extension FoodItem {
    func mock() -> FoodItem {
        FoodItem(
            id: UUID(),
            name: "FoodItem Name",
            categoryId: "1",
            image: "star"
        )
    }
}
