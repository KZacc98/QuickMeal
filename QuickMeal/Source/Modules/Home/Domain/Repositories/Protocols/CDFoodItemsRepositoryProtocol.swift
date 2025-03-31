//
//  CDFoodItemsRepositoryProtocol.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import Foundation

protocol CDFoodItemsRepositoryProtocol {
    func fetchFoodItems(for categoryId: String?, sortDescriptors: [NSSortDescriptor]) -> [FoodItem]
}
