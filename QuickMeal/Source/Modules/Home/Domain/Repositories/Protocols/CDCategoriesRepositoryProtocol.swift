//
//  CDCategoriesRepositoryProtocol.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//


import Foundation

protocol CDCategoriesRepositoryProtocol {
    func fetchCategories(sortDescriptors: [NSSortDescriptor]) -> [FoodCategory]
}
