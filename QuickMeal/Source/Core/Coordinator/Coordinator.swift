//
//  Coordinator.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI

@MainActor
class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    
    private let factory: ViewModelFactory
    
    init(factory: ViewModelFactory) {
        self.factory = factory
    }
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .home:
            FoodItemsPager(viewModel: self.factory.makeFoodItemsPagerViewModel())
        case .recipe(recipe: let recipe):
            RecipeView(viewModel: self.factory.makeRecipeViewModel(recipe: recipe))
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .test: Text("test")
        }
    }
    
    //workaround for making viewmodels within the FoodItemsPagerView
    func makeFoodItemsViewModel(for category: FoodCategory) -> FoodItemsViewModel {
        factory.makeFoodItemsViewModel(category: category)
    }
}
