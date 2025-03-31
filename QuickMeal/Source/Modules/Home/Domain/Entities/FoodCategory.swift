//
//  FoodCategory.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

struct FoodCategory: Identifiable {
    let id: String
    let name: String
    let image: String
    
    init?(id: String?, name: String?, image: String?) {
        guard let id, let name, let image else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

extension FoodCategory {
    static func mock() -> FoodCategory {
        FoodCategory(id: "1", name: "Category Name", image: "hare")
    }
    
    static func mockCollection() -> [FoodCategory] {
        return [
            FoodCategory(id: "1", name: "Category 1", image: "hare"),
            FoodCategory(id: "2", name: "Category 2", image: "star"),
            FoodCategory(id: "3", name: "Category 3", image: "globe"),
            FoodCategory(id: "4", name: "Category 4", image: "document")
        ]
    }
}
