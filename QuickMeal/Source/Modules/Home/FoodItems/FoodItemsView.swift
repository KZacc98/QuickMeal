//
//  FoodItemsView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI
import CoreData

struct FoodItemsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: FoodItemsViewModel
    @FetchRequest var foodItems: FetchedResults<FoodItem>
    
    var onItemSelected: ((FoodItem) -> Void)?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: FoodItemsViewModel, onItemSelected: ((FoodItem) -> Void)?) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onItemSelected = onItemSelected
        
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        
        if let categoryId = viewModel.categoryId {
            let predicate = NSPredicate(format: "categoryId == %@", categoryId)
            fetchRequest.predicate = predicate
        }
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \FoodItem.name, ascending: true)]
        
        self._foodItems = FetchRequest(fetchRequest: fetchRequest, animation: .default)
    }
    
    var body: some View {
        ScrollView {
            Text(viewModel.category.name ?? "Dupa")
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(foodItems) { item in
                    FoodItemView(name: item.name, imageName: item.image) {
                        onItemSelected?(item)
                    }
                }
            }
            .padding()
        }
    }
}
